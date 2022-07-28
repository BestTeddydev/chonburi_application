// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:chonburi_mobileapp/utils/helper/image_picker.dart';
import 'package:chonburi_mobileapp/utils/helper/permission_handle.dart';
import 'package:chonburi_mobileapp/widget/alert_service.dart';
import 'package:flutter/material.dart';

onGetImage(BuildContext context, Function fStateFile) async {
  File? image = await PickerImage.getImage();
  if (image == null) {
    bool isDeniend = await PermissionHandle.isPhotoDeniend();
    if (isDeniend) {
      alertService(
        context,
        'ไม่อนุญาติเข้าถึง Photo',
        'โปรดแชร์ Photo',
      );
    }
    return;
  }
  fStateFile(image);
}

onTakeImage(BuildContext context, Function fStateFile) async {
  File? image = await PickerImage.takePhoto();
  if (image == null) {
    bool isDeniend = await PermissionHandle.isCameraDeniend();
    if (isDeniend) {
      alertService(
        context,
        'ไม่อนุญาติเข้าถึง Camera',
        'โปรดแชร์ Camera',
      );
    }
    return;
  }
  fStateFile(image);
}
