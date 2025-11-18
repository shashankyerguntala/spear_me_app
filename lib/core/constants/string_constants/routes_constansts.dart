class RoutesConstants {
  //! authentication
  static const loginRoute = '/login';
  static const registerRoute = '/register';

  //! OWNER ROOT ROUTES (full paths)
  static const ownerHomeRoute = '/owner/dashboard';
  static const ownerFactoriesRoute = '/owner/factories';
  static const ownerCentralOfficesRoute = '/owner/central-office';
  static const ownerEmployeesRoute = '/owner/employees';
  static const ownerProductsRoute = '/owner/products';
  static const ownerProfileRoute = '/owner/profile';
  static const ownerMerchandise = '/owner/merchandise';
  static const ownerToolsRoutes = '/owner/tools';

  //! --- FIXED: NESTED ROUTES MUST BE RELATIVE ---
  static const ownerAddFactoriesRoute = 'add';
  static const ownerAddCentralOfficeRoute = 'add';
  static const ownerAddProducts = 'add-product';
  static const ownerAddCategory = 'add-category';
  static const createPlantHead = 'create-plant-head';
  static const ownerAddMerchandise = 'add';
  static const ownerAddTools = 'add';

  //! FACTORY DETAILS (nested under /owner/factories)
  static const factoryDetails = 'details';

  //! PLANT HEAD ROOT ROUTES
  static String plantHeadHomeRoute = '/plant-head/dashboard';
  static String plantHeadRequestsRoute = '/plant-head/requests';
  static String plantHeadCreateRoute = '/plant-head/create';
  static String plantHeadToolsRoute = '/plant-head/tools';
  static String plantHeadProfileRoute = '/plant-head/profile';
  static String plantHeadEmployeesRoute = '/plant-head/employees';
  static String plantHeadProductsRoute = '/plant-head/products';
}
