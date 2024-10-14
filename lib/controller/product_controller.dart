import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findyourdresse_app/model/product_model/productmodel.dart';

abstract class ProductController {
  static Future<String> addProduct(ProductModel product, String id) async {
    var ref = FirebaseFirestore.instance.collection("products").doc(id);
    await ref.set(product.copyWith(id: id).toJson());
    return ref.id;
  }

  static Future<void> updateProduct(ProductModel product) async {
    await FirebaseFirestore.instance.collection("products").doc(product.id).set(product.toJson());
    // await ref.set(product.copyWith(id: ref.id).toJson());
  }

  static Future<void> removeProduct(String productId) async {
    await FirebaseFirestore.instance.collection("products").doc(productId).delete();
  }
}
