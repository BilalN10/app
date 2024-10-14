import 'dart:io';

import 'package:findyourdresse_app/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final productFormProvider = ChangeNotifierProvider<ProductNotifier>((ref) {
  return ProductNotifier();
});

class ProductNotifier with ChangeNotifier {
  List<String> _type = [];
  List<String> _size = [];
  String? _name;
  String? _description;
  String? _price;
  List<String?>? _productImage = [];
  List<File>? _productImageFile = [];
  Morphology? _morphology;
  List<String> get type => _type;
  List<String> get size => _size;
  Morphology? get morphology => _morphology;
  String? get name => _name;
  String? get description => _description;
  String? get price => _price;
  List<String?>? get productImage => _productImage;
  List<File>? get productImageFile => _productImageFile;

  void clear() {
    _type = [];
    _name = null;
    _description = null;
    _price = null;
    _productImage = [];
    _productImageFile = [];
    notifyListeners();
  }

  void setType(List<String> type) {
    _type = type;
    notifyListeners();
  }

  void setSize(List<String> listSize) {
    _size = listSize;
    notifyListeners();
  }

  void setMorphology(Morphology? val) {
    _morphology = val;
    notifyListeners();
  }

  void setName(String name) {
    _name = name;
    notifyListeners();
  }

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  void setPrice(String price) {
    _price = price;
    notifyListeners();
  }

  void setProductImage(List<String> productImage) {
    _productImage = productImage;
    notifyListeners();
  }

  void addToProductImage(String url) {
    _productImage!.add(url);
    notifyListeners();
  }

  void setProductImageFile(List<File> productImageFile) {
    _productImageFile = productImageFile;
    notifyListeners();
  }
}
