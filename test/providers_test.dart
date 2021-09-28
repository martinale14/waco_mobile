import 'package:firebase_core/firebase_core.dart';
import 'package:test/test.dart';
import 'package:waco_mobile/providers/user_likes_provider.dart';

void main() {
  test(
      'Provider user_likes_provider recieve not registered uid returns an exception',
      () {
    var result = UserLikesProvider.getLikes('Wrong uid');
    expect(result, throwsException);
  });

  test(
      'Provider user_likes_provider recieve registerd uid returns instance of UserLikes',
      () async {
    await Firebase.initializeApp();

    var result =
        await UserLikesProvider.getLikes('mOuTNAwHVXckv7Pl0cwkgbM6S383');
    expect(result.likes.isNotEmpty, equals(true));
  });
}
