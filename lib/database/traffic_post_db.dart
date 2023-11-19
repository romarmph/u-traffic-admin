import 'package:u_traffic_admin/config/exports/exports.dart';

class TrafficPostDatabase {
  const TrafficPostDatabase._();

  static const TrafficPostDatabase _instance = TrafficPostDatabase._();
  static TrafficPostDatabase get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;

  static final _collectionRef = _firestore.collection('trafficPosts');

  Stream<List<TrafficPost>> getAllTrafficPostStream() {
    return _collectionRef.orderBy('number').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return TrafficPost.fromJson(doc.data(), doc.id);
      }).toList();
    });
  }
}
