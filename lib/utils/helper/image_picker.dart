import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PickerImage {
  static final ImagePicker _picker = ImagePicker();
  static Future<File?> getImage() async {
    PermissionStatus photoStatus = await Permission.photos.status;
    if (!photoStatus.isGranted) {
      await Permission.photos.request();
    }
    try {
      XFile? image = await _picker.pickImage(
          source: ImageSource.gallery, maxWidth: 800, maxHeight: 500);
      return File(image!.path);
    } catch (e) {
      return null;
    }
  }

  static Future<File?> takePhoto() async {
    PermissionStatus cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
    try {
      XFile? takePhoto = await _picker.pickImage(
          source: ImageSource.camera, maxWidth: 800, maxHeight: 500);
      return File(takePhoto!.path);
    } catch (e) {
      return null;
    }
  }

  static Future<File?> getVideo() async {
    PermissionStatus photoStatus = await Permission.photos.status;
    if (!photoStatus.isGranted) {
      await Permission.photos.request();
    }
    try {
      XFile? video = await _picker.pickVideo(source: ImageSource.gallery);
      File videoFile = File(video!.path);
      int fileSizeLimit = 500000000; // 500 ล้าน bytes = 500MB
      int fileSize = await videoFile.length();
      bool validFileSize = fileSize > fileSizeLimit;
      if (validFileSize) {
        return null;
      }
      return videoFile;
    } catch (e) {
      return null;
    }
  }

  static Future<File?> takeVedeo() async {
    PermissionStatus cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
    try {
      XFile? takeVideo = await _picker.pickVideo(source: ImageSource.camera);
      return File(takeVideo!.path);
    } catch (e) {
      return null;
    }
  }
}
