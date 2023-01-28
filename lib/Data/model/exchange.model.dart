import 'package:get/get.dart';
import 'package:service_electronic/core/services/main.service.dart';
import 'package:storage_database/api/request.dart';
import 'package:storage_database/storage_collection.dart';

import '../../link_api.dart';

class ExchangeModel {
  int id;
  String targetEmail;
  double sendedBalance;
  double receivedBalance;
  DateTime sendedAt;

  ExchangeModel(
    this.id,
    this.targetEmail,
    this.sendedBalance,
    this.receivedBalance,
    this.sendedAt,
  );

  static StorageCollection collection =
      Get.find<MainService>().storageDatabase.collection('exchanges');

  static List<ExchangeModel> allFromMap(Map items) => [
        for (String id in items.keys) fromMap(items[id]),
      ];
  static ExchangeModel fromMap(Map data) => ExchangeModel(
        data['id'],
        data['target_user']['email'],
        double.parse(data['sended_balance'].toString()),
        double.parse(data['received_balance'].toString()),
        DateTime.parse(data['created_at']),
      );

  static Future<List<ExchangeModel>> loadAll() async {
    try {
      var response =
          await Get.find<MainService>().storageDatabase.storageAPI!.request(
                'exchanges',
                RequestType.get,
          headers: Applink.authedHeaders,
              );
      if (response.success && response.value != null) {
        await collection.set(
          response.value.isNotEmpty ? response.value : {},
          keepData: false,
        );
      }
    } catch (e) {
      print('categories: $e');
    }
    return await getAll();
  }

  static Future<List<ExchangeModel>> getAll() async {
    Map items = (await collection.get()) as Map? ?? {};
    return allFromMap(items);
  }
}
