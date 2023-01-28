import 'package:service_electronic/Data/model/product.model.dart';
import 'package:service_electronic/core/middleware/mymiddleware.dart';
import 'package:service_electronic/view/Auth/ferigetpassword/createnewpassword.dart';
import 'package:service_electronic/view/Auth/ferigetpassword/verfiycodesingup/verifiycodesingup.dart';
import 'package:service_electronic/view/Auth/ferigetpassword/virifaycode.dart';
import 'package:service_electronic/view/screen/Shipping/Pay.dart';
import 'package:service_electronic/view/screen/screen_home/home/home.dart';
import 'package:service_electronic/view/screen/login.dart';
import 'package:service_electronic/view/screen/screen_home/home/home_cart.dart';
import 'package:service_electronic/view/screen/screen_home/home/profile.dart';
import 'package:service_electronic/view/screen/screen_home/screen_Service/offers_cart.dart';
import 'package:service_electronic/view/screen/screen_home/screen_Store/store_cart.dart';
import 'package:service_electronic/view/screen/screen_home/screen_Mobileservice/Mobile_service.dart';
import 'package:service_electronic/view/screen/screen_home/screen_Service/offer_request.dart';
import 'package:service_electronic/view/screen/screen_home/screen_Store/purchase_details.dart';
import 'package:service_electronic/view/screen/screen_home/screen_Store/buy_product.dart';
import 'package:service_electronic/view/screen/screen_home/screen_echange/echonge.dart';
import 'package:service_electronic/view/screen/screen_home/screen_echange/My_transactions.dart';

import 'package:service_electronic/view/screen/screen_home/screen_Service/service.dart';
import 'package:service_electronic/view/screen/screen_home/screen_echange/echonge_2.dart';
import 'package:service_electronic/view/screen/screen_home/screen_Store/add_product.dart';
import 'package:service_electronic/view/screen/screen_home/screen_Store/store.dart';
import 'package:service_electronic/view/Auth/ferigetpassword/forgetpassword.dart';
import 'package:service_electronic/view/screen/settings.dart';
import 'package:service_electronic/view/screen/singup.dart';
import 'package:service_electronic/view/screen/screen_home/Conditions/conditions.dart';
import 'package:service_electronic/view/screen/support/support_link.dart';
import 'package:service_electronic/view/screen/the_seller/seller.dart';
import 'package:service_electronic/view/screen/the_seller/seller2.dart';

import 'package:get/get.dart';

import 'view/screen/screen_home/screen_Store/purchases_cart.dart';

class AppRoute {
  //Auth
  static const String login = "/Login";
  static const String singuo = "/singup";
  static const String forgetpassword = "/Forgetpassword";
  static const String verificode = "/Verificode";
  static const String VerificodeSingup = "/Verificodesingup";
  static const String createpassword = "/Createpassword";

  static const List<String> unAuthedPages = [
    '/',
    login,
    singuo,
    forgetpassword,
    verificode,
    VerificodeSingup,
    createpassword
  ];

  // home
  static const String home = "/Home";
  static const String homeCart = "/HomeCart";
  static const String myechonge = "/MyEchonge";
  static const String Echonge_2 = "/echonge_2";
  static const String myservice = "/MyService";
  static const String offerRequest = "/offerRequest";
  static const String offersCart = "/OffersCart";
  static const String mobile = "/Mobile_service";
  static const String ProductModel = "/MyStore";
  static const String store2 = "/Store2";
  static const String purchases = "/Purchases";
  static const String purchaseDetails = "/PurchaseDetails";

  static const String notification = "/Notification";
  static const String my_transactions = "/My_transactions";
  static const String addProduct = "/AddProduct";
  static const String setting = "/Setting";
  static const String seller = "/Seller";
  static const String seller2 = "/Seller2";
  static const String support = "/Supportlink";
  static const String conditions = "/Conditions";
  static const String pay = "/Pay";
  static const String profiel = "/Profiel";

  static List<GetPage<dynamic>> routes = [
    GetPage(
        name: "/", page: () => const Login(), middlewares: [MyMiddleware()]),
    //GetPage(name: AppRoute.login, page: () => const Login()),
    GetPage(name: AppRoute.home, page: () => const Home()),
    GetPage(name: AppRoute.homeCart, page: () => const HomeCart()),

    GetPage(name: AppRoute.singuo, page: () => const singup()),
    GetPage(name: AppRoute.forgetpassword, page: () => const Forgetpassword()),
    GetPage(name: AppRoute.VerificodeSingup, page: () => Verificodesingup()),
    GetPage(name: AppRoute.verificode, page: () => Verificode()),
    GetPage(name: AppRoute.createpassword, page: () => const Createpassword()),

    // hompage

    GetPage(name: AppRoute.myechonge, page: () => const MyEchonge()),
    GetPage(name: AppRoute.Echonge_2, page: () => const echonge_2()),
    GetPage(name: AppRoute.myservice, page: () => const MyService()),
    GetPage(name: AppRoute.offerRequest, page: () => const OfferRequest()),
    GetPage(name: AppRoute.offersCart, page: () => const OffersCart()),
    GetPage(name: AppRoute.ProductModel, page: () => const MyStore()),
    GetPage(name: AppRoute.store2, page: () => const Store2()),
    GetPage(name: AppRoute.purchases, page: () => const Purchases()),
    GetPage(
        name: AppRoute.purchaseDetails, page: () => const PurchaseDetails()),
    GetPage(
        name: AppRoute.my_transactions, page: () => const My_transactions()),
    GetPage(name: AppRoute.notification, page: () => const Notification()),
    GetPage(name: AppRoute.addProduct, page: () => const AddProduct()),
    GetPage(name: AppRoute.mobile, page: () => const Mobile_service()),
    GetPage(name: AppRoute.setting, page: () => const Setting()),
    GetPage(name: AppRoute.support, page: () => const Supportlink()),
    GetPage(name: AppRoute.conditions, page: () => const Conditions()),
    GetPage(name: AppRoute.seller, page: () => const Seller()),
    GetPage(name: AppRoute.seller2, page: () => const Seller2()),
    GetPage(name: AppRoute.pay, page: () => const Pay()),
    GetPage(name: AppRoute.profiel, page: () => const Profiel()),
  ];
}
