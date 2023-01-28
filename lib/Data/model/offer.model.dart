import 'package:get/get.dart';
import 'package:storage_database/api/request.dart';
import 'package:storage_database/storage_collection.dart';

import '../../core/services/main.service.dart';
import '../../link_api.dart';

class OfferModel {
  int id;
  Map<String, String> title;
  Map<String, String> description;
  Map<String, Map> subOffers;
  Map<String, Map> fields;
  Map<String, Map> data;

  OfferModel(
    this.id,
    this.title,
    this.description,
    this.subOffers,
    this.fields,
    this.data,
  );

  static StorageCollection collection =
      Get.find<MainService>().storageDatabase.collection('offers');

  String get image => '${Applink.offers}/$id.png';

  static OfferModel fromMap(Map data) => OfferModel(
        data['id'],
        Map<String, String>.from(data['title']),
        Map<String, String>.from(data['description']),
        Map<String, Map>.from(data['sub_offers']),
        data['fields'].isNotEmpty ? Map<String, Map>.from(data['fields']) : {},
        data['data'].isNotEmpty ?Map<String, Map>.from(data['data']):{},
      );

  static Future<List<OfferModel>> getAll() async {
    Map items = (await collection.get()) as Map? ?? {};
    return allFromMap(items);
  }

  static List<OfferModel> allFromMap(Map items) =>
      [for (String id in items.keys) fromMap(items[id])];

  static Future<List<OfferModel>> loadAll() async {
    try {
      var response =
          await Get.find<MainService>().storageDatabase.storageAPI!.request(
                'offer',
                RequestType.get,
          headers: Applink.authedHeaders,
              );
      if (response.success && response.value != null) {
        await collection.set(
          response.value.isNotEmpty ? response.value : {},
          keepData: false,
        );
      }
    } catch (e) {}
    return getAll();
  }
}
