class RoutesConstants {
  //! authentication
  static const loginRoute = '/login';
  static const registerRoute = '/register';

  //! OWNER ROOT ROUTES
  static const ownerHomeRoute = '/owner/dashboard';
  static const ownerFactoriesRoute = '/owner/factories';
  static const ownerCentralOfficesRoute = '/owner/central-office';
  static const ownerEmployeesRoute = '/owner/employees';
  static const ownerProductsRoute = '/owner/products';
  static const ownerProfileRoute = '/owner/profile';

  //! OWNER NESTED ROUTES (these must be FULL PATHS here)
  static const ownerAddFactoriesRoute = '/owner/factories/add';
  static const ownerAddCentralOfficeRoute = '/owner/central-office/add';
  static const ownerAddProducts = '/owner/products/add-product';
  static const ownerAddCategory = '/owner/products/add-category';
  static const createPlantHead = '/owner/factories/create-plant-head';

  //! MERCHANDISE
  static const ownerMerchandise = '/owner/merchandise';
  static const ownerAddMerchandise = '/owner/merchandise/add';

  //! TOOLS
  static const ownerToolsRoutes = '/owner/tools';
  static const ownerAddTools = '/owner/tools/add';

  static const factoryDetails = '/owner/factories/details';
  //! plant head routes
  static String plantHeadHomeRoute = '/plant-head/dashboard';
  static String plantHeadRequestsRoute = '/plant-head/requests';
  static String plantHeadCreateRoute = '/plant-head/create';
  static String plantHeadToolsRoute = '/plant-head/tools';
  static String plantHeadProfileRoute = '/plant-head/profile';
  static String plantHeadEmployeesRoute = '/plant-head/employees';
  static String plantHeadProductsRoute = '/plant-head/products';
}
