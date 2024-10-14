import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:auto_route/auto_route.dart';
import 'package:get_it/get_it.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

///
/// {@category Guard}
/// {@subCategory authentication}
class AlreadyLoggedGuardCustom extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    if (FirebaseAuth.instance.currentUser != null) {
      CustomSharedPreferences.instance.setBooleanValue("alreadyRun", true);

      if (kDebugMode) {
        print("User connected");
      }
      router.pushAndPopUntil(GetIt.instance<ApplicationDataModel>().mainRoute, predicate: (_) => false);
    } else {
      if (kDebugMode) {
        print("No User connected");
      }
      resolver.next(true);
    }
  }
}
