// ignore: avoid_classes_with_only_static_members
class StringConstants {
  //! login constants
  static const String appTitle = 'SpearMe App';
  static const String terms = 'Please agree to terms of use and privacy policy';
  static const String alreadyUser = 'Already have an account?';
  static const String wantToBecomeDistributor =
      'Want to become a distributor ?';
  static const String welcomeBack = 'Welcome Back';
  static const String signUpTitle = 'Sign Up';
  static const String signInTitle = 'Sign In';
  static const String usernameLabel = 'Username';
  static const String emailLabel = 'Email';
  static const String passwordLabel = 'Password';
  static const String signUpButton = 'Sign Up';
  static const String logout = 'Logout';
  static const String logoutSuccessful = 'Logout Successful';
  static const String doyouReallyWantToLogOut =
      'Do you really want to log out?';

  static const String createAccount = ' Please create a new account';
  static const String loginToContinue = 'Please login to continue';
  static const String signingYouIn = ' SIGNING YOU IN . . .';
  static const String emailRegex =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  static const String validEmail = 'Please enter a valid email address';
  static const String passwordRegex =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  static const String strongPassword =
      'Password must be 8+ chars, with upper, lower, number & special char';
  static const String usernameFourCharacters =
      'Username must be at least 4 characters';
  static const String validNumber = 'Please enter a valid number';
  static const String negativeNumbersNotAllowed =
      'Negative numbers are not allowed';

  //! sign up constants
  static const String usernameEmpty = 'Enter a username';
  static const String usernameShort = 'Username must be at least 4 characters';
  static const String emailEmpty = 'Enter an email';
  static const String emailInvalid = 'Enter a valid email';
  static const String passwordEmpty = 'Enter a password';
  static const String passwordShort = 'Password must be at least 6 characters';
  static const String passwordNotStrong =
      'Password must contain at least one uppercase letter\n one lowercase letter\n one digit, and one special character';

  static const String signUpSuccess = 'Sign Up Successful!';
  static const String signUpFailure = 'Sign Up Failed. Please try again.';

  static const String loginTitle = 'Login';

  static const String loginFailure = 'Login Failed. Please try again.';

  static const String numberLabel = 'Mobile Number';
  static const String numberEmpty = 'Number cannot be empty';
  static const String nineOne = "+91";

  //! O W N E R
  static const String ownerLabel = 'Owner';
  static const String dashboard = 'Dashboard';
  static const String factories = 'Factories';
  static const String employees = 'Employees';
  static const String products = 'Products';
  static const String profile = 'Profile';
  static const String tools = 'Tools';

  static const String removeEmployee = 'Remove Employee';
  static const String remove = 'Remove';
  static String removeEmployeeMsg(String username) =>
      'Are you sure you want to remove $username from your team? This action cannot be undone.';
  static const String filterByRole = "Filter by Role:";
  static const String sortBy = 'Sort by';

  //!owner-factories

  static const String factoryName = 'Factory Name';
  static const String factoryLocation = 'Factory Location';
  static const String appointPlantHead = 'Appoint plant head';
  static const String createFactory = 'Create factory';
  static const String addFactory = 'Add Factory';
  static const String factoryNameCannnotBeEmpty =
      'Factory name cannot be empty!';

  //! owner-central-office
  static const String centralOfficerName = 'Central officer Name';
  static const String centralOfficerEmail = 'Central officer email';
  static const String createCentralOffice = 'Create central officer';
  static const String addCentralOfficer = 'Add central officer';
  static const String centralOfficeNameCannnotBeEmpty =
      'Central officer name cannot be empty!';

  //!   MERCHANDISE
  static const String addMerchandise = 'Add Merchandise';
  static const String merchandise = "Merchandise";
  static const String noMerchandiseFound = "No merchandise found";
  static const String pleaseSelectAnImage = "Please select an image";
  static const String searchEmployees = 'Search employees...';
  static const String searchMerchandise = 'Search merchandise...';

  //! products constants
  static const String noProductsFound = 'No products Found';
  static const String failedToFetchProducts = 'Failed to fetch products';
}
