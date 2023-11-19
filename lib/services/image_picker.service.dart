import 'package:u_traffic_admin/config/exports/exports.dart';

class ImagePickerService {
  const ImagePickerService._();

  static const ImagePickerService _instance = ImagePickerService._();
  static ImagePickerService get instance => _instance;

  Future<MediaInfo?> pickImage() async {
    final pickedFile = await ImagePickerWeb.getImageInfo;
    if (pickedFile != null) {
      return pickedFile;
    }
    return null;
  }
}
