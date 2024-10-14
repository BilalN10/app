import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final homePictureProvider = ChangeNotifierProvider<HomePictureChangeNotifier>((ref) {
  return HomePictureChangeNotifier(ref);
});

class HomePictureChangeNotifier with ChangeNotifier {
  // ignore: unused_field
  final ChangeNotifierProviderRef _ref;

  String? homePicture;
  StreamSubscription? homePictureStream;

  HomePictureChangeNotifier(this._ref) {
    homePictureStream =
        FirebaseFirestore.instance.collection("HomePicture").doc('homePicture').snapshots().listen((event) {
      if (event.exists) {
        homePicture = event.data()!['pictureUrl'];
        notifyListeners();
        log(homePicture!);
      } else {
        homePicture = 'https://stylesatlife.com/wp-content/uploads/2021/06/Diana-Penty.jpg';
        notifyListeners();
        log(homePicture!);
      }
    });
  }

  String? gethomePicture() => homePicture;
}
