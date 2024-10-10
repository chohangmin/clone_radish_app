import 'package:clone_radish_app/constants/data_keys.dart';
import 'package:clone_radish_app/data/user_model.dart';
import 'package:clone_radish_app/utils/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  static final UserService _userService = UserService._internal();
  factory UserService() => _userService;
  UserService._internal();

  Future createNewUser(Map<String, dynamic> json, String userKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);

    final DocumentSnapshot documentSnapshot = await documentReference.get();
    logger.d('json : $json');
    if (!documentSnapshot.exists) {
      await documentReference.set(json);
      logger.d('데이터 베이스 등록 성공!');
    } else {
      logger.d('이미 있다.');
    }
  }

  Future<UserModel> getUserModel(String userKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);

    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentReference.get();
    UserModel userModel = UserModel.fromSnapshot(documentSnapshot);
    return userModel;
  }
}
