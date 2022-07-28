import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/utils/helper/image_helper.dart';
import 'package:flutter/material.dart';

dialogCamera(BuildContext context, Function fStateFile) {
  showModalBottomSheet(
    context: context,
    builder: (builder) {
      return SizedBox(
        height: 180,
        child: Column(
          children: [
            Container(
              width: double.maxFinite,
              height: 55,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0, 0.4),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  onGetImage(context, fStateFile);
                  Navigator.pop(context);
                },
                child: Text(
                  'แกลออรี่',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppConstant.bgbutton,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 55,
              decoration: const BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0, 0.4),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () {
                  onTakeImage(context, fStateFile);
                  Navigator.pop(context);
                },
                child: Text(
                  'ถ่ายรูป',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppConstant.bgbutton,
                    // fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            Container(
              width: double.maxFinite,
              height: 60,
              decoration: const BoxDecoration(
                color: Colors.white,
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'ยกเลิก',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppConstant.bgbutton,
                    // fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
