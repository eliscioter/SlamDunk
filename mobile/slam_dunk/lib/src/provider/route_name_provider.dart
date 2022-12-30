import 'package:flutter_riverpod/flutter_riverpod.dart';

class RouteName extends StateNotifier<String> {
  RouteName(): super('Slam Dunk Wiki');

  void setRouteName(String routeName) => state = routeName;
   @override
  void dispose() {
    super.dispose();
  }
}

final routeNameProvider = StateNotifierProvider<RouteName, String>((ref) => RouteName());
