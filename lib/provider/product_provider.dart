import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findyourdresse_app/controller/product_controller.dart';
import 'package:findyourdresse_app/model/product_model/productmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final productProvider = ChangeNotifierProvider<ProductChangeNotifier>((ref) {
  return ProductChangeNotifier(ref);
});

class ProductChangeNotifier with ChangeNotifier {
  // ignore: unused_field
  final ChangeNotifierProviderRef _ref;

  late List<ProductModel> product;
  StreamSubscription? productStream;

  ProductChangeNotifier(this._ref) {
    product = [];

    productStream = FirebaseFirestore.instance
        .collection("products")
        .orderBy('createdAt', descending: true)
        .snapshots()
        .listen((event) {
      for (final e in event.docChanges) {
        switch (e.type) {
          case DocumentChangeType.added:
            product.add(ProductModel.fromJson(e.doc.data()!).copyWith(id: e.doc.id));
            break;
          case DocumentChangeType.modified:
            final index = product.indexWhere((element) => element.id == e.doc.id);
            if (index == -1) return;
            product[index] = ProductModel.fromJson(e.doc.data()!).copyWith(id: e.doc.id);
            break;
          case DocumentChangeType.removed:
            product.removeWhere((element) => element.id == e.doc.id);
            break;
        }
        notifyListeners();
      }
    });
  }
  List<ProductModel> getProduct() => product;

  ProductModel? getProductById(String id) => product.firstWhereOrNull((element) => element.id == id);

  List<ProductModel> getCreatorProducts(String id) {
    List<ProductModel> _list = product.where((element) => element.ownerId == id).toList();
    _list.sort((a, b) => b.createdAt!.compareTo(a.createdAt!));
    return _list;
  }

  //product methods

  Future<void> getFileImage() async {}

  Future<void> updateProduct({required ProductModel product}) async {
    ProductController.updateProduct(product);
  }

  Future<String?> addProduct(ProductModel product, String id) async {
    return await ProductController.addProduct(product, id);
  }

  Future<void> removeProduct(String productId) async {
    ProductController.removeProduct(productId);
  }
}
