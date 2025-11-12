class ApiConstants {
  //! SPEARE ME APPLICATION
  static const String baseUrl =
      'https://nonsudsing-worked-simona.ngrok-free.dev/';

  //! AUTHENTICATION
  static const String login = '/api/auth/login';
  static const String register = '/api/auth/signup';
  static const String logout = '/api/auth/logout';

  //! owner API
  static const String createCentralOfficer = '/api/users/add/central-officer';
  static const String createFactory = '/api/users/create/factory';
  static const String getCentralOffice = '/api/users/get/central-offices';
  static const String getFactories = "/api/users/get/factories";
  static const String getEmployees = "/api/users/get/all/employees";
  static const String createPlantHead = "/api/users/create/plant-head";
  static const String getProfile = "/api/users/get/profile";
  static const String uploadProfileImage = '/api/users/profile/upload-image';
  //!get merchandise missing,update merchandise mssing,delete mercandise ,restock merchandise

  //! owner products API's
  static const String createProductCategory = '/api/product-category/create';
  static const String updateProductCategory = '/api/product-category/update/';
  static const String getProductCategory =
      '/api/product-category/get/categories';
  static const String deleteProductCategory = '/api/product-category/delete';
  static const String uploadProduct = '/api/products/upload';
  static const String getProducts = '/api/products';
  static const String deleteProduct = '/api/products/delete';

  //! OWNER MERCHANDISE API'S
  static const String addMerchandise = '/api/users/add/merchandise';
  static const String updateMerchandise = '/api/users/update/merchandise';
  static const String deleteMerchandise = '/api/users/delete/merchandise';
  static const String getAllMerchandise = '/api/users/all/merchandise';
  static const String restockMerchandise = '/api/owner/restock';

  //! plant head api's
  static const String plantHeadCreateBay = "/api/users/create/bay";
  static const String plantHeadCreateEmployee =
      "/api/users/add/factory/employees";
  static const String plantHeadGetBays = "/api/users/get/bays";
  static const String plantHeadGetEmployees =
      "/api/users/get/factory/employees";
  static const String plantHeadGetProducts = '/api/users/factory/products';
  static const String plantHeadGetLowStockProducts =
      '/api/users/factory/low-stock';
}
