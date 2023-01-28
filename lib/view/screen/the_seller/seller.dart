import 'package:gap/gap.dart';
import 'package:service_electronic/Data/datasores/contries.dart';
import 'package:service_electronic/core/class/statusRequest.dart';
import 'package:service_electronic/core/constant/bottun.dart';
import 'package:service_electronic/core/constant/castomTextFormField.dart';
import 'package:service_electronic/view/screen/the_seller/controller_seller.dart';
import 'package:service_electronic/view/widget/dropdown.view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:lottie/lottie.dart';

class Seller extends StatelessWidget {
  const Seller({super.key});

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 8, 8, 8),
        title: Center(
          child: Text(
            "128".tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: GetBuilder<SellerController>(
        init: SellerController(),
        builder: (controller) {
          return Form(
            key: controller.sellerVerifiction,
            child: ListView(
              children: [
                SizedBox(height: h * 0.04),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(color: Colors.black, width: 0.5),
                  ),
                  child: DropdownButtonFormField<String>(
                    borderRadius: BorderRadius.circular(12),
                    validator: (value) {
                      if (value == '-1') {
                        return "147".tr;
                      }
                    },
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.green,
                    ),
                    items: [
                      DropdownMenuItem(
                        value: "-1",
                        child: Text("125".tr),
                      ),
                      for (String country in controller.countries.keys)
                        DropdownMenuItem(
                          value: country,
                          child: Text(
                            controller.countries[country]['name'],
                          ),
                        )
                    ],
                    onChanged: (val) {
                      if (val != null) controller.changeCountry(val);
                    },
                    value: controller.slectedCountry.value,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(
                      bottom: 5, top: 30, left: 30, right: 30),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(color: Colors.black, width: 0.5),
                  ),
                  child: DropdownButtonFormField<String>(
                    validator: (value) {
                      if (value == '-1') {
                        return "147".tr;
                      }
                    },
                    icon: const Icon(
                      Icons.location_on,
                      color: Colors.green,
                    ),
                    items: [
                      DropdownMenuItem(
                        value: '-1',
                        child: Text("117".tr),
                      ),
                      if (controller.slectedCountry.value != '-1')
                        for (String state in controller
                            .countries[controller.slectedCountry.value]
                                ['states']
                            .keys)
                          DropdownMenuItem(
                            value: state,
                            child: Text(
                              state,
                            ),
                          )
                    ],
                    onChanged: (val) {
                      if (val != null) controller.changeState(val);
                    },
                    value: controller.slectedState.value,
                  ),
                ),
                if (controller.slectedState.value != '-1')
                  Container(
                    margin: const EdgeInsets.only(left: 30, right: 30, top: 10),
                    child: myTextFormField(
                      mycontroller: controller.address,
                      labeltext: "114".tr,
                      iconData: Icons.location_on,
                      hintText: "115".tr,
                      valid: (value) {
                        if (value!.isEmpty) {
                          return "18".tr;
                        } else if (controller.errors
                            .containsKey('store_address')) {
                          return controller.errors['store_address'];
                        }
                      },
                      enabled: true,
                      border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ),
                  ),
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 30, right: 30),
                  child: myTextFormField(
                    mycontroller: controller.nemstore,
                    labeltext: "80".tr,
                    iconData: Icons.store,
                    hintText: "126".tr,
                    valid: (value) {
                      if (value!.isEmpty) {
                        return "18".tr;
                      } else if (controller.errors.containsKey('store_name')) {
                        return controller.errors['store_name'];
                      }
                    },
                    enabled: true,
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
                AddDeliveryPriceForm(
                  deliveryStates: controller.deliveryStates,
                  onAdd: controller.addDeleveryStatePrice,
                ),
                Container(
                  height: h * 0.4,
                  width: w * 0.9,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 160, 244, 163),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: controller.errors.containsKey('delivery_prices')
                          ? Colors.red
                          : Colors.grey,
                      width: controller.errors.containsKey('delivery_prices')
                          ? 1
                          : 0.5,
                    ),
                  ),
                  child: ListView.builder(
                    itemCount: controller.deliveryStatePrices.length,
                    itemBuilder: (context, index) => DeliveryPriceItem(
                      controller.deliveryStatePrices.values.toList()[index],
                      onDelete: controller.removeDeleveryStatePrice,
                      countries: controller.countries,
                    ),
                  ),
                ),
                if (controller.errors.containsKey('delivery_prices'))
                  Text(
                    controller.errors['delivery_prices']!,
                    style: const TextStyle(
                      color: Colors.red,
                    ),
                  ),
                Container(
                  margin: const EdgeInsets.only(top: 30, left: 40, right: 40),
                  child: myMaterialButton(
                    onPressed: controller.sendRequset,
                    text: "127".tr,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white),
                    color: Colors.black,
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class AddDeliveryPriceForm extends StatefulWidget {
  final List<String> deliveryStates;
  final Function(DeliveryStatePrice deliveryStatePrice) onAdd;
  const AddDeliveryPriceForm({
    super.key,
    required this.deliveryStates,
    required this.onAdd,
  });

  @override
  State<AddDeliveryPriceForm> createState() => _AddDeliveryPriceFormState();
}

class _AddDeliveryPriceFormState extends State<AddDeliveryPriceForm> {
  GlobalKey<FormState> setDeliveryPriceForm = GlobalKey<FormState>();

  String deleveryState = '-1';
  late TextEditingController deliveryStatePrice;
  late TextEditingController deliveryStateHomePrice;

  @override
  void initState() {
    super.initState();

    deliveryStatePrice = TextEditingController();
    deliveryStateHomePrice = TextEditingController();
  }

  @override
  void dispose() {
    deliveryStatePrice.dispose();
    deliveryStateHomePrice.dispose();
    super.dispose();
  }

  add() {
    if (setDeliveryPriceForm.currentState!.validate()) {
      DeliveryStatePrice deliveryStatePrice = DeliveryStatePrice(
        deleveryState,
        double.parse(this.deliveryStatePrice.text),
        double.parse(deliveryStateHomePrice.text),
      );
      widget.onAdd(deliveryStatePrice);
      deleveryState = '-1';
      this.deliveryStatePrice.clear();
      deliveryStateHomePrice.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    return Form(
      key: setDeliveryPriceForm,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(left: 10, right: 10),
            margin:
                const EdgeInsets.only(bottom: 20, top: 30, left: 30, right: 30),
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              border: Border.all(color: Colors.black, width: 0.5),
            ),
            child: DropdownButtonFormField<String>(
              validator: (value) {
                if (value == '-1') {
                  return "147".tr;
                }
              },
              icon: const Icon(
                Icons.location_on,
                color: Colors.green,
              ),
              items: [
                DropdownMenuItem(
                  value: '-1',
                  child: Text("117".tr),
                ),
                for (String state in widget.deliveryStates)
                  DropdownMenuItem(
                    value: state,
                    child: Text(state),
                  ),
              ],
              onChanged: (val) {
                if (val != null) setState(() => {deleveryState = val});
              },
              value: deleveryState,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: w * 0.4,
                // height: h * 0.06,
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '18'.tr;
                    } else if ((double.tryParse(value) ?? 0) <= 0) {
                      return '';
                    }
                  },
                  controller: deliveryStatePrice,
                  decoration: const InputDecoration(
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      label: FittedBox(
                        child: Text(
                          "Office Price",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      enabled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                ),
              ),
              Container(
                width: w * 0.4,
                // height: h * 0.06,
                margin: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '18'.tr;
                    } else if ((double.tryParse(value) ?? 0) <= 0) {
                      return '';
                    }
                  },
                  controller: deliveryStateHomePrice,
                  decoration: const InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    label: FittedBox(
                      child: Text(
                        "Home Price",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    enabled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 15,
            ),
            width: w * 0.4,
            child: myMaterialButton(
              onPressed: add,
              text: "Add".tr,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
              color: Colors.black,
              borderRadius: const BorderRadius.all(Radius.circular(20)),
            ),
          ),
        ],
      ),
    );
  }
}

class DeliveryPriceItem extends StatelessWidget {
  final DeliveryStatePrice deliveryStatePrice;
  final Function(DeliveryStatePrice deliveryStatePrice) onDelete;
  final Map countries;
  const DeliveryPriceItem(
    this.deliveryStatePrice, {
    super.key,
    required this.onDelete,
    required this.countries,
  });

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    final w = MediaQuery.of(context).size.width;
    Widget divider = Container(
      width: 1,
      height: 15,
      color: Colors.black,
    );
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 0.2, color: Colors.grey)),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: w * 0.2,
            child: Text(
              deliveryStatePrice.state,
            ),
          ),
          SizedBox(
              width: w * 0.2,
              child: Text(
                '${deliveryStatePrice.officePrice} DZD',
                overflow: TextOverflow.ellipsis,
              )),
          SizedBox(
              width: w * 0.2,
              child: Text(
                '${deliveryStatePrice.homePrice} DZD',
                overflow: TextOverflow.ellipsis,
              )),
          SizedBox(
            width: w * 0.1,
            child: InkWell(
              onTap: () => onDelete(deliveryStatePrice),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                child: const Icon(
                  Icons.close,
                  color: Colors.red,
                  size: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
