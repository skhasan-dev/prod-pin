// Temporary seed script — run once to populate dev/test DB.
// Usage: node src/seed.js
// Remove this file before shipping to production.

require("dotenv").config();
const mongoose = require("mongoose");
const connectDB = require("./config/db");
const Category = require("./models/Category");
const Post = require("./models/Post");

// ---------------------------------------------------------------------------
// Data extracted from "Product Details.xlsx" (20 posts, 2 categories).
// pinterest_description values are truncated to 500 chars to match schema.
// tags capped at 7 per post to match schema validation.
// ---------------------------------------------------------------------------
const seedData = {
  "Wall Hanging": [
    {
      amazon_url: "https://amzn.in/d/0aKQueqs",
      pinterest_title:
        "Modern Floating Wall Shelves Set of 3 | Stylish Wall Decor for Living Room & Bedroom",
      pinterest_description:
        "Transform empty walls into beautiful focal points with this modern floating wall shelves set of 3. These white display shelves with elegant brown back panels are perfect for decorating your living room, bedroom, office, hallway, or entryway.\n\nDisplay your favorite plants, candles, books, perfumes, photo frames, collectibles, or small décor pieces while keeping your space organized. The minimalist design complements modern, Scandinavian, boho, and contemporary interiors, making these floating ...",
      tags: [
        "FloatingShelves",
        "HomeDecor",
        "WallDecor",
        "LivingRoomDecor",
        "BedroomDecor",
        "InteriorDesign",
        "HomeOrganization",
      ],
    },
    {
      amazon_url: "https://amzn.in/d/0j3R8Uxa",
      pinterest_title:
        "Tree Floating Wall Shelves | Modern Wooden Wall Decor for Living Room, Bedroom & Kitchen",
      pinterest_description:
        "Add style and storage to any room with this tree-shaped floating wall shelf. Designed with a modern wooden finish, it's perfect for displaying plants, books, candles, photo frames, collectibles, and everyday décor while maximizing vertical space.\n\nWhether you're decorating your living room, bedroom, kitchen, bathroom, or entryway, this unique wall-mounted shelf brings both functionality and elegance. Its eye-catching tree-inspired design creates a beautiful focal point while helping keep your...",
      tags: [
        "WallShelves",
        "FloatingShelves",
        "TreeWallShelf",
        "HomeDecor",
        "LivingRoomDecor",
        "BedroomDecor",
        "InteriorDesign",
      ],
    },
    {
      amazon_url: "https://amzn.in/d/03L24LRe",
      pinterest_title:
        "5-Tier Corner Floating Shelf | Modern Wall Shelf for Living Room, Bedroom & Home Office",
      pinterest_description:
        "Make the most of every corner with this 5-tier corner floating shelf. Designed to maximize unused wall space, this modern wooden shelf is perfect for displaying plants, books, candles, photo frames, collectibles, and decorative accents without taking up valuable floor space.\n\nIts sleek floating design and rich wood finish blend beautifully with modern, minimalist, Scandinavian, and contemporary interiors. Whether you're styling a living room, bedroom, home office, study, or apartment, this co...",
      tags: [
        "CornerShelf",
        "FloatingShelves",
        "HomeDecor",
        "LivingRoomDecor",
        "HomeOffice",
        "SmallSpaceLiving",
        "InteriorDesign",
      ],
    },
    {
      amazon_url: "https://amzn.in/d/0b98sHRF",
      pinterest_title:
        "Floating Wall Shelves Set of 4 | Modern Wooden Wall Decor for Living Room, Bedroom & Kitchen",
      pinterest_description:
        "Refresh your home with this set of 4 modern floating wall shelves designed to add both style and functionality. Perfect for displaying plants, books, candles, photo frames, artwork, spices, or decorative accessories while making the most of your wall space.\n\nWhether you're decorating your living room, bedroom, kitchen, hallway, office, or dining area, these wooden floating shelves create a clean, minimalist look that complements modern, Scandinavian, boho, and contemporary interiors.\n\nEasy to...",
      tags: [
        "FloatingShelves",
        "WallDecor",
        "HomeDecor",
        "LivingRoomDecor",
        "BedroomDecor",
        "KitchenDecor",
        "InteriorDesign",
      ],
    },
    {
      amazon_url: "https://amzn.in/d/0aE9gD4c",
      pinterest_title:
        "Modern Floating Wall Shelves with Black Metal Brackets | Bathroom, Living Room & Kitchen Decor",
      pinterest_description:
        "Bring modern style and practical storage to your home with these floating wall shelves featuring black metal brackets and white wooden shelves. The clean black-and-white design complements modern, industrial, Scandinavian, and minimalist interiors while adding extra storage without taking up floor space.\n\nPerfect for displaying plants, candles, books, photo frames, bathroom essentials, kitchen spices, or decorative accents in your living room, bathroom, bedroom, kitchen, hallway, or home offi...",
      tags: [
        "FloatingShelves",
        "ModernHome",
        "WallDecor",
        "BathroomDecor",
        "LivingRoomDecor",
        "HomeOrganization",
        "InteriorDesign",
      ],
    },
    {
      amazon_url: "https://amzn.in/d/09sqgVqI",
      pinterest_title:
        "Rustic Floating Wall Shelves with Ledge | Modern Wall Decor for Bathroom, Bedroom & Living Room",
      pinterest_description:
        "Add warmth and functionality to your home with these rustic floating wall shelves featuring a raised ledge to keep your décor securely in place. Perfect for displaying plants, books, photo frames, candles, bathroom essentials, spices, or collectibles while creating a clean, organized look.\n\nDesigned with a timeless rustic wood finish, these wall-mounted shelves blend effortlessly with farmhouse, rustic, industrial, modern, and minimalist interiors. Ideal for your living room, bedroom, bathroo...",
      tags: [
        "RusticDecor",
        "FloatingShelves",
        "FarmhouseDecor",
        "WallDecor",
        "HomeDecor",
        "BathroomDecor",
        "LivingRoomDecor",
      ],
    },
    {
      amazon_url: "https://amzn.in/d/04PGZJbQ",
      pinterest_title:
        "6-Pack Wall Mounted Spice Rack Organizer | Kitchen Storage for Cabinets & Pantry",
      pinterest_description:
        "Keep your kitchen neat and organized with this 6-pack wall mounted spice rack organizer. Designed to maximize cabinet, pantry, or wall space, these sleek acrylic spice racks make it easy to store and access your favorite spice jars, seasonings, herbs, and everyday essentials.\n\nThe modern space-saving design is perfect for small kitchens, apartments, RVs, pantries, and kitchen cabinets, helping you reduce countertop clutter while creating a clean, organized cooking space. Durable, easy to inst...",
      tags: [
        "KitchenOrganization",
        "SpiceRack",
        "PantryOrganization",
        "KitchenStorage",
        "HomeOrganization",
        "OrganizedKitchen",
        "SmallKitchen",
      ],
    },
    {
      amazon_url: "https://amzn.in/d/072bTly3",
      pinterest_title:
        "Boho Macrame Hanging Shelf | Floating Wall Decor for Bedroom, Living Room & Nursery",
      pinterest_description:
        "Bring warmth and texture to your home with this boho macrame hanging shelf crafted from handwoven cotton rope and natural pine wood. Perfect for displaying small plants, candles, photo frames, books, crystals, and decorative accents, this floating shelf creates a cozy, Pinterest-worthy space in minutes.\n\nWhether you're decorating a bedroom, living room, nursery, apartment, or dorm room, its elegant bohemian design blends beautifully with boho, Scandinavian, minimalist, and modern interiors. E...",
      tags: [
        "BohoDecor",
        "Macrame",
        "WallDecor",
        "BohoHome",
        "FloatingShelf",
        "BedroomDecor",
        "HomeDecor",
      ],
    },
    {
      amazon_url: "https://amzn.in/d/0ggJCcaS",
      pinterest_title:
        "3-Tier Corner Floating Shelf | Modern Wall Shelf for Living Room & Bedroom Decor",
      pinterest_description:
        "Turn unused corners into beautiful display spaces with this 3-tier corner floating shelf. Its modern wall-mounted design is perfect for showcasing plants, candles, books, photo frames, collectibles, and decorative accents while keeping your home organized and clutter-free.\n\nDesigned to maximize vertical space, this stylish corner shelf fits seamlessly into your living room, bedroom, office, dining room, or apartment, making it an ideal solution for small spaces. The clean white finish complem...",
      tags: [
        "CornerShelf",
        "FloatingShelves",
        "HomeDecor",
        "LivingRoomDecor",
        "BedroomDecor",
        "SmallSpaceLiving",
        "ModernHome",
      ],
    },
    {
      amazon_url: "https://amzn.in/d/05nzkhyP",
      pinterest_title:
        "U-Shaped Floating Wall Shelves Set of 3 | Modern Wall Decor for Living Room & Bedroom",
      pinterest_description:
        "Upgrade your walls with this set of 3 U-shaped floating wall shelves designed to combine modern style with practical storage. Perfect for displaying books, plants, photo frames, candles, collectibles, and decorative accents, these versatile shelves help keep your home organized while creating a beautiful focal point.\n\nThe sleek U-shaped design complements modern, minimalist, Scandinavian, industrial, and contemporary interiors, making them ideal for your living room, bedroom, bathroom, kitche...",
      tags: [
        "FloatingShelves",
        "WallShelves",
        "WallDecor",
        "HomeDecor",
        "LivingRoomDecor",
        "BedroomDecor",
        "ModernHome",
      ],
    },
  ],
  "Pen Holder": [
    {
      amazon_url: "https://amzn.in/d/0f0KqQ5b",
      pinterest_title:
        "Desk Organizer with Pen Holder & Self-Watering Plant Pot | Modern Office Desk Accessories",
      pinterest_description:
        "Keep your workspace neat, stylish, and productive with this multi-functional desk organizer featuring a pen holder, self-watering plant pot, smartphone stand, glasses holder, and key organizer. Designed to reduce desk clutter while keeping your everyday essentials within easy reach.\n\nPerfect for home offices, study desks, students, professionals, and work-from-home setups, this compact desk station helps organize pens, pencils, phones, glasses, headphones, keys, and more. The built-in self-wa...",
      tags: [
        "DeskOrganizer",
        "DeskSetup",
        "OfficeAccessories",
        "Workspace",
        "HomeOffice",
        "StudyDesk",
        "Productivity",
      ],
    },
    {
      amazon_url: "https://amzn.in/d/05vzokk1",
      pinterest_title:
        "LED Study Table Lamp with Pen & Phone Holder | Rechargeable Desk Lamp for Students",
      pinterest_description:
        "Brighten your workspace with this rechargeable LED study table lamp featuring 3 color lighting modes, adjustable brightness, a flexible gooseneck, and built-in pen & phone holders. Designed to save space while keeping your desk organized, it's perfect for studying, reading, online classes, or working from home.\n\nThe eye-friendly LED lighting helps reduce eye strain during long study sessions, while the rechargeable design makes it easy to use anywhere without messy cables. Whether you're crea...",
      tags: [
        "StudyLamp",
        "DeskSetup",
        "DeskAccessories",
        "StudentEssentials",
        "HomeOffice",
        "Workspace",
        "StudyRoom",
      ],
    },
    {
      amazon_url: "https://amzn.in/d/03vO7L3v",
      pinterest_title:
        "360° Rotating Desk Organizer | Marble Pen Holder for Office & Study Table",
      pinterest_description:
        "Keep your workspace clean and productive with this 360° rotating desk organizer featuring a premium marble finish and smart double-deck design. The swivel organizer makes it easy to access pens, markers, scissors, sticky notes, USB drives, and everyday office essentials with a simple spin.\n\nPerfect for home offices, study desks, workstations, students, professionals, and creators, this modern desk organizer combines elegant style with practical storage. Its compact design saves desk space whi...",
      tags: [
        "DeskOrganizer",
        "DeskSetup",
        "OfficeAccessories",
        "Workspace",
        "HomeOffice",
        "DeskDecor",
        "Productivity",
      ],
    },
    {
      amazon_url: "https://amzn.in/d/0iHlN8Ss",
      pinterest_title:
        "Personalized Wooden Desk Organizer with Clock | Pen Holder, Phone & Business Card Stand",
      pinterest_description:
        "Upgrade your workspace with this personalized wooden desk organizer featuring a built-in quartz clock, pen holder, phone stand, and business card holder. Customize it with your name, designation, or company logo to create a professional desk accessory that's both practical and stylish.\n\nPerfect for office desks, home offices, executives, entrepreneurs, teachers, and professionals, this all-in-one organizer keeps your daily essentials neatly arranged while adding an elegant touch to any worksp...",
      tags: [
        "DeskOrganizer",
        "PersonalizedGift",
        "OfficeAccessories",
        "ExecutiveDesk",
        "Workspace",
        "HomeOffice",
        "CorporateGifts",
      ],
    },
    {
      amazon_url: "https://amzn.in/d/02kCg9AX",
      pinterest_title:
        "Personalized Wooden Desk Organizer | Pen Holder, Remote & Business Card Stand",
      pinterest_description:
        "Keep your workspace organized with this personalized wooden desk organizer designed to store pens, pencils, business cards, TV remotes, and other everyday essentials in one stylish place. Its clean wooden finish adds a modern, professional touch to any office desk, study table, or home workspace.\n\nWhether you're working from home, studying, or setting up an executive office, this compact organizer helps reduce clutter while keeping everything within easy reach. Personalize it to create a uniq...",
      tags: [
        "DeskOrganizer",
        "PersonalizedDesk",
        "OfficeAccessories",
        "Workspace",
        "DeskSetup",
        "HomeOffice",
        "OfficeDecor",
      ],
    },
    {
      amazon_url: "https://amzn.in/d/09jCdf1T",
      pinterest_title:
        "Cute Coat Pen Holder | Creative Desk Organizer for Office & Study Table",
      pinterest_description:
        "Add personality to your workspace with this coat-shaped pen holder that combines creative design with everyday functionality. Perfect for organizing pens, pencils, markers, scissors, and other desk essentials while giving your office or study table a fun, modern touch.\n\nCrafted from durable, lightweight material with a scratch-resistant finish, this unique desk organizer is ideal for home offices, study desks, creative workspaces, classrooms, and gaming setups. Its compact size makes it a sty...",
      tags: [
        "DeskOrganizer",
        "CuteDeskAccessories",
        "PenHolder",
        "DeskSetup",
        "Workspace",
        "OfficeDecor",
        "StudyDesk",
      ],
    },
    {
      amazon_url: "https://amzn.in/d/0bVu1w97",
      pinterest_title:
        "Wooden Desk Organizer with Calendar, Clock & Phone Holder | Office Desk Accessories",
      pinterest_description:
        "Stay organized and productive with this 6-in-1 wooden desk organizer featuring a built-in 2026 calendar, clock, phone holder, pen stand, business card holder, and storage compartment. Designed to keep your workspace tidy, it combines everyday functionality with a sleek, modern wooden finish.\n\nPerfect for office desks, home offices, study tables, reception desks, and work-from-home setups, this all-in-one organizer keeps pens, stationery, business cards, your smartphone, sticky notes, and othe...",
      tags: [
        "DeskOrganizer",
        "OfficeAccessories",
        "DeskSetup",
        "HomeOffice",
        "Workspace",
        "Productivity",
        "OfficeDecor",
      ],
    },
    {
      amazon_url: "https://amzn.in/d/0iIi508x",
      pinterest_title:
        "Cute Elephant Pen Holder | 3D Printed Desk Organizer for Office & Study Table",
      pinterest_description:
        "Bring personality to your workspace with this cute elephant pen holder, a unique 3D-printed desk organizer that keeps your pens, pencils, markers, and stationery neatly organized while adding a playful touch to your desk.\n\nPerfect for students, teachers, home offices, study tables, kids' rooms, and creative workspaces, this charming elephant organizer doubles as both functional desk storage and stylish décor. Its modern matte finish and adorable design make it a thoughtful gift for stationery...",
      tags: [
        "DeskOrganizer",
        "ElephantDecor",
        "CuteDeskAccessories",
        "PenHolder",
        "DeskSetup",
        "Workspace",
        "Stationery",
      ],
    },
    {
      amazon_url: "https://amzn.in/d/04LzazDQ",
      pinterest_title:
        "Digital Desk Clock with Pen Holder & Phone Stand | Rechargeable LED Desk Organizer",
      pinterest_description:
        "Upgrade your workspace with this 4-in-1 digital desk clock featuring a built-in pen holder, phone stand, and rechargeable ambient LED night light. Designed to keep your desk organized while adding soft, customizable lighting, it's perfect for studying, working, reading, or creating a relaxing bedside setup.\n\nChoose from warm, neutral, or cool lighting to match your mood, while the touch controls and cordless rechargeable design make it easy to use anywhere. Whether on your office desk, study ...",
      tags: [
        "DeskSetup",
        "DeskOrganizer",
        "DigitalClock",
        "OfficeAccessories",
        "Workspace",
        "HomeOffice",
        "Productivity",
      ],
    },
    {
      amazon_url: "https://amzn.in/d/05BvFDHQ",
      pinterest_title:
        "Ninja Pen Holder | 3D Printed Samurai Desk Organizer for Office & Gaming Setup",
      pinterest_description:
        "Level up your desk with this Ninja Samurai pen holder, a unique 3D-printed desk organizer that blends functionality with eye-catching design. Perfect for holding your favorite pen while adding personality to your office desk, gaming setup, study table, or creative workspace.\n\nMade from durable PLA material, this compact organizer is ideal for gamers, anime fans, students, professionals, writers, and collectors looking to create a stylish and clutter-free desk. Whether you're building an aesth...",
      tags: [
        "GamingSetup",
        "DeskSetup",
        "NinjaDecor",
        "DeskOrganizer",
        "AnimeDecor",
        "OfficeAccessories",
        "GamerRoom",
      ],
    },
  ],
};

async function seedDatabase() {
  await connectDB();

  console.log("Clearing existing posts and categories...");
  await Post.deleteMany({});
  await Category.deleteMany({});

  for (const [categoryName, posts] of Object.entries(seedData)) {
    console.log(`\nCreating category: ${categoryName}`);
    const category = await Category.create({
      name: categoryName,
      totalPins: 0,
    });

    const postDocs = posts.map((p) => ({ ...p, category: category._id }));
    const created = await Post.insertMany(postDocs);

    await Category.findByIdAndUpdate(category._id, {
      totalPins: created.length,
    });

    console.log(
      `  Created ${created.length} posts for "${categoryName}" (id: ${category._id})`
    );
  }

  console.log("\nSeed complete.");
  await mongoose.disconnect();
}

seedDatabase().catch((err) => {
  console.error("Seed failed:", err);
  process.exit(1);
});
