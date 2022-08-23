class ApiStrings {
  static const String baseUrlForImage =
      'https://lavie.orangedigitalcenteregypt.com';
  static const String baseUrl =
      'https://lavie.orangedigitalcenteregypt.com/api/v1/';
  static const String login = 'auth/signin';
  static const String signUp = 'auth/signup';
  static const String logout = 'logout';
  static const String profile = 'user/me';
  static const String forgetPassword = 'auth/forget-password';
  static const String verifyOtp = 'auth/verify-otp';
  static const String resetPassword = 'auth/reset-password';
  static const String products = 'products';
  static const String blogs = 'products/blogs';
  static const String forums = 'forums';

  /////////////
  static const String homeData = 'home';
  static const String address = 'addresses';

  static const String cart = 'carts';
  static const String order = 'orders';

  static const String favorites = 'favorites';
}

class AppStrings {
  static const String themeKey = 'themeKey';
  static const String tokenKey = 'tokenKey';
  static const String locationIdKey = 'locationIdKey';
  static String? locationId;
  static bool? isDarkCashed;
  static String? token;
}
