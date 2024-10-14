import 'package:findyourdresse_app/model/_enum/profil_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final profilTypeProvider = ChangeNotifierProvider<ProfilTypeProvider>((ref) {
  return ProfilTypeProvider();
});

class ProfilTypeProvider with ChangeNotifier {
  ProfilType? _type;

  ProfilType? get type => _type;

  void clear() {
    _type = null;
    notifyListeners();
  }

  setProfilType(ProfilType type) {
    _type = type;
    notifyListeners();
  }
}
