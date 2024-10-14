import 'package:algolia/algolia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findyourdresse_app/model/product_model/productmodel.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:flutter/material.dart';

Algolia algolia = const Algolia.init(
  applicationId: 'Q8SU60JDW6',
  apiKey: '36340e61ce02a1d6ec42f36b18687c07',
);

abstract class AlgoliaServices {
  static Future<List<UserModelFyd>> getResult(
    String queryString,
  ) async {
    List<UserModelFyd> _list = [];

    AlgoliaQuery? search;

    search = algolia.index('index_user_model').query(queryString).setHitsPerPage(1000);

    AlgoliaQuerySnapshot snap = await search.getObjects();
    if (snap.nbHits > 0) {
      print(snap);
      _list = snap.hits.map((e) {
        Map<String, dynamic> tmp = {};
        tmp = e.data;

        return UserModelFyd.fromJson({
          ...tmp,
          "createdAt": Timestamp.fromDate(DateTime.now()),
        }).copyWith(
          id: e.objectID,
        );
      }).toList();
      return _list;
    } else if (queryString.isNotEmpty) {
      return getResult("");
    } else {
      return [];
    }
  }

  static Future<List<ProductModel>> getResultProduct(
    String queryString,
  ) async {
    List<ProductModel> _listProduct = [];

    AlgoliaQuery? search;

    search = algolia.index('index_product').query(queryString).setHitsPerPage(1000);

    AlgoliaQuerySnapshot snap = await search.getObjects();
    if (snap.nbHits > 0) {
      _listProduct = snap.hits.map((e) {
        Map<String, dynamic> tmp = {};
        tmp = e.data;

        return ProductModel.fromJson({
          ...tmp,
          "createdAt": Timestamp.fromDate(DateTime.now()),
        }).copyWith(
          id: e.objectID,
        );
      }).toList();
      return _listProduct;
    } else {
      return [];
    }
  }

  static Future<List<ProductModel>> getResultFilter(
    String queryString,
    String? city,
    String? size,
    String? dressType,
    RangeValues? price,
  ) async {
    List<ProductModel> _listProduct = [];
    AlgoliaQuery? search;
    //todo : add filter
    search = algolia.index('index_product').query(queryString).setHitsPerPage(1000);

    AlgoliaQuerySnapshot snap = await search.getObjects();
    if (snap.nbHits > 0) {
      _listProduct = snap.hits.map((e) {
        Map<String, dynamic> tmp = {};
        tmp = e.data;
        return ProductModel.fromJson({
          ...tmp,
          "createdAt": Timestamp.fromDate(DateTime.now()),
        }).copyWith(
          id: e.objectID,
          ownerId: e.data['ownerId'],
        );
      }).toList();
      return _listProduct;
    } else {
      return [];
    }
  }
}
