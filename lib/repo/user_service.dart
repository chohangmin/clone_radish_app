import 'package:clone_radish_app/utils/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserService {
  Future fireStoreWriteTest() async {
    FirebaseFirestore.instance.collection('TEST_COLLECTION').add(
      {
        'test': 'testing value',
        'number': '12314124',
      },
    );
  }

  void fireStoreReadTest() {
    FirebaseFirestore.instance
        .collection('TEST_COLLECTION')
        .doc('7W6k3kEuzAWlAi8V5yZt')
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> value) =>
            logger.d(value.data()));
  }
}
