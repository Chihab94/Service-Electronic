import 'dart:convert';

import 'package:image_picker/image_picker.dart';
import 'package:service_electronic/core/services/main.service.dart';
import 'package:service_electronic/link_api.dart';
import 'package:get/get.dart';
import 'package:storage_database/api/request.dart';
import 'package:storage_database/storage_collection.dart';
import 'package:storage_database/storage_document.dart';

import '../../core/services/auth.service.dart';

class CurrencyModel {
  int id;
  String name, char;
  List<String> wallet;
  String? strWallet;
  double maxReceive;
  Map<CurrencyModel, dynamic> prices;
  Map dPrices, data;

  bool proofIsRequired;
  CurrencyProofPickType pickType;

  CurrencyModel(
    this.id,
    this.name,
    this.char,
    this.wallet,
    this.strWallet,
    this.maxReceive,
    this.prices,
    this.dPrices,
    this.data,
    this.proofIsRequired,
    this.pickType,
  );

  static StorageCollection document =
      Get.find<MainService>().storageDatabase.collection('currencies');

  String get image {
    print('${Applink.currencies}/$id.png');
    return '${Applink.currencies}/$id.png';
  }

  static Future<List<CurrencyModel>> loadAll() async {
    try {
      var response =
          await Get.find<MainService>().storageDatabase.storageAPI!.request(
                'currency',
                RequestType.get,
                headers: Applink.authedHeaders,
              );
      if (response.success && response.value != null) {
        await document.set(
          response.value.isNotEmpty ? response.value : {},
          keepData: false,
        );
      }
    } catch (e) {}
    return getAll();
  }

  static Future<List<CurrencyModel>> getAll() async {
    Map items = (await document.get()) as Map? ?? {};
    return await allFromJson(items);
  }

  static Future<CurrencyModel> fromJson(Map data) async {
    if (data['prices'].isEmpty) data['prices'] = {};
    if (data['rendred_prices'] == null || data['rendred_prices'].isEmpty) {
      data['rendred_prices'] = {};
    }
    return CurrencyModel(
      data['id'],
      data['name'],
      data['char'],
      data['wallet']?.toString().split(', ') ?? [],
      data['wallet']?.toString().replaceAll(', ', '\n'),
      double.parse((data['platform_wallet']?['balance'] ?? '0').toString()),
      {
        for (var currencyId in (data['rendred_prices'] ?? {}).keys)
          await CurrencyModel.fromJson(
                  data['rendred_prices'][currencyId]['currency']):
              data['rendred_prices'][currencyId]['price'],
      },
      data['prices'],
      data['data']?.isNotEmpty == true ? data['data'] : {},
      data['proof_is_required'],
      CurrencyProofPickType.fromString(data['image_pick_type']),
    );
  }

  static Future<List<CurrencyModel>> allFromJson(Map items) async =>
      [for (String id in items.keys) await fromJson(items[id])];

  // static Future<List<CurrencyModel>> all() async {
  //   Map data = (await document.get()) as Map? ?? {};
  //   return allFromJson(data);
  // }

  // static Future<CurrencyModel?> fromId(int id) async {
  //   List<CurrencyModel> items = await all();
  //   for (CurrencyModel item in items) {
  //     if (item.id == id) return item;
  //   }
  //   return null;
  // }
}

class CurrencyProofPickType {
  final String type;
  final ImageSource source;

  const CurrencyProofPickType(this.type, this.source);

  static const CurrencyProofPickType gallery =
      CurrencyProofPickType('gallery', ImageSource.gallery);
  static const CurrencyProofPickType camera =
      CurrencyProofPickType('camera', ImageSource.camera);

  bool get isGallery => type == gallery.type;
  bool get isCamera => type == camera.type;

  static Map<String, CurrencyProofPickType> values = {
    gallery.type: gallery,
    camera.type: camera
  };

  static CurrencyProofPickType fromString(String type) => values[type]!;
}
