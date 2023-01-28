import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:service_electronic/Data/model/purchase.model.dart';
import 'package:service_electronic/core/class/statusRequest.dart';
import 'package:service_electronic/core/constant/castomTextFormField.dart';
import 'package:service_electronic/core/services/main.service.dart';
import 'package:service_electronic/link_api.dart';
import 'package:service_electronic/view/widget/delivery_steper.veiw.dart';
import 'package:service_electronic/view/widget/dialogs.view.dart';
import 'package:service_electronic/view/widget/dropdown.view.dart';
import 'package:storage_database/api/request.dart';
import 'package:storage_database/storage_database.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/localization/localiztioncontroller.dart';
import '../../../widget/button.view.dart';

class PurchaseDetails extends StatefulWidget {
  const PurchaseDetails({super.key});

  @override
  State<PurchaseDetails> createState() => _PurchaseDetailsState();
}

class _PurchaseDetailsState extends State<PurchaseDetails> {
  bool isSeller = Get.arguments['target'] == 'seller';
  PurchaseModel purchase = Get.arguments['purchase'];
  GlobalKey<FormState> answerKey = GlobalKey<FormState>();
  late TextEditingController disctiptionController;
  String currenctAnswer = '-1';

  StorageDatabase storageDatabase = Get.find<MainService>().storageDatabase;

  bool isAnswering = false;

  @override
  void initState() {
    super.initState();
    if (!purchase.deliverySteps.isReaded && isSeller) {
      storageDatabase.storageAPI!.request(
        'purchase/${purchase.id}/read',
        RequestType.get,
        headers: Applink.authedHeaders,
      );
    }
    disctiptionController = TextEditingController();
  }

  Future<bool> answer() async {
    if (answerKey.currentState!.validate()) {
      setState(() => isAnswering = true);
      final response = await storageDatabase.storageAPI!.request(
        isSeller
            ? 'purchase/${purchase.id}/seller_answer'
            : 'purchase/${purchase.id}/client_answer',
        RequestType.post,
        log: true,
        headers: Applink.authedHeaders,
        data: {
          'answer': currenctAnswer,
          'description': disctiptionController.text,
        },
      );
      if (response.success) {
        if (isSeller) {
          await PurchaseModel.sellerLoadAll();
        } else {
          await PurchaseModel.userLoadAll();
        }
        purchase = await PurchaseModel.fromId(
              purchase.id,
              target: isSeller ? 'seller' : 'user',
            ) ??
            purchase;
        setState(() => isAnswering = false);
        return true;
      }
      setState(() => isAnswering = false);
    }
    return false;
  }

  Future nextStep() async {
    final response =
        await Get.find<MainService>().storageDatabase.storageAPI!.request(
              'purchase/${purchase.id}/next_step',
              RequestType.get,
              headers: Applink.authedHeaders,
            );
    if (response.success) {
      await PurchaseModel.sellerLoadAll();
      purchase = await PurchaseModel.fromId(purchase.id) ?? purchase;
      setState(() {});
    }
  }

  Future clientAnswer() async {
    await DialogsView(
      child: Form(
        key: answerKey,
        child: Column(
          children: [
            DropDownView<String>(
                value: currenctAnswer,
                items: const [
                  DropdownMenuItem(
                    value: '-1',
                    child: Text('Answer'),
                  ),
                  DropdownMenuItem(
                    value: 'accept',
                    child: Text('Accept'),
                  ),
                  DropdownMenuItem(
                    value: 'refuse',
                    child: Text('Refuse'),
                  ),
                ],
                validator: (value) {
                  if (value == '-1') return "147".tr;
                },
                onChanged: (v) {
                  if (v != null) {
                    setState(() {
                      currenctAnswer = v;
                      print(v);
                    });
                  }
                }),
            myTextFormField(
              labeltext: 'Disciption',
              hintText: '',
              valid: (value) {
                if (currenctAnswer == 'refuse' && value!.isEmpty) return "154";
              },
              mycontroller: disctiptionController,
            ),
            ButtonView(
              onPressed: !isAnswering
                  ? () async {
                      if (await answer()) {
                        Get.back();
                        Get.back();
                      }
                    }
                  : null,
              backgroundColor: isAnswering ? Colors.grey : null,
              child: isAnswering
                  ? const SizedBox(
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : const Text('Answer'),
            ),
          ],
        ),
      ),
    ).show();
  }

  Future sellerReport() async {
    TextEditingController reportController = TextEditingController();
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    DialogsView.form(
      title: 'Seller Report',
      formKey: formKey,
      fields: [
        DialogFormField(
          name: 'Report Text',
          controller: reportController,
          valid: (value) {
            if (value!.isEmpty) return 'gjhgfhgfh';
          },
        )
      ],
      onSubmit: (fields) async {
        if (formKey.currentState!.validate()) {
          DialogsView.loading().show();
          final response = await storageDatabase.storageAPI!.request(
            'purchase/${purchase.id}/seller_report',
            RequestType.post,
            headers: Applink.authedHeaders,
            data: {
              'report': reportController.text,
            },
          );
          if (response.success) {
            await PurchaseModel.sellerLoadAll();
            purchase = await PurchaseModel.fromId(
                  purchase.id,
                  target: isSeller ? 'seller' : 'user',
                ) ??
                purchase;
            Get.back();
            Get.back();
          } else {
            Get.back();
            DialogsView.message('Seller Repport', response.message).show();
          }
        }
      },
      onCancel: () async {},
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    String lang = Get.find<LocaleController>().language.languageCode;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Center(child: Text('${"28.5".tr}(#${purchase.id}) ${"152".tr}')),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 30),
        color: Colors.black,
        child: Container(
          padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50), topRight: Radius.circular(50))),
          margin: const EdgeInsets.only(
            top: 15,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '151'.tr,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text('    ${"19.5".tr} : ${purchase.fullname}'),
                Row(
                  children: [
                    Text('    ${"15".tr} : ${purchase.phone}'),
                    const Gap(10),
                    InkWell(
                        onTap: () {
                          launchUrl(Uri.parse('tel: ${purchase.phone}'));
                        },
                        child: const CircleAvatar(
                          radius: 11,
                          child: CircleAvatar(
                            radius: 10,
                            backgroundColor: Color.fromARGB(255, 62, 251, 69),
                            child: Icon(
                              Icons.phone,
                              size: 15,
                            ),
                          ),
                        ))
                  ],
                ),
                Text('    ${"114".tr} : ${purchase.address}'),
                Text(
                  '78'.tr,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text('   #: ${purchase.product.id}'),
                Text(
                    '   ${"149".tr} : ${purchase.product.category.names[lang]}'),
                Text('   ${"31".tr} : ${purchase.product.name}'),
                Text('   ${"33".tr}: ${purchase.product.price} DZD'),
                Text(
                  '150'.tr,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text('${"36".tr} : ${purchase.totalPrice} DZD'),
                Text('${"142".tr} : ${purchase.count} unit'),
                const Gap(10),
                if (isSeller && purchase.status == 'waiting')
                  Form(
                    key: answerKey,
                    child: Column(
                      children: [
                        DropDownView<String>(
                            value: currenctAnswer,
                            items: const [
                              DropdownMenuItem(
                                value: '-1',
                                child: Text('Answer'),
                              ),
                              DropdownMenuItem(
                                value: 'accept',
                                child: Text('Accept'),
                              ),
                              DropdownMenuItem(
                                value: 'refuse',
                                child: Text('Refuse'),
                              ),
                            ],
                            validator: (value) {
                              if (value == '-1') return '';
                            },
                            onChanged: (v) {
                              if (v != null) {
                                setState(() {
                                  currenctAnswer = v;
                                });
                              }
                            }),
                        if (currenctAnswer == 'refuse')
                          myTextFormField(
                            labeltext: 'Disciption',
                            hintText: '',
                            valid: (value) {
                              if (currenctAnswer == 'refuse' &&
                                  value!.isEmpty) {
                                return '';
                              }
                            },
                            mycontroller: disctiptionController,
                          ),
                        ButtonView(
                          onPressed: !isAnswering ? answer : null,
                          backgroundColor: isAnswering ? Colors.grey : null,
                          child: isAnswering
                              ? const SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Answer'),
                        ),
                      ],
                    ),
                  )
                else if (purchase.status == 'seller_refuse') ...[
                  const Gap(15),
                  Text(
                    '34'.tr,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.red,
                    ),
                  )
                ] else if (!isSeller &&
                        (purchase.status == 'waiting' ||
                            purchase.status == 'waiting_client_answer') ||
                    isSeller &&
                        (purchase.status == 'seller_accept' ||
                            purchase.status == 'waiting_client_answer'))
                  DeliverySteperView(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    steps: [
                      for (String step in purchase.deliverySteps.steps.keys)
                        isSeller &&
                                purchase.status == 'waiting_client_answer' &&
                                !purchase.sellerCanReport
                            ? DeliveryStep.loading(
                                step,
                                purchase.deliverySteps.steps[step],
                                null,
                              )
                            : DeliveryStep(
                                step,
                                purchase.deliverySteps.steps[step],
                                isSeller && step != 'Client Received'
                                    ? nextStep
                                    : !isSeller && step == 'Client Received'
                                        ? clientAnswer
                                        : isSeller &&
                                                purchase.status ==
                                                    'waiting_client_answer' &&
                                                purchase.sellerCanReport
                                            ? sellerReport
                                            : null,
                              ),
                    ],
                    currentStep: purchase.deliverySteps.currenctStepIndex,
                    size: const Size(40, 400),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
