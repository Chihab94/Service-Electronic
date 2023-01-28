import 'package:service_electronic/core/services/auth.service.dart';
import 'package:get/get.dart';

class Applink {
  static const String serverUrl = 'http://service-electronic.ddns.net';
  static const String apiUrl = '$serverUrl/api';

  static const String socketUrl = '$serverUrl:8000';

  static const String filesUrl = "$serverUrl/file/api";
  static const String storageUrl = "$serverUrl/storage";
  static const String currencies = "$storageUrl/currencies";
  static const String categories = "$storageUrl/categories";
  static const String offers = "$storageUrl/offers";

  static const String login = "auth/login";
  static const String singup = "auth/signup";
  static const String user = "auth/user";
  static const String editProfile = "auth/edit";
  static const String identityVerify = "auth/verify_identity";

  static const String transfers = "transfer";
  static const String products = "product";
  static const String createProduct = "$products/create";
  static const String editProduct = "$products/{id}/edit";
  static const String deleteProduct = "$products/{id}/delete";

  static const String registerSeller = "seller/register";
  static const String editSeller = "seller/edit";

  static String? get token => Get.find<AuthSerivce>().currentUser.value?.token;

  static Map<String, String> get headers => {
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': 'application/json',
      };
  static Map<String, String> get authedHeaders =>
      {...headers, if (token != null) 'Authorization': 'Bearer $token'};
  static Map<String, String> get imageHeaders =>
      {if (token != null) 'Authorization': 'Bearer $token'};
}
