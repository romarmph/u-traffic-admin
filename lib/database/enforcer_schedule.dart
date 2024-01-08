import 'dart:async';

import 'package:u_traffic_admin/config/exports/exports.dart';

class EnforcerScheduleDatabse {
  const EnforcerScheduleDatabse._();

  static const EnforcerScheduleDatabse _instance = EnforcerScheduleDatabse._();
  static EnforcerScheduleDatabse get instance => _instance;

  static final _firestore = FirebaseFirestore.instance;
  static final _enforcerSchedRef = _firestore.collection('enforcerSchedules');

  Stream<List<EnforcerSchedule>> getAllEnforcerSched() {
    try {
      return _enforcerSchedRef
          .snapshots(
        includeMetadataChanges: true,
      )
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return EnforcerSchedule.fromJson(
            doc.data(),
            doc.id,
          );
        }).toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<EnforcerSchedule>> getAllUnassignedSchedules() {
    try {
      return _enforcerSchedRef
          .where(
            'enforcerId',
            isEqualTo: '',
          )
          .snapshots()
          .map((snapshot) {
        return snapshot.docs.map((doc) {
          return EnforcerSchedule.fromJson(
            doc.data(),
            doc.id,
          );
        }).toList();
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<EnforcerSchedule> getEnforcerSchedById(String id) {
    try {
      return _enforcerSchedRef.doc(id).snapshots().map((snapshot) {
        return EnforcerSchedule.fromJson(
          snapshot.data()!,
          snapshot.id,
        );
      });
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addEnforcerSched(EnforcerSchedule enforcerSched) async {
    try {
      await _enforcerSchedRef.add(enforcerSched.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> updateEnforcerSched(EnforcerSchedule enforcerSched) async {
    try {
      await _enforcerSchedRef
          .doc(enforcerSched.id)
          .update(enforcerSched.toJson());
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteEnforcerSched(String id) async {
    try {
      await _enforcerSchedRef.doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteEnforcerSchedByPostId(String id) async {
    try {
      await _enforcerSchedRef.where('postId', isEqualTo: id).get().then(
        (snapshot) {
          for (DocumentSnapshot ds in snapshot.docs) {
            ds.reference.delete();
          }
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setEnforcerToSchedule({
    required String enforcerId,
    required String scheduleId,
    required String adminId,
    required String enforcerName,
  }) async {
    try {
      await _enforcerSchedRef.doc(scheduleId).update({
        'enforcerId': enforcerId,
        'enforcerName': enforcerName,
        'updatedBy': adminId,
        'updatedAt': Timestamp.now(),
      });
    } catch (e) {
      rethrow;
    }
  }

  Stream<List<Enforcer>> getAvailableEnforcersStream(
      Timestamp givenDay) async* {
    List<EnforcerSchedule> schedules = [];
    List<Enforcer> enforcers = [];

    await _firestore
        .collection('enforcerSchedules')
        .where('scheduleDay', isEqualTo: givenDay)
        .get()
        .then((value) {
      for (var element in value.docs) {
        schedules.add(EnforcerSchedule.fromJson(element.data(), element.id));
      }
    });

    await _firestore.collection('enforcers').get().then((value) {
      for (var element in value.docs) {
        enforcers.add(Enforcer.fromJson(element.data(), element.id));
      }
    });

    yield enforcers.where((element) {
      return schedules.every((element2) {
        return element.id != element2.enforcerId;
      });
    }).toList();
  }

  Stream<List<TrafficPost>> getAvailableTrafficPostsStream(
      Timestamp givenDay) async* {
    List<EnforcerSchedule> schedules = [];
    List<TrafficPost> trafficPosts = [];

    await _firestore
        .collection('enforcerSchedules')
        .where('scheduleDay', isEqualTo: givenDay)
        .get()
        .then((value) {
      for (var element in value.docs) {
        schedules.add(EnforcerSchedule.fromJson(element.data(), element.id));
      }
    });

    await _firestore.collection('trafficPosts').get().then((value) {
      for (var element in value.docs) {
        trafficPosts.add(TrafficPost.fromJson(element.data(), element.id));
      }
    });

    yield trafficPosts.where((element) {
      return schedules.every((element2) {
        return element.id != element2.postId;
      });
    }).toList();
  }
}
