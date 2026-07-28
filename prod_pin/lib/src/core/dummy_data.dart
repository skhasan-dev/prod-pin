import 'package:prod_pin/src/core/index.dart';

import '../config/app_constants.dart';
import '../features/category/data/entities/category.dart';
import '../features/pin/data/entities/post.dart';

final dummyCategories = <Category>[
  Category(
    id: 'cat_1',
    name: 'Home Decor',
    coverImage:
        'https://images.unsplash.com/photo-1555041469-a586c61ea9bc?w=800',
    maxPins: 20,
    createdAt: DateTime(2024, 6, 1),
  ),
  Category(
    id: 'cat_2',
    name: 'Fashion',
    coverImage:
        'https://images.unsplash.com/photo-1558618666-fcd25c85cd64?w=800',
    maxPins: 15,
    createdAt: DateTime(2024, 6, 15),
  ),
  Category(
    id: 'cat_3',
    name: 'Kitchen',
    coverImage:
        'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=800',
    maxPins: null,
    createdAt: DateTime(2024, 7, 1),
  ),
  Category(
    id: 'cat_4',
    name: 'Fitness',
    coverImage:
        'https://images.unsplash.com/photo-1534438327276-14e5300c3a48?w=800',
    maxPins: 10,
    createdAt: DateTime(2024, 7, 20),
  ),
];

const _statusCycle = [
  PostStatus.draft,
  PostStatus.draft,
  PostStatus.ready,
  PostStatus.ready,
  PostStatus.published,
  PostStatus.published,
];

const _imageGenCycle = [
  ImageGenerated.yetToGenerate,
  ImageGenerated.partiallyGenerated,
  ImageGenerated.generated,
  ImageGenerated.yetToGenerate,
  ImageGenerated.partiallyGenerated,
  ImageGenerated.generated,
];

final List<Map<String, dynamic>> _postTemplates = [
  {
    'title': 'Transform Your Space with This Bamboo Lamp',
    'desc':
        'Elevate your home with this stunning handcrafted bamboo table lamp. Perfect for cozy bedrooms and living rooms.',
    'tags': [
      'homedecor',
      'bamboolamp',
      'aesthetic',
      'cozyhome',
      'lighting',
      'interiordesign',
      'decor',
    ],
    'overlay': 'Light Up Your World',
    'asin': 'B09XK5YJLM',
    'images': [
      'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=400',
      'https://images.unsplash.com/photo-1524484485831-a92ffc0de03f?w=400',
    ],
  },
  {
    'title': 'Cozy Up with This Chunky Knit Throw Blanket',
    'desc':
        'Wrap yourself in warmth with this ultra-soft chunky knit throw. A statement piece for any living room.',
    'tags': [
      'throwblanket',
      'cozyvibes',
      'homedecor',
      'knit',
      'livingroom',
      'winterhome',
      'aesthetic',
    ],
    'overlay': 'Cozy Season Essentials',
    'asin': 'B08KNTHRW2',
    'images': [
      'https://images.unsplash.com/photo-1522708323590-d24dbb6b0267?w=400',
      'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?w=400',
    ],
  },
  {
    'title': 'Boho Rattan Wall Mirror That Steals the Show',
    'desc':
        'This handwoven rattan mirror adds instant boho charm to any wall. Lightweight and easy to hang.',
    'tags': [
      'bohodecor',
      'wallmirror',
      'rattan',
      'homestyle',
      'accentpiece',
      'decorinspo',
      'aesthetic',
    ],
    'overlay': 'Mirror, Mirror on the Wall',
    'asin': 'B07RATMIR9',
    'images': [
      'https://images.unsplash.com/photo-1618220179428-22790b461013?w=400',
      'https://images.unsplash.com/photo-1618221469555-7f3ad97540d6?w=400',
    ],
  },
  {
    'title': 'Minimalist Ceramic Vase Set for Modern Homes',
    'desc':
        'A set of 3 ceramic vases in matte finish, perfect for dried flowers or as standalone decor.',
    'tags': [
      'ceramicvase',
      'minimalist',
      'moderndecor',
      'homestyling',
      'vaseset',
      'aesthetichome',
      'decor',
    ],
    'overlay': 'Simple. Elegant. Timeless.',
    'asin': 'B06VASESET',
    'images': [
      'https://images.unsplash.com/photo-1578500494198-246f612d3b3d?w=400',
      'https://images.unsplash.com/photo-1578500351865-fa9998d46e8b?w=400',
    ],
  },
  {
    'title': 'Layered Gold Necklace Set You Need Now',
    'desc':
        'Effortlessly chic layered necklace set in 18k gold plating. Dainty, durable, and hypoallergenic.',
    'tags': [
      'goldjewelry',
      'necklaceset',
      'layerednecklace',
      'fashionfinds',
      'jewelrylove',
      'ootdstyle',
      'accessories',
    ],
    'overlay': 'Layer It Up',
    'asin': 'B09GOLDNK1',
    'images': [
      'https://images.unsplash.com/photo-1611591437281-460bfbe1220a?w=400',
      'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=400',
    ],
  },
  {
    'title': 'Oversized Blazer Perfect for Fall Layering',
    'desc':
        'This oversized blazer is a wardrobe staple, easily dressed up or down for any occasion.',
    'tags': [
      'blazer',
      'falloutfit',
      'streetstyle',
      'ootd',
      'fashionista',
      'wardrobestaple',
      'style',
    ],
    'overlay': 'Fall Layering Done Right',
    'asin': 'B08BLAZER3',
    'images': [
      'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=400',
      'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=400',
    ],
  },
];

List<Post> _buildPostsForCategory(Category category, int startIndex) {
  return List.generate(6, (i) {
    final template = _postTemplates[i % _postTemplates.length];
    final index = startIndex + i;
    return Post(
      id: 'post_$index',
      amazonUrl: 'https://amazon.in/dp/${template['asin']}',
      affiliatedLink: 'https://amzn.to/3x${template['asin']}',
      imageUrls: List<String>.from(template['images'] as List),
      category: category,
      pinterestTitle: template['title'] as String,
      pinterestDescription: template['desc'] as String,
      tags: List<String>.from(template['tags'] as List),
      overlayText: template['overlay'] as String,
      status: PinStatus.values[i],
      imageGenerated: PinImageGenerationStatus.values[i],
      createdAt: DateTime(2024, 8, 1).add(Duration(days: index)),
      updatedAt: DateTime(2024, 8, 2).add(Duration(days: index)),
    );
  });
}

final dummyPosts = <Post>[
  ..._buildPostsForCategory(dummyCategories[0], 1),
  ..._buildPostsForCategory(dummyCategories[1], 7),
  ..._buildPostsForCategory(dummyCategories[2], 13),
  ..._buildPostsForCategory(dummyCategories[3], 19),
];
