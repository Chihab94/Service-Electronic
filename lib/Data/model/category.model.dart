import 'package:get/get.dart';
import 'package:storage_database/api/request.dart';
import 'package:storage_database/storage_collection.dart';

import '../../core/localization/localiztioncontroller.dart';
import '../../core/services/main.service.dart';
import '../../link_api.dart';

class CategoryModel {
  int id;
  Map names;

  CategoryModel(this.id, this.names);

  String get name => names[Get.find<LocaleController>().language.languageCode];
  String get imageUrl => '${Applink.categories}/$id.png';

  static StorageCollection document =
      Get.find<MainService>().storageDatabase.collection('categories');

  static Future<List<CategoryModel>> loadAll() async {
    try {
      var response =
          await Get.find<MainService>().storageDatabase.storageAPI!.request(
                'category',
                RequestType.get,
          headers: Applink.authedHeaders,
              );
      if (response.success && response.value != null) {
        await document.set(
          response.value.isNotEmpty ? response.value : {},
          keepData: false,
        );
      }
    } catch (e) {
      print('categories: $e');
    }
    return await getAll();
  }

  static Future<List<CategoryModel>> getAll() async {
    Map items = (await document.get()) as Map? ?? {};
    return allFromMap(items);
  }

  static CategoryModel fromMap(Map data) => CategoryModel(
        data['id'],
        data['name'],
      );

  static List<CategoryModel> allFromMap(Map items) => [
        for (String id in items.keys) fromMap(items[id]),
      ];
}
