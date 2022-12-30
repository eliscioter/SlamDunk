import 'package:flutter_riverpod/flutter_riverpod.dart';

class Screen extends StateNotifier<int> {
  Screen() : super(0);
  void setScreenIndex(int num) => state = num;
 @override
  void dispose() {
    super.dispose();
  }
}

final screenProvider = StateNotifierProvider<Screen, int>((ref) => Screen());
