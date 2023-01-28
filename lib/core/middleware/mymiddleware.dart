import 'package:service_electronic/core/services/auth.service.dart';
import 'package:service_electronic/core/services/main.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes.dart';

class MyMiddleware extends GetMiddleware {
  @override
  int? get priority => 1;

  MainService myService = Get.find();
  AuthSerivce authSerivce = Get.find();

  @override
  RouteSettings? redirect(String? route) {
    if (AppRoute.unAuthedPages.contains(route) && authSerivce.authed.value) {
      return const RouteSettings(name: AppRoute.home);
    } else if (!AppRoute.unAuthedPages.contains(route) &&
        !authSerivce.authed.value) {
      return const RouteSettings(name: AppRoute.login);
    }
    return null;
  }
}
