import 'package:service_electronic/Data/model/transfer.model.dart';
import 'package:service_electronic/core/class/statusRequest.dart';
import 'package:service_electronic/core/services/main.service.dart';
import 'package:get/get.dart';

import '../../../../routes.dart';

class TransfersController extends GetxController {
  MainService mainService = Get.find();

  List<TransferModel> transfers = [];

  @override
  void onInit() {
    TransferModel.loadAll(TransferTarget.transfers);
    TransferModel.stream(TransferTarget.transfers).listen((transfers) {
      this.transfers = transfers;
      update();
    });
    super.onInit();
  }

  chongenotification() {
    Get.toNamed(AppRoute.my_transactions);
    update();
  }
}
