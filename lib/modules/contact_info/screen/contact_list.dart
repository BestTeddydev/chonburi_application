import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/contact_info/bloc/contact_bloc.dart';
import 'package:chonburi_mobileapp/modules/contact_info/models/contact_models.dart';
import 'package:chonburi_mobileapp/modules/contact_info/screen/contact_edit.dart';
import 'package:chonburi_mobileapp/modules/contact_info/screen/create_contact.dart';
import 'package:chonburi_mobileapp/widget/dialog_comfirm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactList extends StatefulWidget {
  final String userId;
  final String token;
  const ContactList({
    Key? key,
    required this.token,
    required this.userId,
  }) : super(key: key);

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  void initState() {
    context.read<ContactBloc>().add(
          FetchContactsEvent(
            token: widget.token,
          ),
        );
    super.initState();
  }

  void onSelectContact(BuildContext context, ContactModel selectContact) {
    context.read<ContactBloc>().add(
          SelectContactEvent(contactModel: selectContact),
        );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'ข้อมูลการติดต่อ',
          style: TextStyle(color: AppConstant.colorText),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorText),
      ),
      backgroundColor: AppConstant.backgroudApp,
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          return SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Text(
                          'ข้อมูลติดต่อที่บันทึก',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppConstant.colorText,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 10, bottom: 10),
                          width: 135,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => CreateContact(
                                  userId: widget.userId,
                                  token: widget.token,
                                ),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: AppConstant.bgTextFormField,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.add,
                                  color: AppConstant.colorText,
                                  size: 15,
                                ),
                                Text(
                                  'เพิ่มข้อมูลติดต่อ',
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: AppConstant.colorText,
                                    fontWeight: FontWeight.w600,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: state.contacts.length,
                    itemBuilder: (itemBuilder, index) {
                      bool isMatch =
                          state.contacts[index].id == state.myContact.id;
                      return Card(
                        margin: const EdgeInsets.only(top: 10),
                        color: AppConstant.bgTextFormField,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: () {
                                if (!isMatch) {
                                  dialogConfirmContact(
                                    context,
                                    onSelectContact,
                                    state.contacts[index],
                                  );
                                }
                              },
                              child: Container(
                                width: width * 0.7,
                                margin: const EdgeInsets.all(10.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            state.contacts[index].fullName,
                                            style: TextStyle(
                                              color: AppConstant.colorText,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8.0,
                                            ),
                                            child: Text(
                                              isMatch ? '[ค่าเริ่มต้น]' : '',
                                              style: const TextStyle(
                                                color: Color.fromRGBO(
                                                    85, 150, 225, 1),
                                                fontSize: 10,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                          top: 6,
                                          bottom: 6,
                                        ),
                                        child: Text(
                                          state.contacts[index].phoneNumber,
                                          style: TextStyle(
                                            color: AppConstant.colorText,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ),
                                      Text(
                                        state.contacts[index].address,
                                        style: TextStyle(
                                          color: AppConstant.colorText,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ]),
                              ),
                            ),
                            SizedBox(
                              width: width * 0.2,
                              child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (builder) => EditContact(
                                        token: widget.token,
                                        userId: widget.userId,
                                        contact: state.contacts[index],
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  size: 16,
                                  color: AppConstant.colorText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
