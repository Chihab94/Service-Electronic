import 'dart:convert';
import 'dart:io';

import 'package:intl/intl.dart';
import 'package:service_electronic/Data/model/currency.model.dart';
import 'package:service_electronic/Data/model/seller.model.dart';
import 'package:service_electronic/core/services/auth.service.dart';
import 'package:service_electronic/core/services/main.service.dart';
import 'package:service_electronic/link_api.dart';
import 'package:service_electronic/view/screen/the_seller/seller.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:storage_database/api/request.dart';
import 'package:storage_database/api/response.dart';
import 'package:storage_database/storage_collection.dart';

class UserModel {
  int id;
  String firstname, lastname, email, phone;
  double balance, checkingBalance;
  bool emailIsVerifited;
  IdentityVerifyStatus identityVerifyStatus;
  String? token, socketToken, imageUrl;
  int? sellerId;
  SellerStatus? sellerStatus;
  PlatformSettings platformSettings;

  UserModel(
    this.id,
    this.firstname,
    this.lastname,
    this.email,
    this.phone,
    this.balance,
    this.checkingBalance,
    this.emailIsVerifited,
    this.identityVerifyStatus,
    this.imageUrl,
    this.token,
    this.socketToken,
    this.sellerId,
    this.sellerStatus,
    this.platformSettings,
  );

  String get fullname => '$firstname $lastname';

  static StorageCollection get document =>
      Get.find<MainService>().storageDatabase.collection('user');

  static Future<UserModel> fromMap(Map data) async => UserModel(
        data['id'],
        data['firstname'],
        data['lastname'],
        data['email'],
        data['phone'],
        double.parse(data['balance'].toString()),
        double.tryParse(data['checking_balance'].toString()) ?? 0,
        data['email_verified'],
        IdentityVerifyStatus.fromString(data['identity_status']) ??
            IdentityVerifyStatus.notVerifted,
        data['profile_image_id'],
        data['token'],
        data['socket_token'],
        data['seller']?['id'],
        data['seller'] != null
            ? SellerStatus.fromString(data['seller']['status'])
            : null,
        await PlatformSettings.fromMap(data['platform_settings']),
      );

  static Future storeUser(Map data) async {
    await document.set(data);
  }

  static Future<UserModel?> refreshUser() async {
    try {
      var res =
          await Get.find<MainService>().storageDatabase.storageAPI!.request(
                Applink.user,
                RequestType.get,
                headers: Applink.authedHeaders,
              );
      if (res.success && res.value != null) {
        await storeUser(res.value);
        var user = await currentUser;
        Get.find<AuthSerivce>().currentUser.value = user;
        return user;
      } else if (!res.success) {
        Get.find<AuthSerivce>().signout();
      }
    } catch (e) {
      print(e);
    }
    return null;
  }

  static Future<UserModel?> get currentUser async {
    Map? userData = await document.get();
    return userData != null ? fromMap(userData) : null;
  }

  String? get image =>
      imageUrl != null ? '${Applink.filesUrl}/${imageUrl!}' : null;

  Future<APIResponse> updateImageProfile(File imageProfile) async {
    APIResponse response =
        await Get.find<MainService>().storageDatabase.storageAPI!.request(
      Applink.editProfile,
      RequestType.post,
      headers: Applink.authedHeaders,
      files: [
        await http.MultipartFile.fromPath("profile_image", imageProfile.path),
      ],
    );

    if (response.success) {
      await refreshUser();
      var im = (await Get.find<MainService>()
          .storageDatabase
          .explorer!
          .networkFiles!
          .file(
            image!,
            headers: Applink.imageHeaders,
          ));
      await im?.delete();
    }
    return response;
  }

  Map get map => {
        'firstname': firstname,
        'lastname': lastname,
        'email': email,
        'phone': phone,
      };
}

class IdentityVerifyStatus {
  final String status, name;

  final Color color, secendColor;

  const IdentityVerifyStatus(
      this.status, this.name, this.color, this.secendColor);

  static const IdentityVerifyStatus notVerifted = IdentityVerifyStatus(
      'not_verifted',
      'Not Verifted',
      Colors.red,
      Color.fromARGB(255, 247, 157, 157));
  static const IdentityVerifyStatus checking = IdentityVerifyStatus(
      'checking',
      'Checking',
      Color.fromARGB(255, 197, 165, 3),
      Color.fromARGB(255, 251, 252, 159));
  static const IdentityVerifyStatus verfited = IdentityVerifyStatus(
      'verifited',
      'Verifited',
      Color.fromARGB(255, 1, 141, 6),
      Color.fromARGB(255, 152, 248, 156));
  // static const IdentityVerifyStatus refused = IdentityVerifyStatus('refused', Colors.red, Color.fromARGB(255, 247, 157, 157));

  bool get isNotVerifted => status == notVerifted.status;
  bool get isChecking => status == checking.status;
  bool get isVerfited => status == verfited.status;
  // bool get isRefused => status == refused.status;

  static Map<String, IdentityVerifyStatus> values = {
    notVerifted.status: notVerifted,
    checking.status: checking,
    verfited.status: verfited,
    // refused.status: refused,
  };

  static IdentityVerifyStatus? fromString(String status) => values[status];
}

class PlatformSettings {
  CurrencyModel platformCurrency, displayCurrency;
  double commisstion;

  PlatformSettings(
    this.platformCurrency,
    this.displayCurrency,
    this.commisstion,
  );

  static Future<PlatformSettings> fromMap(Map data) async => PlatformSettings(
        await CurrencyModel.fromJson(data['platform_currency']),
        await CurrencyModel.fromJson(data['display_currency']),
        data['commission'],
      );
}
