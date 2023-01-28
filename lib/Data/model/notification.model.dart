import 'package:get/get.dart';
import 'package:service_electronic/core/services/main.service.dart';
import 'package:service_electronic/link_api.dart';
import 'package:storage_database/api/request.dart';
import 'package:storage_database/storage_collection.dart';

class NotificationModel {
  int id;
  String name;
  String title;
  String message;
  String image;
  DateTime sendedAt;
  Map data;
  bool readed;

  NotificationModel(
    this.id,
    this.name,
    this.title,
    this.message,
    this.image,
    this.sendedAt,
    this.data,
    this.readed,
  );

  String get imageUrl => "${Applink.filesUrl}/$image";

  String? get attachmentImageUrl => data.containsKey('attachment_image')
      ? "${Applink.filesUrl}/${data['attachment_image']}"
      : null;

  static StorageCollection collection =
      Get.find<MainService>().storageDatabase.collection('notifications');

  static NotificationModel fromMap(Map data) => NotificationModel(
        data['id'],
        data['name'],
        data['title'],
        data['message'],
        data['image_id'],
        DateTime.parse(data['created_at']),
        data['data']?.isNotEmpty == true ? data['data'] : {},
        data['is_readed'] == 1,
      );

  static Future<List<NotificationModel>> getAll() async {
    Map items = (await collection.get()) as Map? ?? {};
    return allFromMap(items);
  }

  static List<NotificationModel> allFromMap(Map items) =>
      [for (String id in items.keys) fromMap(items[id])];

  static Future<List<NotificationModel>> loadAll() async {
    try {
      var response =
          await Get.find<MainService>().storageDatabase.storageAPI!.request(
                'notification/all',
                RequestType.get,
          headers: Applink.authedHeaders,
                log: true,
              );
      if (response.success && response.value != null) {
        await collection.set(
          response.value.isNotEmpty ? response.value : {},
          keepData: false,
        );
      }
    } catch (e) {
      print(e);
    }
    return getAll();
  }
}
