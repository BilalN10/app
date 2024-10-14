import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

final userModelProvider = ChangeNotifierProvider<UserChangeNotifier>((ref) {
  return UserChangeNotifier(ref);
});

class UserChangeNotifier with ChangeNotifier {
  // ignore: unused_field
  final ChangeNotifierProviderRef _ref;

  late List<UserModelFyd> _usersModel;
  StreamSubscription? userStream;

  UserChangeNotifier(this._ref) {
    _usersModel = [];

    userStream = FirebaseFirestore.instance.collection("users").snapshots().listen((event) {
      for (final e in event.docChanges) {
        switch (e.type) {
          case DocumentChangeType.added:
            usersModel.add(UserModelFyd.fromJson(e.doc.data()!).copyWith(id: e.doc.id));
            break;
          case DocumentChangeType.modified:
            final index = usersModel.indexWhere((element) => element.id == e.doc.id);
            if (index == -1) return;
            usersModel[index] = UserModelFyd.fromJson(e.doc.data()!).copyWith(id: e.doc.id);
            break;
          case DocumentChangeType.removed:
            usersModel.removeWhere((element) => element.id == e.doc.id);
            break;
        }
        notifyListeners();
      }
    });
  }

  //all users
  List<UserModelFyd> get usersModel => _usersModel;

  //all users premium
  List<UserModelFyd> get modelPremium => usersModel.where((element) => element.premium == true).toList();

  //user by id
  UserModelFyd? getModelById(String id) => _usersModel.firstWhereOrNull((element) => element.id == id);
}
