import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waco_mobile/models/user_likes.dart';

class UserLikesProvider {
  static Future<UserLikes> getLikes(String uid) async {
    DocumentReference userDoc =
        FirebaseFirestore.instance.doc('usersLikes/$uid');
    DocumentSnapshot user = await userDoc.get();
    try {
      return UserLikes(likes: [...user["likes"]]);
    } catch (e) {
      throw Exception(e);
    }
  }
}
