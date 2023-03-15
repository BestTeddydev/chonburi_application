import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/contact_admin/bloc/contact_admin_bloc.dart';
import 'package:chonburi_mobileapp/modules/contact_admin/models/contact_admin_model.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ContactAdminList extends StatefulWidget {
  const ContactAdminList({Key? key}) : super(key: key);

  @override
  State<ContactAdminList> createState() => _ContactAdminListState();
}

class _ContactAdminListState extends State<ContactAdminList> {
  @override
  void initState() {
    super.initState();
    fetchContactAdmin();
  }

  fetchContactAdmin() {
    context.read<ContactAdminBloc>().add(FetchsContactAdminEvent());
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const TextCustom(title: "เลือกผู้ดูแลแพ็คเกจ"),
        iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
        backgroundColor: AppConstant.themeApp,
      ),
      backgroundColor: AppConstant.backgroudApp,
      body: BlocBuilder<ContactAdminBloc, ContactAdminState>(
        builder: (context, state) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: state.contacts.length,
            itemBuilder: (context, index) {
              ContactAdminModel contact = state.contacts[index];
              bool isMatch = contact.id == state.selectContact.id;
              return Card(
                color: isMatch ? AppConstant.bgTextFormField : Colors.white,
                child: InkWell(
                  onTap: () {
                    if (!isMatch) {
                      context.read<ContactAdminBloc>().add(
                            SelectContactAdminEvent(contactAdminModel: contact),
                          );
                    }
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: width * 0.3,
                        child: ShowImageNetwork(pathImage: contact.profileRef),
                      ),
                      Container(
                        width: width * 0.6,
                        height: height * 0.1,
                        margin: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextCustom(title: contact.fullName),
                            TextCustom(title: contact.phoneNumber),
                            TextCustom(title: contact.typePayment),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
