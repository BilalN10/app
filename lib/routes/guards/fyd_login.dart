import 'package:firebase_auth/firebase_auth.dart';
import 'package:auto_route/auto_route.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

/// Check if User is already logged in. If not, redirect to Login Page.
///
/// {@category Guard}
/// {@subCategory authentication}
class FydLoginGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    printInDebug(FirebaseAuth.instance.currentUser);

    router.replaceNamed("/home-screen");
    resolver.next(true);
  }
}
