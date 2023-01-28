import 'package:service_electronic/core/services/main.service.dart';
import 'package:service_electronic/link_api.dart';
import 'package:get/get.dart';
import 'package:storage_database/api/request.dart';

class SellerModel {
  int id;
  String storeName;
  String storeAddress;
  SellerStatus? sellerStatus;
  String userFullname;
  String userImgeUrl;
  Map deliveryPrices;

  SellerModel(
    this.id,
    this.storeName,
    this.storeAddress,
    this.sellerStatus,
    this.userFullname,
    this.userImgeUrl,
    this.deliveryPrices,
  );

  static SellerModel fromMap(Map data) => SellerModel(
        data['id'],
        data['store_name'],
        data['store_address'],
        SellerStatus.fromString(data['status'] ?? ''),
        '${data['user']['firstname']} ${data['user']['lastname']}',
        '${Applink.filesUrl}/${data['user']['profile_image_id']}',
        data['delivery_prices'].isNotEmpty ? data['delivery_prices'] : {},
      );

  Future<bool> edit({
    String? storeName,
    String? storePhone,
    String? storeAddress,
  }) async {
    try {
      var res =
          await Get.find<MainService>().storageDatabase.storageAPI!.request(
        Applink.editSeller,
        RequestType.post,
          
          headers: Applink.authedHeaders,
        data: {
          if (storeName != null &&
              storeName.isNotEmpty &&
              storeName != this.storeName)
            'store_name': storeName,
          if (storeAddress != null &&
              storeAddress.isNotEmpty &&
              storeAddress != this.storeAddress)
            'store_address': storeAddress,
        },
      );
      if (res.success) {
        this.storeName = storeName ?? this.storeName;
        this.storeAddress = storeAddress ?? this.storeAddress;
        return true;
      }
    } catch (e) {
      print(e);
    }

    return false;
  }
}

class SellerStatus {
  final String status;

  const SellerStatus(this.status);

  static const SellerStatus checking = SellerStatus('checking');
  static const SellerStatus accepted = SellerStatus('accepted');
  static const SellerStatus refused = SellerStatus('refused');
  static const SellerStatus banned = SellerStatus('banned');

  bool get isChecking => status == checking.status;
  bool get isAccpeted => status == accepted.status;
  bool get isRefused => status == refused.status;
  bool get isBanned => status == banned.status;

  static Map<String, SellerStatus> values = {
    checking.status: checking,
    accepted.status: accepted,
    refused.status: refused,
    banned.status: banned,
  };

  static SellerStatus? fromString(String status) => values[status];
}
