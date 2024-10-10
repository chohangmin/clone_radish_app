import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';

class UserModel {
  late String userKey;
  late String phoneNumber;
  late String address;
  late GeoFirePoint geoFirePoint;
  late DateTime createdDate;
  DocumentReference? reference;

  UserModel({
    required this.userKey,
    required this.phoneNumber,
    required this.address,
    required this.geoFirePoint,
    required this.createdDate,
    this.reference,
  });

  UserModel.fromJson(dynamic json, this.userKey, this.reference) {
    userKey = json['userKey'];
    phoneNumber = json['phoneNumber'];
    address = json['address'];
    geoFirePoint = GeoFirePoint(
      GeoPoint(
        (json['geoFirePoint']['geopoint']).latitude,
        (json['geoFirePoint']['geopoint']).longitude,
      ),
    );
    createdDate = json['createdDate'] == null
        ? DateTime.now().toUtc()
        : (json['createdDate'] as Timestamp).toDate();
    reference = json['reference'];
  }

  UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromJson(snapshot.data()!, snapshot.id, snapshot.reference);

  Map<String, dynamic> toJson() {
    return {
      'phoneNumber': phoneNumber,
      'address': address,
      'geoPoint': geoFirePoint.data,
      'createdDate': createdDate,
    };
  }
}
