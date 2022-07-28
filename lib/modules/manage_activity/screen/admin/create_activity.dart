import 'dart:io';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/bloc/manage_activity_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/models/activity_model.dart';
import 'package:chonburi_mobileapp/modules/manage_activity/screen/admin/business_list.dart';
import 'package:chonburi_mobileapp/widget/dialog_camera.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateActivity extends StatefulWidget {
  const CreateActivity({Key? key}) : super(key: key);

  @override
  State<CreateActivity> createState() => _CreateActivityState();
}

class _CreateActivityState extends State<CreateActivity> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController activityNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController unitController = TextEditingController();
  TextEditingController minPersonController = TextEditingController();
  @override
  void initState() {
    super.initState();
    context
        .read<ManageActivityBloc>()
        .add(const SetImageRefForEdit(imageRefs: []));
  }

  onSelectImage(File image) {
    // context.read<ManageActivityBloc>().add(SelectImageEvent(image: image.path));
    context.read<ManageActivityBloc>().add(SelectImageEvent(image: image));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สร้างกิจกรรม',
          style: TextStyle(color: AppConstant.colorTextHeader),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
      ),
      body: BlocListener<ManageActivityBloc, ManageActivityState>(
        listener: (context, state) {
          if (state.loading) {
            showDialog(
              context: context,
              builder: (builder) => const DialogLoading(),
            );
          }
          if (state.loaded) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (builder) => DialogSuccess(message: state.message),
            );
          }
          if (state.hasError) {
            Navigator.pop(context);
            showDialog(
              context: context,
              builder: (builder) => DialogError(message: state.message),
            );
          }
        },
        child: BlocBuilder<ManageActivityBloc, ManageActivityState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              behavior: HitTestBehavior.opaque,
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.9,
                        child: Column(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: width * 0.7,
                                    margin: const EdgeInsets.all(10),
                                    child: TextFormFieldCustom(
                                      controller: activityNameController,
                                      labelText: 'ชื่อกิจกรรม',
                                      requiredText: 'กรุณากรอกชื่อกิจกรรม',
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (builder) => BusinessList(
                                          businessNameModel: state.business,
                                        ),
                                      ),
                                    ),
                                    child: Container(
                                      width: width * 0.7,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: AppConstant.bgTextFormField,
                                        borderRadius: BorderRadius.circular(
                                          8,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 16,
                                          left: 10,
                                        ),
                                        child: Text(
                                          state.business.businessName.isNotEmpty
                                              ? state.business.businessName
                                              : 'เลือกธุรกิจ >',
                                          style: TextStyle(
                                            color: AppConstant.colorText,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.7,
                                    margin: const EdgeInsets.all(10),
                                    child: TextFormFieldCustom(
                                      controller: priceController,
                                      labelText: 'ราคา',
                                      requiredText: 'กรุณากรอกราคา',
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.7,
                                    margin: const EdgeInsets.all(10),
                                    child: TextFormFieldCustom(
                                      controller: minPersonController,
                                      labelText: 'จำนวนสมาชิกขั้นต่ำ',
                                      requiredText:
                                          'กรุณากรอกจำนวนสมาชิกขั้นต่ำ',
                                    ),
                                  ),
                                  Container(
                                    width: width * 0.7,
                                    margin: const EdgeInsets.all(10),
                                    child: TextFormFieldCustom(
                                      controller: unitController,
                                      labelText: 'หน่วย เช่น 1 ท่าน / 1ผืน ',
                                      requiredText: 'กรุณากรอกหน่วย',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: width * 1,
                              height: height * 0.18,
                              margin: const EdgeInsets.only(
                                top: 20,
                                left: 6,
                                right: 6,
                                bottom: 10,
                              ),
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: state.imageRef.length,
                                itemBuilder: (itemBuilder, imageItem) {
                                  return Container(
                                    margin: const EdgeInsets.all(5),
                                    width: width * 0.3,
                                    height: height * 0.06,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.fill,
                                        image: FileImage(
                                            state.imageRef[imageItem]),
                                      ),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Stack(
                                      alignment: AlignmentDirectional.topEnd,
                                      children: [
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              context
                                                  .read<ManageActivityBloc>()
                                                  .add(
                                                    RemoveImageEvent(
                                                      index: imageItem,
                                                    ),
                                                  );
                                            },
                                            icon: const Icon(
                                              Icons.close,
                                              size: 16,
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                            Container(
                              margin:
                                  const EdgeInsets.only(top: 10, bottom: 10),
                              width: 135,
                              height: 30,
                              child: ElevatedButton(
                                onPressed: () =>
                                    dialogCamera(context, onSelectImage),
                                style: ElevatedButton.styleFrom(
                                  primary: AppConstant.bgTextFormField,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Icon(
                                        Icons.add_a_photo_outlined,
                                        color: AppConstant.colorText,
                                        size: 15,
                                      ),
                                    ),
                                    Text(
                                      'เพิ่มรูปภาพ',
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
                      BlocBuilder<UserBloc, UserState>(
                        builder: (context, stateUser) {
                          return SizedBox(
                            width: width * 1,
                            height: 40,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  List<String> imageRef = [];
                                  if (state.imageRef.isNotEmpty) {
                                    for (File image in state.imageRef) {
                                      imageRef.add(image.path);
                                    }
                                  }
                                  ActivityModel activityModel = ActivityModel(
                                    id: '',
                                    activityName: activityNameController.text,
                                    price: double.parse(priceController.text),
                                    unit: unitController.text,
                                    imageRef: imageRef,
                                    minPerson:
                                        int.parse(minPersonController.text),
                                    businessId: state.business.businessId,
                                    accepted: false,
                                  );
                                  context.read<ManageActivityBloc>().add(
                                        CreateActivityManage(
                                          activityModel: activityModel,
                                          token: stateUser.user.token,
                                        ),
                                      );
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                primary: AppConstant.bgbutton,
                              ),
                              child: const Text(
                                'สร้างกิจกรรม',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
