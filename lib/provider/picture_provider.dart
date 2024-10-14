import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findyourdresse_app/controller/picture_controller.dart';
import 'package:findyourdresse_app/model/picture_model/picturemodel.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final pictureProvider = ChangeNotifierProvider<PictureChangeNotifier>((ref) {
  return PictureChangeNotifier(ref);
});

class PictureChangeNotifier with ChangeNotifier {
  // ignore: unused_field
  final ChangeNotifierProviderRef _ref;

  late List<PictureModel> picture;
  StreamSubscription? pictureStream;

  PictureChangeNotifier(this._ref) {
    picture = [];

    pictureStream = FirebaseFirestore.instance
        .collection("pictures")
        .orderBy("createdAt", descending: true)
        .snapshots()
        .listen((event) {
      for (final e in event.docChanges) {
        switch (e.type) {
          case DocumentChangeType.added:
            picture.add(PictureModel.fromJson(e.doc.data()!).copyWith(id: e.doc.id));
            break;
          case DocumentChangeType.modified:
            final index = picture.indexWhere((element) => element.id == e.doc.id);
            if (index == -1) return;
            picture[index] = PictureModel.fromJson(e.doc.data()!).copyWith(id: e.doc.id);
            break;
          case DocumentChangeType.removed:
            picture.removeWhere((element) => element.id == e.doc.id);
            break;
        }
        notifyListeners();
      }
    });
  }

  //pictures where premium is true
  List<PictureModel> get pictures {
    List<PictureModel> _pictures = picture.where((element) => element.premium == true).toList();
    _pictures.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return _pictures;
  }

  //pictures by Id
  PictureModel? getPictureById(String id) => picture.firstWhereOrNull((element) => element.id == id);

  //pictures by ownerId
  List<PictureModel> getModelPictures(String id) => picture.where((element) => element.ownerId == id).toList();

  //photo methods
  Future<void> addPicture(PictureModel picture) async {
    PictureController.addPicture(picture);
  }

  Future<void> updatePicture(PictureModel picture) async {
    PictureController.updatePicture(picture);
  }

  Future<void> removePicture(String productId) async {
    PictureController.removePicture(productId);
  }
}
