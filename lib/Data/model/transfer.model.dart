import 'package:service_electronic/Data/model/currency.model.dart';
import 'package:service_electronic/link_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:storage_database/api/request.dart';
import 'package:storage_database/storage_collection.dart';
import 'package:storage_database/storage_document.dart';

import '../../core/services/auth.service.dart';
import '../../core/services/main.service.dart';

class TransferModel {
  int id;
  double sendedBalance, receivedBalance;
  CurrencyModel sendedCurrency, receivedCurrency;
  Map data;
  TransferStatus status;
  DateTime createdAt;

  TransferModel(
    this.id,
    this.sendedBalance,
    this.receivedBalance,
    this.sendedCurrency,
    this.receivedCurrency,
    this.data,
    this.status,
    this.createdAt,
  );

  static StorageCollection collection =
      Get.find<MainService>().storageDatabase.collection('transfers');

  static Future<TransferModel> fromMap(Map data) async => TransferModel(
        data['id'],
        double.parse(data['sended_balance'].toString()),
        double.parse(data['received_balance'].toString()),
        await CurrencyModel.fromJson(data['sended_currency']),
        await CurrencyModel.fromJson(data['received_currency']),
        data['data'].isNotEmpty ? data['data'] : {},
        TransferStatus.fromString(data['status']),
        DateTime.parse(data['created_at']),
      );

  static Future<List<TransferModel>> allFromMap(Map items) async => [
        for (String id in items.keys) await fromMap(items[id]),
      ];

  static Future<List<TransferModel>> getAll(TransferTarget target) async {
    Map items = (await target.document.get()) as Map? ?? {};
    return allFromMap(items);
  }

  static Future<List<TransferModel>> loadAll(TransferTarget target) async {
    try {
      var response =
          await Get.find<MainService>().storageDatabase.storageAPI!.request(
                'transfer/${target.urlName}',
                RequestType.get,
          
          headers: Applink.authedHeaders,
              );
      if (response.success && response.value != null) {
        await target.document.set(
          response.value.isNotEmpty ? response.value : {},
          keepData: false,
        );
      }
    } catch (e) {}
    return await getAll(target);
  }

  static Future loadAllTargets() async {
    await loadAll(TransferTarget.transfers);
    await loadAll(TransferTarget.recharges);
    await loadAll(TransferTarget.withdraws);
  }

  static Stream<List<TransferModel>> stream(TransferTarget target) =>
      target.document.stream().asyncExpand((items) async* {
        yield await allFromMap(items);
      });
}

class TransferStatus {
  String status;
  Color color;
  String tr;

  TransferStatus(this.status, this.color, this.tr);

  static TransferStatus accepted =
      TransferStatus('accepted', Colors.green, '105'.tr);
  static TransferStatus refused =
      TransferStatus('refused', Colors.red, '106'.tr);
  static TransferStatus checking =
      TransferStatus('checking', Colors.orangeAccent, '66'.tr);

  static Map<String, TransferStatus> values = {
    'accepted': accepted,
    'refused': refused,
    'checking': checking,
  };

  bool get isChecking => status == checking.status;

  static TransferStatus fromString(String status) => values[status]!;

  @override
  String toString() => status;
}

class TransferTarget {
  final String name;
  final String urlName;
  const TransferTarget(this.name, this.urlName);

  StorageDocument get document => TransferModel.collection.document(name);

  static TransferTarget transfers =
      const TransferTarget('transfers', 'transfer');
  static TransferTarget recharges =
      const TransferTarget('recharges', 'recharge');
  static TransferTarget withdraws =
      const TransferTarget('withdraws', 'withdraw');
}
