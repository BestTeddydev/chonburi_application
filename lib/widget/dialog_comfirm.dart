import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/contact_info/models/contact_models.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/models/activity_model.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_activity.dart';
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
        subtitle: Text(
          message,
          style: TextStyle(
            fontSize: 14,
            color: AppConstant.colorText,
            fontWeight: FontWeight.w600,
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
                  onOk(context, activityModel, packageID);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.bgChooseActivity,
                  shadowColor: AppConstant.backgroudApp,
                ),
                child: const Text(
                  'ยืนยัน',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.bgCancelActivity,
                  shadowColor: AppConstant.backgroudApp,
                ),
                child: const Text(
                  'ยกเลิก',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
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
        subtitle: Text(
          message,
          style: TextStyle(
            fontSize: 14,
            color: AppConstant.colorText,
            fontWeight: FontWeight.w600,
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
                  onOk(context, activityModel, packageID);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.bgChooseActivity,
                  shadowColor: AppConstant.backgroudApp,
                ),
                child: const Text(
                  'ยืนยัน',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.bgCancelActivity,
                  shadowColor: AppConstant.backgroudApp,
                ),
                child: const Text(
                  'ยกเลิก',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}

dialogWarningLogin(BuildContext context, Function onOk) {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      backgroundColor: AppConstant.bgAlert,
      title: ListTile(
        title: Icon(
          Icons.error,
          color: AppConstant.bgHastag,
        ),
        subtitle: Text(
          'ไม่สามารถเข้าใช้บริการได้เนื่องจากท่านยังไม่เข้าสู่ระบบกรุณาเข้าสู่ระบบ',
          style: TextStyle(
            fontSize: 14,
            color: AppConstant.colorText,
            fontWeight: FontWeight.w600,
            fontFamily: 'Roboto',
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
                },
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.bgHasTaged,
                  shadowColor: AppConstant.backgroudApp,
                ),
                child: const Text(
                  'เข้าสู่ระบบ',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.bgCancelActivity,
                  shadowColor: AppConstant.backgroudApp,
                ),
                child: const Text(
                  'ยกเลิก',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
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
        subtitle: Center(
          child: Text(
            'คุณต้องการเปลี่ยนข้อมูลติดต่อเบื้องต้นใช่หรือไม่',
            style: TextStyle(
              fontSize: 14,
              color: AppConstant.colorText,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
            ),
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
                child: const Text(
                  'ยืนยัน',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.bgCancelActivity,
                  shadowColor: AppConstant.backgroudApp,
                ),
                child: const Text(
                  'ยกเลิก',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
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
          child: Text(
            message,
            style: TextStyle(
              fontSize: 14,
              color: AppConstant.colorText,
              fontWeight: FontWeight.w600,
              fontFamily: 'Roboto',
            ),
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
                child: const Text(
                  'ยืนยัน',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.bgCancelActivity,
                  shadowColor: AppConstant.backgroudApp,
                ),
                child: const Text(
                  'ยกเลิก',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    ),
  );
}
