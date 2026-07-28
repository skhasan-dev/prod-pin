class Endpoints {
  Endpoints._();

  static const categories = '/categories';
  static String categoryById(String id) => '/categories/$id';

  static const posts = '/posts';
  static String postById(String id) => '/posts/$id';
  static const postsBulkDelete = '/posts/bulk';
}
