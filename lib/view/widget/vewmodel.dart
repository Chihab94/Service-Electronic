import 'package:rate/rate.dart';
import 'package:service_electronic/Data/model/product.model.dart';
import 'package:service_electronic/Data/model/user.mode.dart';
import 'package:service_electronic/link_api.dart';
import 'package:service_electronic/routes.dart';
import 'package:service_electronic/view/widget/dialogs.view.dart';
import 'package:service_electronic/view/widget/post_gallery.view.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

import '../../core/services/auth.service.dart';

class VewModel extends StatelessWidget {
  final void Function()? buy;
  final void Function()? onTapcontry;
  final void Function(ProductModel product, double value)? onRate;
  final ProductModel product;
  final bool editable;
  final void Function()? onActionEnd;

  final ImageProvider<Object>? backgroundImage;
  const VewModel({
    Key? key,
    required this.product,
    this.onTapcontry,
    this.onRate,
    this.backgroundImage,
    this.buy,
    this.editable = false,
    this.onActionEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    UserModel user = Get.find<AuthSerivce>().currentUser.value!;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              InkWell(
                // onTap: onTap,
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: CircleAvatar(
                    backgroundColor: Colors.black,
                    radius: 32,
                    child: Container(
                      width: w * 0.3,
                      margin: const EdgeInsets.all(1),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: NetworkImage(product.sellerImageUrl,
                              headers: Applink.imageHeaders),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                      child: Text(
                    product.sellerFullName,
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  )),
                  Text(product.datetime,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
              if (editable) ...[
                Spacer(),
                PopupMenuButton<String>(
                  onSelected: (value) async {
                    switch (value) {
                      case 'edit':
                        await Get.toNamed(AppRoute.addProduct, arguments: {
                          'action': 'Edit',
                          'product': product,
                        });
                        if (onActionEnd != null) onActionEnd!();
                        break;
                      case 'delete':
                        DialogsView.message(
                          'Delete Product',
                          'Are you sure you want to delete this product?',
                          actions: [
                            DialogAction(
                              text: 'Yes',
                              onPressed: () async {
                                await product.delete();
                                Get.back();
                                if (onActionEnd != null) onActionEnd!();
                              },
                              actionColor: Colors.red,
                            ),
                            DialogAction(
                              text: 'Cancel',
                              onPressed: () {
                                Get.back();
                              },
                              actionColor: Colors.blue,
                            ),
                          ],
                        ).show();
                        break;
                      default:
                        return;
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'.tr),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'.tr),
                    )
                  ],
                )
              ]
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 10, bottom: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${"31".tr} : ${product.name}",
                  style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 105, 247, 110)),
                ),
                if (!product.insideCountry)
                  Text(
                    "35".tr,
                    style: const TextStyle(
                      color: Colors.redAccent,
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                Text(
                  "${'142'.tr} : ${product.count} ",
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Gap(5),
                Text("${"75".tr} : ${product.description}",
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                    )),
              ],
            ),
          ),

          //=========================صورة المنتج =============================
          Container(
            color: const Color.fromARGB(255, 197, 195, 195),
            height: h * 0.4,
            child: PostGalleryView(items: product.imagesUrils),
          ),

          if (product.likes > 0)
            Container(
              margin: const EdgeInsets.only(bottom: 10, right: 5),
              child: Row(
                children: [
                  const Icon(
                    Icons.favorite,
                    size: 20,
                    color: Color.fromARGB(255, 238, 20, 24),
                  ),
                  Text(
                    (product.likes < 99 ? product.likes : '99+').toString(),
                  ),
                ],
              ),
            ),
          const Gap(5),
          Text(
            '${"33".tr} : ${product.price} DZD',
          ),

          const Gap(5),
          Rate(
            color: Colors.amberAccent,
            readOnly: product.isRated,
            allowHalf: true,
            iconSize: 20,
            initialValue: product.isRated ? 5 * product.rates : 0,
            onChange: product.isRated ? null : (v) => onRate!(product, v),
          ),
          const Gap(5),
          Row(
            children: [
              InkWell(
                onTap: onTapcontry,
                child: Icon(
                  Icons.favorite,
                  size: 35,
                  color: product.isLiked
                      ? Colors.red
                      : const Color.fromARGB(255, 119, 250, 126),
                  shadows: const [
                    BoxShadow(
                      color: Colors.black87,
                      spreadRadius: 5,
                      blurRadius: 10,
                      offset: Offset(0, 0),
                    )
                  ],
                ),
              ),
              const Expanded(child: Gap(2)),
              if (user.sellerId != product.seller.id)
                InkWell(
                  onTap: buy,
                  child: Container(
                    width: w * 0.27,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      border: Border.all(color: Colors.black, width: 1.5),
                      borderRadius: const BorderRadius.all(Radius.circular(12)),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black87,
                          spreadRadius: 0,
                          blurRadius: 5,
                          offset: Offset(0, 0),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "71".tr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const Icon(
                          Icons.add_shopping_cart_rounded,
                          size: 28,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                )
            ],
          ),
          Divider(
            height: h * 0.03,
            thickness: 5,
          ),
        ],
      ),
    );
  }
}
