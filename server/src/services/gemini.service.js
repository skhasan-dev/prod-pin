const { GoogleGenerativeAI } = require("@google/generative-ai");

const genAI = new GoogleGenerativeAI(process.env.GEMINI_API_KEY);

const generatePinterestContent = async ({ title, description, category }) => {
  const model = genAI.getGenerativeModel({ model: "gemini-2.5-flash" });

  const prompt = `
You are a Pinterest marketing expert. Based on the product details below, generate Pinterest-ready content.

Product Title: ${title}
Product Description: ${description}
Category: ${category}

Generate the following and respond ONLY with a valid JSON object — no markdown, no backticks, no extra text:

{
  "pinterest_title": "Catchy Pinterest title under 100 characters including spaces",
  "pinterest_description": "SEO-optimized Pinterest description under 500 characters. Engaging, keyword-rich, includes a soft call to action.",
  "tags": ["#tag1", "#tag2", "#tag3", "#tag4", "#tag5", "#tag6", "#tag7"],
  "overlay_text": "3 to 6 word catchy phrase for image overlay"
}

Rules:
- pinterest_title: max 100 characters, punchy and engaging
- pinterest_description: max 500 characters, natural tone, include relevant keywords
- tags: exactly 7 tags, lowercase, no spaces, no # symbol, relevant to the product and category
- overlay_text: 3–6 words only, short and impactful, suitable as text overlay on a product image
`;

  const result = await model.generateContent(prompt);
  const text = result.response.text().trim();

  // Strip markdown code fences if Gemini wraps in them
  const cleaned = text.replace(/^```json\s*/i, "").replace(/```\s*$/i, "").trim();

  const parsed = JSON.parse(cleaned);

  // Enforce hard limits as a safety net
  return {
    pinterest_title: parsed.pinterest_title?.slice(0, 100) ?? null,
    pinterest_description: parsed.pinterest_description?.slice(0, 500) ?? null,
    tags: Array.isArray(parsed.tags) ? parsed.tags.slice(0, 7) : [],
    overlay_text: parsed.overlay_text ?? null,
  };
};

module.exports = { generatePinterestContent };
