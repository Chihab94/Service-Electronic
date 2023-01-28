import 'package:gap/gap.dart';
import 'package:service_electronic/routes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../Data/model/user.mode.dart';
import '../../../../link_api.dart';
import '../../../widget/network_image.view.dart';

class MyDrawer extends StatelessWidget {
  final UserModel? user;
  final void Function()? onTap;
  const MyDrawer({
    Key? key,
    required this.user,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;

    return Drawer(
        backgroundColor: Colors.black54,
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Container(
                padding: const EdgeInsets.symmetric(horizontal: 3),
                decoration: const BoxDecoration(
                    color: Color.fromARGB(55, 248, 236, 236),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black87,
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: Offset(0, 0),
                      )
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Text(
                  user!.fullname,
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.orange),
                ),
              ),
              accountEmail: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(248, 105, 250, 134),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black87,
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 0),
                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Text(
                      "${user!.balance.toStringAsFixed(2)} DZD",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 17, 17, 17)),
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.wifi_protected_setup,
                    size: 20,
                    color: Color.fromARGB(255, 38, 2, 243),
                  ),
                  const Spacer(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(248, 228, 247, 58),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black87,
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 0),
                          )
                        ],
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: Text(
                      "${user!.checkingBalance.toStringAsFixed(2)} DZD",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 17, 17, 17)),
                    ),
                  ),
                ],
              ),
              currentAccountPicture: InkWell(
                onTap: () {
                  Get.toNamed(AppRoute.setting);
                },
                child: NetworkImageView(
                  url: user!.image!,
                  headers: Applink.imageHeaders,
                  backgroundColor: Colors.blue,
                  fit: BoxFit.cover,
                  borderRadius: 50,
                  setItInDecoration: true,
                ),
              ),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/drawer.png')),
              ),
            ),
            SizedBox(
              height: h * 0.001,
            ),
            Row(
              children: [
                InkWell(
                  onTap: user!.identityVerifyStatus.isNotVerifted
                      ? () => Get.toNamed(AppRoute.seller2)
                      : null,
                  child: Container(
                    width: w * 0.3,
                    height: h * 0.04,
                    margin: const EdgeInsets.only(right: 10, left: 10, top: 10),
                    decoration: BoxDecoration(
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black87,
                            spreadRadius: 2,
                            blurRadius: 4,
                            offset: Offset(0, 0),
                          )
                        ],
                        color: user!.identityVerifyStatus.secendColor,
                        // Color.fromARGB(255, 247, 157, 157),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          user!.identityVerifyStatus.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: user!.identityVerifyStatus.color,
                            // Color.fromARGB(255, 250, 20, 3)
                          ),
                        ),
                        SizedBox(width: w * 0.02),
                        Icon(Icons.verified,
                            color: user!.identityVerifyStatus.color
                            // Colors.red,
                            )
                      ],
                    ),
                  ),
                ),
                const Expanded(child: Gap(1)),
              ],
            ),
            SizedBox(
              height: h * 0.05,
            ),
            ListTile(
              leading: const Icon(
                Icons.home,
                color: Color.fromARGB(221, 249, 250, 249),
              ),
              title: Text(
                '43'.tr,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54),
              ),
              onTap: () {
                Get.toNamed(AppRoute.home);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.wallet,
                color: Color.fromARGB(221, 249, 250, 249),
              ),
              title: Text(
                '132'.tr,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54),
              ),
              onTap: () {
                Get.toNamed(AppRoute.pay);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.person,
                color: Color.fromARGB(221, 249, 250, 249),
              ),
              title: Text(
                '93'.tr,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54),
              ),
              onTap: () {
                Get.toNamed(AppRoute.profiel);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.currency_exchange,
                color: Color.fromARGB(221, 249, 250, 249),
              ),
              title: Text(
                '8'.tr,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54),
              ),
              onTap: () {
                Get.toNamed(AppRoute.myechonge);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.category_outlined,
                color: Color.fromARGB(221, 249, 250, 249),
              ),
              title: Text(
                '9'.tr,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54),
              ),
              onTap: () {
                Get.toNamed(AppRoute.myservice);
              },
            ),
            // ListTile(
            //   leading: const Icon(
            //     Icons.mobile_friendly,
            //     color: Color.fromARGB(221, 249, 250, 249),
            //   ),
            //   title: Text(
            //     '10'.tr,
            //     style: const TextStyle(
            //         fontSize: 20,
            //         fontWeight: FontWeight.bold,
            //         color: Colors.white54),
            //   ),
            //   onTap: () {
            //     Get.toNamed(AppRoute.mobile);
            //   },
            // ),
            ListTile(
              leading: const Icon(
                Icons.store,
                color: Color.fromARGB(221, 249, 250, 249),
              ),
              title: Text(
                '11'.tr,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54),
              ),
              onTap: () {
                Get.toNamed(AppRoute.ProductModel);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.settings,
                color: Color.fromARGB(221, 249, 250, 249),
              ),
              title: Text(
                '42'.tr,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54),
              ),
              onTap: () {
                Get.toNamed(AppRoute.setting);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.share,
                color: Color.fromARGB(221, 249, 250, 249),
              ),
              title: Text(
                '44'.tr,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54),
              ),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(
                Icons.find_in_page,
                color: Color.fromARGB(221, 249, 250, 249),
              ),
              title: Text(
                '45'.tr,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54),
              ),
              onTap: () {
                Get.toNamed(AppRoute.conditions);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(
                Icons.support_agent,
                color: Color.fromARGB(221, 249, 250, 249),
              ),
              title: Text(
                '46'.tr,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54),
              ),
              onTap: () {
                Get.toNamed(AppRoute.support);
              },
            ),
            ListTile(
              leading: const Icon(
                Icons.output,
                color: Color.fromARGB(221, 249, 250, 249),
              ),
              title: Text(
                '0'.tr,
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white54),
              ),
              onTap: onTap,
            ),
            const Gap(30)
          ],
        ));
  }
}
