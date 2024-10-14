import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final contextProvider = ChangeNotifierProvider<ContextProvider>((ref) {
  return ContextProvider(ref);
});

class ContextProvider with ChangeNotifier {
  // ignore: unused_field
  final ChangeNotifierProviderRef _ref;
  ContextProvider(this._ref);

  BuildContext? _context;
  BuildContext? get context => _context;
  set context(BuildContext? context) {
    _context = context;
    notifyListeners();
  }
}
