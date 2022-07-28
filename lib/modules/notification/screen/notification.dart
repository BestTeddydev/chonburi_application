import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/notification/bloc/notification_bloc.dart';
import 'package:chonburi_mobileapp/modules/notification/models/notification_models.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyNotification extends StatefulWidget {
  final String recipientId;
  const MyNotification({
    Key? key,
    required this.recipientId,
  }) : super(key: key);

  @override
  State<MyNotification> createState() => _MyNotificationState();
}

class _MyNotificationState extends State<MyNotification> {
  @override
  void initState() {
    context.read<NotificationBloc>().add(
          FetchNotificationEvent(
            recipientId: widget.recipientId,
          ),
        );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'การแจ้งเตือน',
          style: TextStyle(color: AppConstant.colorText),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorText),
      ),
      backgroundColor: AppConstant.backgroudApp,
      body: BlocBuilder<NotificationBloc, NotificationState>(
        builder: (context, state) {
          List<NotificationModel> notifications = state.notifications;
          return BlocBuilder<UserBloc, UserState>(
            builder: (context, stateUser) {
              return SingleChildScrollView(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: notifications.length,
                  itemBuilder: (itemBuilder, index) {
                    return Card(
                      color: const Color.fromRGBO(243, 251, 255, 1),
                      margin: const EdgeInsets.all(10),
                      child: Row(
                        children: [
                          Container(
                            width: width * 0.16,
                            height: height * 0.08,
                            margin: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(216, 230, 237, 1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              Icons.notifications_active,
                              color: AppConstant.colorText,
                            ),
                          ),
                          Container(
                            width: width * 0.54,
                            margin: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextCustom(title: notifications[index].title),
                                TextCustom(
                                  title: notifications[index].message,
                                  maxLine: 2,
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: stateUser.user.token.isNotEmpty
                                ? () {
                                    context.read<NotificationBloc>().add(
                                          DeleteNotificationEvent(
                                            docId: notifications[index].id,
                                            token: stateUser.user.token,
                                          ),
                                        );
                                  }
                                : null,
                            icon: Icon(
                              Icons.delete_forever_outlined,
                              color: AppConstant.bgCancelActivity,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
