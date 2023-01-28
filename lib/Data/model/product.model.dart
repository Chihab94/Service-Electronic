import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:service_electronic/Data/model/category.model.dart';
import 'package:service_electronic/Data/model/seller.model.dart';
import 'package:service_electronic/core/services/auth.service.dart';
import 'package:service_electronic/core/services/main.service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:storage_database/api/request.dart';
import 'package:storage_database/api/response.dart';
import 'package:storage_database/storage_collection.dart';

import '../../link_api.dart';

class ProductModel {
  int id, userId;
  SellerModel seller;
  CategoryModel category;
  String name;
  double price;
  int count;
  String description;
  bool insideCountry;
  final List<String> _images;
  String datetime;
  int likes;
  bool isLiked;
  double rates;
  bool isRated;

  ProductModel(
    this.id,
    this.userId,
    this.seller,
    this.category,
    this.name,
    this.price,
    this.count,
    this.description,
    this.insideCountry,
    this._images,
    this.datetime,
    this.likes,
    this.isLiked,
    this.rates,
    this.isRated,
  );

  static StorageCollection get document =>
      Get.find<MainService>().storageDatabase.collection('products');

  String get sellerFullName => seller.userFullname;
  String get sellerImageUrl => seller.userImgeUrl;

  List<String> get imagesUrils => [
        for (String image in _images) '${Applink.filesUrl}/$image',
      ];

  static Future<List<ProductModel>> loadAll() async {
    try {
      var response =
          await Get.find<MainService>().storageDatabase.storageAPI!.request(
                'product',
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
    return await getAll();
  }

  static Future<List<ProductModel>> getMy() async {
    List<ProductModel> products = await loadAll();
    return [
      for (ProductModel product in products)
        if (product.seller.id ==
            Get.find<AuthSerivce>().currentUser.value?.sellerId)
          product
    ];
  }

  static Future<List<ProductModel>> getAll() async {
    Map items = await document.get();
    return allFromJson(items);
  }

  static Future<Map<int, ProductModel>> getAllAsMap() async => {
        for (ProductModel product in await getAll()) product.id: product,
      };
  static Future<Map<int, ProductModel>> loadAllAsMap() async => {
        for (ProductModel product in await loadAll()) product.id: product,
      };

  static ProductModel fromJson(Map data) => ProductModel(
        data['id'],
        data['seller']['id'],
        SellerModel.fromMap(data['seller']),
        CategoryModel.fromMap(data['category']),
        data['name'],
        double.parse(data['display_price'].toString()),
        int.parse(data['count'].toString()),
        data['description'],
        data['inside_country'],
        List<String>.from(data['images_ids']),
        data['created_at'],
        data['like_count'],
        data['is_liked'],
        double.tryParse(data['rate'].toString()) ?? 0,
        data['is_rated'],
      );

  static List<ProductModel> allFromJson(Map items) =>
      [for (String id in items.keys) fromJson(items[id])];

  // static Stream<List<ProductModel>> stream() => documnet.stream().asyncExpand(
  //       (data) async* {
  //         if (data != null) {
  //           yield allFromJson(data);
  //         }
  //       },
  //     );

  static Future<ProductModel?> fromId(String id) async {
    Map? data = await document.document(id).get();
    return data != null ? ProductModel.fromJson(data) : null;
  }

  static Future<APIResponse> create({
    required CategoryModel category,
    required String name,
    required double price,
    required int count,
    required String description,
    required List<File> images,
  }) async {
    return Get.find<MainService>().storageDatabase.storageAPI!.request(
      Applink.createProduct,
      RequestType.post,
          
          headers: Applink.authedHeaders,
      files: [
        for (File img in images)
          await http.MultipartFile.fromPath(
              '${images.indexOf(img)}-p-i', img.path)
      ],
      onFilesUpload: (int bytes, int total) {
        final progress = bytes / total * 100;
        print('progress: $progress% ($bytes/$total)');
      },
      data: {
        'name': name,
        'description': description,
        'category_id': '${category.id}',
        'price': '$price',
        'count': '$count',
        'tags': '[]',
      },
    );
  }

  Future<APIResponse> save({List<File>? newImages}) async {
    APIResponse response =
        await Get.find<MainService>().storageDatabase.storageAPI!.request(
      Applink.editProduct.replaceAll('{id}', '$id'),
      RequestType.post,
          
          headers: Applink.authedHeaders,
      files: [
        if (newImages != null)
          for (File img in newImages)
            await http.MultipartFile.fromPath(
              '${newImages.indexOf(img)}-p-i',
              img.path,
            )
      ],
      onFilesUpload: (int bytes, int total) {
        final progress = bytes / total * 100;
        print('progress: $progress% ($bytes/$total)');
      },
      data: {
        'name': name,
        'description': description,
        'category_id': '${category.id}',
        'price': '$price',
        'count': '$count',
        'tags': '[]',
      },
    );
    if (response.success && newImages != null) {
      for (String imageUrl in imagesUrils) {
        var im = (await Get.find<MainService>()
            .storageDatabase
            .explorer!
            .networkFiles!
            .file(imageUrl, headers: Applink.imageHeaders));
        await im?.delete();
      }
    }
    return response;
  }

  Future<APIResponse> delete() async {
    APIResponse response =
        await Get.find<MainService>().storageDatabase.storageAPI!.request(
              Applink.deleteProduct.replaceAll('{id}', '$id'),
              RequestType.delete,
          
          headers: Applink.authedHeaders,
            );
    if (response.success) loadAll();
    return response;
  }

  Future<bool> like() async {
    APIResponse response =
        await Get.find<MainService>().storageDatabase.storageAPI!.request(
              'product/$id/like',
              RequestType.get,
          
          headers: Applink.authedHeaders,
            );
    if (response.success) {
      likes++;
      isLiked = true;
      // await loadAll();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> unLike() async {
    var response =
        await Get.find<MainService>().storageDatabase.storageAPI!.request(
              'product/$id/unLike',
              RequestType.get,
          
          headers: Applink.authedHeaders,
            );
    if (response.success) {
      likes--;
      isLiked = false;
      // await loadAll();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> rate(double value) async {
    var response =
        await Get.find<MainService>().storageDatabase.storageAPI!.request(
      'product/$id/rate',
      RequestType.post,
          
          headers: Applink.authedHeaders,
      data: {'value': value},
    );
    if (response.success) {
      var products = await loadAllAsMap();
      rates = products[id]!.rates;
      return true;
    } else {
      return false;
    }
  }
}
