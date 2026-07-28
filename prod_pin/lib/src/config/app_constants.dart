class AppConstants {
  AppConstants._();

  static const String baseUrl = 'http://localhost:3000/api';
  static const int paginationLimit = 20;
  static const String appName = 'ProdPin';
}

class PostStatus {
  PostStatus._();

  static const draft = 'draft';
  static const ready = 'ready';
  static const published = 'published';

  static const all = [draft, ready, published];

  static String label(String value) {
    switch (value) {
      case ready:
        return 'Ready';
      case published:
        return 'Published';
      case draft:
      default:
        return 'Draft';
    }
  }
}

class ImageGenerated {
  ImageGenerated._();

  static const yetToGenerate = 'yet_to_generate';
  static const partiallyGenerated = 'partially_generated';
  static const generated = 'generated';

  static const all = [yetToGenerate, partiallyGenerated, generated];

  static String label(String value) {
    switch (value) {
      case partiallyGenerated:
        return 'Partially Generated';
      case generated:
        return 'Generated';
      case yetToGenerate:
      default:
        return 'Yet to Generate';
    }
  }

  static String next(String value) {
    switch (value) {
      case yetToGenerate:
        return partiallyGenerated;
      case partiallyGenerated:
        return generated;
      case generated:
      default:
        return yetToGenerate;
    }
  }
}
