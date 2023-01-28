import 'package:service_electronic/Data/model/currency.model.dart';
import 'package:service_electronic/Data/model/product.model.dart';
import 'package:service_electronic/Data/model/user.mode.dart';
import 'package:service_electronic/core/services/main.service.dart';
import 'package:service_electronic/core/services/notifiction.service.dart';
import 'package:get/get.dart';
import 'package:service_electronic/link_api.dart';
import 'package:service_electronic/main.dart';
import 'package:service_electronic/routes.dart';
import 'package:storage_database/api/request.dart';

class AuthSerivce extends GetxService {
  Rx<UserModel?> currentUser = null.obs;
  MainService mainService = Get.find();

  RxBool authed = false.obs;

  Future onAuth({bool refresh = false}) async {
    currentUser = (await UserModel.currentUser).obs;
    if (refresh) await UserModel.refreshUser();
    NotificationService notificationService = Get.find<NotificationService>();
    await mainService.storageDatabase.collection('settings').set({
      'authed': true,
    });
    authed.value = true;
    await notificationService.init(currentUser.value!.socketToken!);
    // await (await Get.find<MainService>()
    //         .storageDatabase
    //         .explorer!
    //         .networkFiles!
    //         .file(
    //           "http://service-electronic.ddns.net/file/api/u-3-pi",
    //           headers: Applink.imageHeaders,
    //         ))
    //     .delete();
  }

  Future signout({bool sendRequest = true}) async {
    Get.find<NotificationService>().disconnect();
    if (sendRequest) {
      await mainService.storageDatabase.storageAPI!.request(
        'auth/logout',
        RequestType.get,
          headers: Applink.authedHeaders,
      );
    }
    await Get.delete<NotificationService>();
    await mainService.storageDatabase.clear();
    await mainService.initCollections();
    await mainService.storageDatabase
        .collection('settings')
        .set({'token': '', 'authed': false, 'language': 'en'});

    authed.value = false;
    currentUser.value = null;
    Get.offAllNamed(AppRoute.login);
  }
}
