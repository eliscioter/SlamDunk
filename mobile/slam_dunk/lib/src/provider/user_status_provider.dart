import 'package:flutter_riverpod/flutter_riverpod.dart';

class VerifySignIn extends StateNotifier<bool> {

  VerifySignIn() : super(false);
  void isSignedIn(bool status) => state = status;

  @override
  void dispose() {
    super.dispose();
  }
}

final isSignedInProvider =
    StateNotifierProvider<VerifySignIn, bool>((ref) => VerifySignIn());
