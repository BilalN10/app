import 'package:hooks_riverpod/hooks_riverpod.dart';

final navigationProvider = StateNotifierProvider<NavigationProvider, String>((ref) {
  return NavigationProvider("home");
});

class NavigationProvider extends StateNotifier<String> {
  NavigationProvider(String initialState) : super(initialState);

  void update(String route) {
    state = route;
  }
}
