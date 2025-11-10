// ignore: avoid_classes_with_only_static_members
class ApiConstants {
  //! SPEARE ME APPLICATION
  static const String baseUrl =
      'https://nonsudsing-worked-simona.ngrok-free.dev/';
  //! login
  static const String login = '/api/auth/login';

  //! distributor sign Up
  static const String register = '/api/auth/signup';

  //! owner API
  static const String createCentralOfficer = '/api/owner/add-officer';
  static const String createFactory = '/api/owner/create/factory';
  static const String getCentralOffice = '/api/owner/get/central-offices';
  static const String getFactories = "/api/owner/get/factories";
  static const String getEmployees = "/api/owner/get/employees";
  static const String createPlantHead = "/api/owner/create/plant-head";
  static const String getProfile = "/api/profile/users/get/profile";
  static const String uploadProfileImage = '/api/profile/users/upload-image';

  //! owner products API's
  static const String createProductCategory = '/api/product-category/create';
  static const String updateProductCategory = '/api/product-category/update/';
  static const String getProductCategory =
      '/api/product-category/get/categories';
  static const String deleteProductCategory = '/api/product-category/delete';
  static const String uploadProduct = '/api/products/upload';
  static const String getProducts = '/api/products';
  static const String deleteProduct = '/api/products/delete';

  //! plant head api's
  static const String plantHeadCreateBay = "/api/plant-head/bays";
  static const String plantHeadCreateEmployee = "/api/plant-head/add/employees";
  static const String plantHeadGetBays = "/api/plant-head/get/bays";
}
