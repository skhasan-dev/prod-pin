# Pinterest Post Generator API

Node.js + Express + MongoDB + Gemini AI

---

## Setup

1. Clone and install dependencies:
```bash
npm install
```

2. Create a `.env` file (copy from `.env.example`):
```
PORT=3000
MONGODB_URI=mongodb://localhost:27017/pinterest_generator
GEMINI_API_KEY=your_gemini_api_key_here
```

3. Run:
```bash
npm run dev     # development
npm start       # production
```

---

## Base URL
```
http://localhost:3000/api
```

---

## CATEGORY Endpoints

### Create Category
```
POST /categories
```
Body:
```json
{ "name": "Home Decor" }
```
Response:
```json
{
  "success": true,
  "message": "Category created successfully",
  "data": { "_id": "...", "name": "Home Decor", "createdAt": "..." }
}
```

---

### Get All Categories
```
GET /categories
```
Response:
```json
{
  "success": true,
  "data": [{ "_id": "...", "name": "Home Decor" }]
}
```

---

### Delete Category
```
DELETE /categories/:id
```

---

## POST Endpoints

### Create Post (AI Generation Happens Here)
```
POST /posts
```
Body:
```json
{
  "amazon_url": "https://amazon.com/dp/...",
  "affiliated_link": "https://amzn.to/...",
  "image_urls": ["https://...", "https://..."],
  "category": "<category_id>",
  "raw_title": "Original Amazon product title here",
  "raw_description": "Original Amazon product description here",
  "status": "draft",
  "image_generated": "yet_to_generate"
}
```

`raw_title` and `raw_description` are used for AI generation and **never stored**.

Response:
```json
{
  "success": true,
  "message": "Post created successfully",
  "data": {
    "_id": "...",
    "amazon_url": "...",
    "affiliated_link": "...",
    "image_urls": ["..."],
    "category": { "_id": "...", "name": "Home Decor" },
    "pinterest_title": "Transform Your Space with This Stunning Lamp",
    "pinterest_description": "Elevate your home with this gorgeous...",
    "tags": ["homedecor", "lighting", "aesthetic", "interiordesign", "homestyle", "lamp", "decor"],
    "overlay_text": "Light Up Your World",
    "status": "draft",
    "image_generated": "yet_to_generate",
    "createdAt": "...",
    "updatedAt": "..."
  }
}
```

---

### Update Post
```
PUT /posts/:id
```

All fields are optional. AI content is **only regenerated** when `regenerate: true` is passed. When regenerating, `raw_title` and `raw_description` are required.

Body (without regeneration — just update fields):
```json
{
  "status": "ready",
  "image_generated": "generated",
  "affiliated_link": "https://amzn.to/new-link"
}
```

Body (with regeneration):
```json
{
  "regenerate": true,
  "raw_title": "Updated product title",
  "raw_description": "Updated product description",
  "category": "<category_id>"
}
```

---

### Get All Posts
```
GET /posts
```

Query parameters (all optional):

| Param | Type | Example | Notes |
|---|---|---|---|
| `status` | string | `draft,published` | Comma-separated, multiple values |
| `category` | string | `id1,id2` | Comma-separated category IDs |
| `image_generated` | string | `yet_to_generate,generated` | Comma-separated |
| `date_from` | ISO date | `2024-01-01` | Filter by createdAt >= |
| `date_to` | ISO date | `2024-12-31` | Filter by createdAt <= |
| `page` | number | `1` | Default: 1 |
| `limit` | number | `20` | Default: 20 |

Example:
```
GET /posts?status=draft,ready&category=abc123&page=1&limit=10
```

Response:
```json
{
  "success": true,
  "data": [...],
  "pagination": {
    "total": 45,
    "page": 1,
    "limit": 10,
    "totalPages": 5
  }
}
```

---

### Get One Post
```
GET /posts/:id
```

---

### Delete One Post
```
DELETE /posts/:id
```

---

### Delete Many Posts
```
DELETE /posts/bulk
```
Body:
```json
{
  "ids": ["id1", "id2", "id3"]
}
```
Response:
```json
{
  "success": true,
  "message": "3 post(s) deleted successfully",
  "deletedCount": 3
}
```

---

## Enums Reference

**status:** `draft` | `ready` | `published`

**image_generated:** `yet_to_generate` | `partially_generated` | `generated`

---

## Error Responses

All errors follow this shape:
```json
{
  "success": false,
  "message": "Description of what went wrong"
}
```

| Code | Meaning |
|---|---|
| 400 | Bad request / missing required fields |
| 404 | Resource not found |
| 409 | Duplicate (e.g. category name already exists) |
| 500 | Server / AI generation error |
