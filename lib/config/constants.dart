class AppConstants {
  static const String checkboxApiServer = 'https://api.checkbox.in.ua/api/v1/';
  static const String checkboxTokenName = 'Authorization';
  static const String checkboxRegisterLicenseName = 'X-License-Key';

  static const int productsLimitPerPage = 30;

  static const String crmApiServer = 'https://api.avi-shop.com';
}

enum BlocStateStatus { initial, loading, success, failure }
