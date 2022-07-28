import 'package:permission_handler/permission_handler.dart';

class PermissionHandle {
  static Future<bool> isPhotoDeniend() async {
    PermissionStatus photoStatus = await Permission.photos.status;
    return photoStatus.isPermanentlyDenied;
  }

  static Future<bool> isCameraDeniend() async {
    PermissionStatus cameraStatus = await Permission.camera.status;
    return cameraStatus.isPermanentlyDenied;
  }

}