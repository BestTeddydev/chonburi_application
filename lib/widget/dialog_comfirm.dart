import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/screen/login.dart';
import 'package:chonburi_mobileapp/modules/contact_info/models/contact_models.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/models/activity_model.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_activity.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';

dialogConfirmActivity(BuildContext context, OrderActivityModel activityModel,
    String message, Function onOk, String packageID) {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      backgroundColor: AppConstant.bgAlert,
      title: ListTile(
        title: Icon(
          Icons.error,
          color: AppConstant.bgHastag,
        ),
        subtitle: TextCustom(title: message),
      ),
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  onOk(context, activityModel, packageID);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.bgChooseActivity,
                  shadowColor: AppConstant.backgroudApp,
                ),
                child: const TextCustom(
                  title: 'ยืนยัน',
                  fontSize: 12,
                  fontColor: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.bgCancelActivity,
                  shadowColor: AppConstant.backgroudApp,
                ),
                child: const TextCustom(
                  title: 'ยกเลิก',
                  fontSize: 12,
                  fontColor: Colors.white,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

dialogApproveActivity(BuildContext context, ActivityModel activityModel,
    String message, Function onOk, String packageID) {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      backgroundColor: AppConstant.bgAlert,
      title: ListTile(
        title: Icon(
          Icons.error,
          color: AppConstant.bgHastag,
        ),
        subtitle: TextCustom(title: message),
      ),
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  onOk(context, activityModel, packageID);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.bgChooseActivity,
                  shadowColor: AppConstant.backgroudApp,
                ),
                child: const TextCustom(
                  title: 'ยิืนยัน',
                  fontSize: 12,
                  fontColor: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.bgCancelActivity,
                  shadowColor: AppConstant.backgroudApp,
                ),
                child: const TextCustom(
                  title: 'ยกเลิก',
                  fontSize: 12,
                  fontColor: Colors.white,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

dialogWarningLogin(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      backgroundColor: AppConstant.bgAlert,
      title: ListTile(
        title: Icon(
          Icons.error,
          color: AppConstant.bgHastag,
        ),
        subtitle: const TextCustom(
          title:
              'ไม่สามารถเข้าใช้บริการได้เนื่องจากท่านยังไม่เข้าสู่ระบบกรุณาเข้าสู่ระบบ',
          fontSize: 14,
          maxLine: 2,
        ),
      ),
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => const AuthenLogin(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.bgHasTaged,
                  shadowColor: AppConstant.backgroudApp,
                ),
                child: const TextCustom(
                  title: 'เข้าสู่ระบบ',
                  fontSize: 12,
                  fontColor: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.bgCancelActivity,
                  shadowColor: AppConstant.backgroudApp,
                ),
                child: const TextCustom(
                  title: 'ยกเลิก',
                  fontSize: 12,
                  fontColor: Colors.white,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

dialogConfirmContact(
    BuildContext context, Function onOk, ContactModel contactModel) {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      backgroundColor: AppConstant.bgAlert,
      title: ListTile(
        title: Icon(
          Icons.error,
          color: AppConstant.bgHastag,
        ),
        subtitle: const Center(
          child: TextCustom(
            title: 'คุณต้องการเปลี่ยนข้อมูลติดต่อเบื้องต้นใช่หรือไม่',
            fontSize: 14,
          ),
        ),
      ),
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  onOk(context, contactModel);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.bgHasTaged,
                  shadowColor: AppConstant.backgroudApp,
                ),
                child: const TextCustom(
                    title: 'ยืนยัน', fontSize: 12, fontColor: Colors.white),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.bgCancelActivity,
                  shadowColor: AppConstant.backgroudApp,
                ),
                child: const TextCustom(
                  title: 'ยกเลิก',
                  fontSize: 12,
                  fontColor: Colors.white,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

dialogConfirm(BuildContext context, Function onOk, String message) {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      backgroundColor: AppConstant.bgAlert,
      title: ListTile(
        title: Icon(
          Icons.error,
          color: AppConstant.bgHastag,
        ),
        subtitle: Center(
          child: TextCustom(
            title: message,
          ),
        ),
      ),
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  onOk(context);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.bgHasTaged,
                  shadowColor: AppConstant.backgroudApp,
                ),
                child: const TextCustom(
                  title: 'ยืนยัน',
                  fontSize: 12,
                  fontColor: Colors.white,
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.bgCancelActivity,
                  shadowColor: AppConstant.backgroudApp,
                ),
                child: const TextCustom(
                  title: 'ยกเลิก',
                  fontSize: 12,
                  fontColor: Colors.white,
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
