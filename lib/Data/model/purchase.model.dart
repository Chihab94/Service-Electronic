import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:service_electronic/Data/model/user.mode.dart';
import 'package:storage_database/api/request.dart';
import 'package:storage_database/storage_collection.dart';
import 'package:storage_database/storage_document.dart';

import '../../core/services/main.service.dart';
import '../../link_api.dart';
import 'product.model.dart';

class PurchaseModel {
  int id;
  ProductModel product;
  int count;
  double totalPrice;
  String deliveryType;
  String fullname, phone, address, userImage;
  int userId;
  DeliverySteps deliverySteps;
  String status;
  DateTime createdAt;

  PurchaseModel(
    this.id,
    this.product,
    this.count,
    this.totalPrice,
    this.deliveryType,
    this.fullname,
    this.phone,
    this.address,
    this.userImage,
    this.userId,
    this.deliverySteps,
    this.status,
    this.createdAt,
  );

  String get userImageUrl => '${Applink.filesUrl}/$userImage';

  bool get sellerCanReport =>
      DateTimeRange(start: createdAt, end: DateTime.now()).duration.inMinutes >=
      2;

  static StorageCollection document =
      Get.find<MainService>().storageDatabase.collection('purchases');

  static StorageDocument sellerDocument = document.document('seller');
  static StorageDocument userDocument = document.document('user');

  static Future<List<PurchaseModel>> sellerLoadAll() async {
    try {
      var response =
          await Get.find<MainService>().storageDatabase.storageAPI!.request(
                'purchase/seller/all',
                RequestType.get,
          
          headers: Applink.authedHeaders,
              );
      if (response.success && response.value != null) {
        await sellerDocument.set(
          response.value.isNotEmpty ? response.value : {},
          keepData: false,
        );
      }
    } catch (e) {}
    return sellerGetAll();
  }

  static Future<List<PurchaseModel>> userLoadAll() async {
    try {
      var response =
          await Get.find<MainService>().storageDatabase.storageAPI!.request(
                'purchase/user/all',
                RequestType.get,
          
          headers: Applink.authedHeaders,
              );
      if (response.success && response.value != null) {
        await userDocument.set(
          response.value.isNotEmpty ? response.value : {},
          keepData: false,
        );
      }
    } catch (e) {}
    return userGetAll();
  }

  static Future<List<PurchaseModel>> sellerGetAll() async {
    Map items = (await sellerDocument.get()) as Map? ?? {};
    return allFromMap(items);
  }

  static Future<List<PurchaseModel>> userGetAll() async {
    Map items = (await userDocument.get()) as Map? ?? {};
    return allFromMap(items);
  }

  static Stream<List<PurchaseModel>> sellerStream() =>
      sellerDocument.stream().asyncExpand((items) async* {
        yield await allFromMap(items);
      });

  static Stream<List<PurchaseModel>> userStream() =>
      userDocument.stream().asyncExpand((items) async* {
        yield await allFromMap(items);
      });

  static Future<PurchaseModel> fromMap(Map data) async => PurchaseModel(
        data['id'],
        ProductModel.fromJson(data['product']),
        data['count'],
        double.parse(data['total_price'].toString()),
        data['delivery_type'],
        data['fullname'],
        data['phone'],
        data['address'],
        data['user']['profile_image_id'],
        data['user_id'],
        DeliverySteps.fromMap(data['delivery_steps']),
        data['status'],
        DateTime.parse(data['created_at']),
      );

  static Future<List<PurchaseModel>> allFromMap(Map items) async {
    return [
      for (String id in items.keys) await PurchaseModel.fromMap(items[id]),
    ];
  }

  static Future<PurchaseModel?> fromId(int id,
      {String target = 'seller'}) async {
    StorageDocument document =
        target == 'seller' ? sellerDocument : userDocument;
    return await fromMap(await document.document('$id').get());
  }
}

//{"seller_accept":{"readed_at":null,"answer":null},"location_steps":
//{"charging":null,"out_from_state":null,"in_to_state":null,
//"discharging_on_office":null,"delivering_to_client":null},"receive":[]}
class DeliverySteps {
  String? readedAt;
  String? answer;
  String? answerDiscription;
  String? answerAt;
  String? charging;
  String? outFromState;
  String? inToState;
  String? dischargingOnOffice;
  String? deliveringToClient;
  String? receiveAnswer;
  String? receiveAnswerDiscription;
  String? receiveAt;

  DeliverySteps(
    this.readedAt,
    this.answer,
    this.answerDiscription,
    this.answerAt,
    this.charging,
    this.outFromState,
    this.inToState,
    this.dischargingOnOffice,
    this.deliveringToClient,
    this.receiveAnswer,
    this.receiveAnswerDiscription,
    this.receiveAt,
  );

  bool get isReaded => readedAt != null;

  static String? formatDate(String? date) => date != null
      ? DateFormat('yyy-MM-dd HH:mm:ss').format(DateTime.parse(date))
      : null;

  static DeliverySteps fromMap(Map data) => DeliverySteps(
        formatDate(data['seller_accept']?['readed_at']),
        data['answer']?[0],
        data['answer']?[1],
        formatDate(data['answer']?[2]),
        formatDate(data['location_steps']?['charging']),
        formatDate(data['location_steps']?['out_from_state']),
        formatDate(data['location_steps']?['in_to_state']),
        formatDate(data['location_steps']?['discharging_on_office']),
        formatDate(data['location_steps']?['delivering_to_client']),
        data['receive']?[0],
        data['receive']?[1],
        formatDate(data['receive']?[2]),
      );

  String get currenctStep {
    for (String step in steps.keys) {
      if (steps[step] == null) return step;
    }
    return 'done';
  }

  int get currenctStepIndex => [
        'Readed At',
        'Charging',
        'Out From State',
        'In To State',
        'Discharging To Office',
        'Delivering To Client',
        'Client Received',
      ].indexOf(currenctStep);

  Map<String, String?> get steps => {
        'Readed At': readedAt,
        'Charging': charging,
        'Out From State': outFromState,
        'In To State': inToState,
        'Discharging To Office': dischargingOnOffice,
        'Delivering To Client': deliveringToClient,
        'Client Received':
            receiveAnswer != null ? '$receiveAnswer | $receiveAt' : null,
      };
}
