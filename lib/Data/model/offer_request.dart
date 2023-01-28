import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_electronic/Data/model/offer.model.dart';
import 'package:storage_database/api/request.dart';
import 'package:storage_database/storage_collection.dart';

import '../../core/services/main.service.dart';
import '../../link_api.dart';

class OfferRequestModel {
  int id;
  OfferModel offer;
  String subOffer;
  double totalPrice;
  Map<String, dynamic> fields;
  Map<String, dynamic>? data;
  DateTime sendedAt;
  OfferRequestStatus status;

  OfferRequestModel(
    this.id,
    this.offer,
    this.subOffer,
    this.totalPrice,
    this.fields,
    this.data,
    this.sendedAt,
    this.status,
  );

  static StorageCollection collection =
      Get.find<MainService>().storageDatabase.collection('offer_requests');

  static OfferRequestModel fromMap(Map data) => OfferRequestModel(
      data['id'],
      OfferModel.fromMap(data['offer']),
      data['sub_offer'],
      double.parse(data['total_price'].toString()),
      data['fields']?.isNotEmpty == true ? data['fields'] : {},
      data['data']?.isNotEmpty == true ? data['data'] : {},
      DateTime.parse(data['created_at']),
      OfferRequestStatus.fromString(data['status']));

  static List<OfferRequestModel> allFromMap(Map items) =>
      [for (String id in items.keys) fromMap(items[id])];

  static Future<List<OfferRequestModel>> getAll() async {
    var data = await collection.get();
    Map items = (data) as Map? ?? {};
    return allFromMap(items);
  }

  static Future<List<OfferRequestModel>> loadAll() async {
    try {
      var response =
          await Get.find<MainService>().storageDatabase.storageAPI!.request(
                'offer_request/all',
                RequestType.get,
                headers: Applink.authedHeaders,
              );
      await collection.set({}, keepData: false);
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

class OfferRequestStatus {
  String status;
  IconData icon;
  Color color;

  OfferRequestStatus(this.status, this.icon, this.color);

  String get tr => status.tr;

  static OfferRequestStatus waitingAdminAccept = OfferRequestStatus(
    'waiting_admin_accept',
    Icons.change_circle,
    Colors.orange,
  );
  static OfferRequestStatus adminAccept = OfferRequestStatus(
    'admin_accept',
    Icons.check_circle,
    Colors.green,
  );
  static OfferRequestStatus received = OfferRequestStatus(
    'received',
    Icons.check_circle,
    Colors.green,
  );
  static OfferRequestStatus adminRefuse = OfferRequestStatus(
    'admin_refuse',
    Icons.report_rounded,
    Colors.red,
  );

  static Map<String, OfferRequestStatus> values = {
    waitingAdminAccept.status: waitingAdminAccept,
    adminAccept.status: adminAccept,
    received.status: received,
    adminRefuse.status: adminRefuse,
  };

  static OfferRequestStatus fromString(status) => values[status]!;
}
