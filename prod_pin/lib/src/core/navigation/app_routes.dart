class AppRoutes {
  AppRoutes._();

  static const home = '/';
  static const addCategory = '/category/add';
  static const editCategory = '/category/:id/edit';
  static const categoryDetail = '/category/:id';
  static const addPin = '/pin/add';
  static const pinDetail = '/pin/:id';
  static const editPin = '/pin/:id/edit';

  static String editCategoryPath(String id) => '/category/$id/edit';
  static String categoryDetailPath(String id) => '/category/$id';
  static String addPinPath(String categoryId) =>
      '/pin/add?categoryId=$categoryId';
  static String pinDetailPath(String id) => '/pin/$id';
  static String editPinPath(String id) => '/pin/$id/edit';
}
