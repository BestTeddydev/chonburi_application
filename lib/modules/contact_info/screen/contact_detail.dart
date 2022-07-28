import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/contact_info/bloc/contact_bloc.dart';
import 'package:chonburi_mobileapp/modules/contact_info/screen/contact_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactDetail extends StatefulWidget {
  const ContactDetail({Key? key}) : super(key: key);

  @override
  State<ContactDetail> createState() => _ContactDetailState();
}

class _ContactDetailState extends State<ContactDetail> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return BlocBuilder<ContactBloc, ContactState>(
      builder: (context, state) {
        return BlocBuilder<UserBloc, UserState>(
          builder: (context, stateUser) {
            return InkWell(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (builder) => ContactList(
                    userId: stateUser.user.userId,
                    token: stateUser.user.token,
                  ),
                ),
              ),
              child: Card(
                color: AppConstant.bgTextFormField,
                child: Container(
                  width: width * 1,
                  height: height * 0.1,
                  margin: const EdgeInsets.all(4),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: state.myContact.userId.isNotEmpty
                        ? [
                            Text(
                              state.myContact.fullName,
                              style: TextStyle(
                                color: AppConstant.colorText,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              state.myContact.phoneNumber,
                              style: TextStyle(
                                color: AppConstant.colorText,
                              ),
                            ),
                            Text(
                              state.myContact.address,
                              style: TextStyle(
                                color: AppConstant.colorText,
                              ),
                            ),
                          ]
                        : [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: AppConstant.colorText,
                                ),
                                Text(
                                  'เพิ่มข้อมูลติดต่อ',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppConstant.colorText,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
