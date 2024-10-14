import 'dart:io' show Platform;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class PurchaseApi {
  static const public_ios_sdk_key = 'appl_naWvUkZAMhZqlstJHgCWQHtzrBv';
  static const public_google_sdk_key = 'goog_AXMoIqVeGZnHfmLolPFWaPNGUdq';

  static Future<void> initPlatformState() async {
    await Purchases.setDebugLogsEnabled(true);

    PurchasesConfiguration configuration;

    if (Platform.isIOS) {
      configuration = PurchasesConfiguration(public_ios_sdk_key);
      await Purchases.configure(configuration);
    } else if (Platform.isAndroid) {
      configuration = PurchasesConfiguration(public_google_sdk_key);
      await Purchases.configure(configuration);
    }
  }

  static Future<Offerings?> fetchOffers() async {
    Offerings offerings = await Purchases.getOfferings();

    return offerings;
  }

  static Future<void> updateCustomerStatus() async {
    await Purchases.logIn(FirebaseAuth.instance.currentUser!.uid);
  }

  static Future<void> purchasePackage(Package package) async {
    try {
      await Purchases.purchasePackage(package);
    } catch (e) {
      print(e);
    }
  }
}
