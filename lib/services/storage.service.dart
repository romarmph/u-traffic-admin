import 'package:u_traffic_admin/config/exports/exports.dart';

class StorageService {
  const StorageService._();

  static const StorageService _instance = StorageService._();
  static StorageService get instance => _instance;

  static final _firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadImage(MediaInfo image, String uid) async {
    final fileName = image.fileName;
    final fileType = fileName!.split('.').last;

    final ref = _firebaseStorage.ref('profileImage').child('$uid.$fileType');
    final uploadTask = ref.putData(image.data!);
    final snapshot = await uploadTask.whenComplete(() => null);
    final url = await snapshot.ref.getDownloadURL();
    return url;
  }
}
