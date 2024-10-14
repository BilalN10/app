import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:findyourdresse_app/model/_enum/profil_type_enum.dart';
import 'package:findyourdresse_app/model/user_model_fyd/user_model_fyd.dart';
import 'package:findyourdresse_app/provider/user_provider.dart';
import 'package:findyourdresse_app/services/algolia_services.dart';
import 'package:findyourdresse_app/utils/enum.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skeleton_kosmos/skeleton_kosmos.dart';

final searchProvider = ChangeNotifierProvider<SearchNotifierProvider>((ref) {
  return SearchNotifierProvider(ref);
});

class SearchNotifierProvider extends ChangeNotifier {
  final ChangeNotifierProviderRef _ref;

  SearchNotifierProvider(this._ref);

  List<UserModelFyd> _listModel = [];

  //List Product Model
  List<UserModelFyd> _listShop = [];

  List<UserModelFyd> get listShop => _listShop;
  int get listShopLength => _listShop.length;

  //List User Model
  List<UserModelFyd> get listModel => _listModel;
  int get listModelLength => _listModel.length;

  String? _searchText;

  String? get searchText => _searchText;

  //get model result
  void getSearchResult(val) {
    log(val.toString());
    AlgoliaServices.getResult(val)
        .then((value) => setListModel(value.where((element) => element.premium == true).toList()));
  }

  //get shop result with product
  void getSearchProduct(val) async {
    List<UserModelFyd> _shopList = [];
    final listProducts = await AlgoliaServices.getResultProduct(val);
    for (var element in listProducts) {
      UserModelFyd? user;
      try {
        user = _ref.read(userModelProvider).getModelById(element.ownerId!);
      } catch (e) {}
      if (_shopList.contains(user) == false && user?.premium == true && user!.type == ProfilType.creator.toString()) {
        _shopList.add(user);
      } else {
        print('duplicate or not premium');
      }
    }
    setListShop(_shopList);
  }

  //get shop result with filter

  //todo :
  void getFilterResult(
      {required String queryString, String? city, String? size, String? dressType, RangeValues? price}) async {
    final _listProductFilter = await AlgoliaServices.getResultFilter(queryString, city, size, dressType, price);

    // if (city != null) {
    //   _listProductFilter.removeWhere((element) => element.city != city);
    // }
    if (dressType != null) {
      _listProductFilter.removeWhere((element) => !element.type!.contains(dressType));
    }

    if (size != null) {
      _listProductFilter.removeWhere((element) => !element.size!.contains(size));
    }

    if (price != null) {
      _listProductFilter.removeWhere(
          (element) => double.parse(element.price!).clamp(price.start, price.end) != double.parse(element.price!));
    } else {
      print('no product');
    }
    // sort list to show first element with city match
    if (city != null) {
      _listProductFilter.sort((a, b) {
        if (a.city == city || b.city != city) {
          return -1;
        } else {
          return 1;
        }
      });
    }

    List<UserModelFyd> _shopList = [];

    for (var element in _listProductFilter) {
      var user = _ref.read(userModelProvider).getModelById(element.ownerId!);
      if (_shopList.contains(user) == false && user?.premium == true && user!.type == 'ProfilType.creator') {
        _shopList.add(user);
      } else {
        print('duplicate');
      }
    }
    setListShop(_shopList);
  }

  void clear() {
    _listModel = [];
    _listShop = [];
    _searchText = '';
    _location = null;
    notifyListeners();
  }

  LocationModel? _location;
  LocationModel? get location => _location;
  set setLocation(LocationModel? loc) {
    _location = loc;
    notifyListeners();
  }

  void setListModel(List<UserModelFyd> listModel) {
    _listModel = listModel;
    notifyListeners();
  }

  void setListShop(List<UserModelFyd> listShop) {
    _listShop = listShop;
    notifyListeners();
  }

  void setSearchText(String searchText) {
    _searchText = searchText;
    notifyListeners();
  }
}
