import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findyourdresse_app/model/picture_model/picturemodel.dart';

abstract class PictureController {
  static Future<void> addPicture(PictureModel picture) async {
    var ref = FirebaseFirestore.instance.collection("pictures").doc();
    await ref.set(picture.copyWith(id: ref.id).toJson());
  }

  static Future<void> updatePicture(PictureModel picture) async {
    FirebaseFirestore.instance.collection("pictures").doc(picture.id).update(picture.toJson());
  }

  static Future<void> removePicture(String productId) async {
    await FirebaseFirestore.instance.collection("pictures").doc(productId).delete();
  }
}
