import 'dart:io';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/category/bloc/category_bloc.dart';
import 'package:chonburi_mobileapp/modules/category/screen/select_category.dart';
import 'package:chonburi_mobileapp/modules/manage_room/bloc/manage_room_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_room/models/room_models.dart';
import 'package:chonburi_mobileapp/widget/dialog_camera.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:chonburi_mobileapp/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateRoom extends StatefulWidget {
  final String token;
  const CreateRoom({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<CreateRoom> createState() => _CreateRoomState();
}

class _CreateRoomState extends State<CreateRoom> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController roomNameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController totalRoomController = TextEditingController();
  TextEditingController roomSizeController = TextEditingController();
  TextEditingController totalGuestController = TextEditingController();

  @override
  void initState() {
    context.read<CategoryBloc>().add(ClearSelectedCategoryEvent());
    super.initState();
  }

  onSelectImageCoverRoom(File image) {
    context.read<ManageRoomBloc>().add(SelectImageRoomEvent(imageRef: image));
  }

  onSelectImageDetailRoom(File image) {
    context
        .read<ManageRoomBloc>()
        .add(SelectImageDetailRoomEvent(imageRef: image));
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สร้างข้อมูลสินค้าโอท็อป',
          style: TextStyle(color: AppConstant.colorTextHeader),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
      ),
      body: BlocListener<ManageRoomBloc, ManageRoomState>(
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
        child: BlocBuilder<ManageRoomBloc, ManageRoomState>(
          builder: (context, state) {
            return GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              behavior: HitTestBehavior.opaque,
              child: Form(
                key: _formKey,
                child: BlocBuilder<CategoryBloc, CategoryState>(
                  builder: (context, categoryState) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          InkWell(
                            onTap: () => dialogCamera(
                              context,
                              onSelectImageCoverRoom,
                            ),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 14),
                              width: width * 1,
                              height: height * 0.2,
                              decoration: BoxDecoration(
                                color: AppConstant.bgTextFormField,
                              ),
                              child: state.imageCoverRoom.path.isNotEmpty
                                  ? Image.file(
                                      state.imageCoverRoom,
                                      fit: BoxFit.fill,
                                    )
                                  : Center(
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.camera_alt_outlined,
                                            color: AppConstant.colorText,
                                            size: 40,
                                          ),
                                          const TextCustom(
                                            title: 'รูปหน้าปกห้องพัก',
                                          ),
                                        ],
                                      ),
                                    ),
                            ),
                          ),
                          Container(
                            width: width * 0.7,
                            margin: const EdgeInsets.all(10),
                            child: TextFormFieldCustom(
                              controller: roomNameController,
                              labelText: 'ชื่อห้องพัก',
                              requiredText: 'กรุณากรอกชื่อห้องพัก',
                            ),
                          ),
                          Container(
                            width: width * 0.7,
                            margin: const EdgeInsets.all(10),
                            child: TextFormFieldCustom(
                              controller: priceController,
                              labelText: 'ราคา',
                              requiredText: 'กรุณากรอกราคา',
                              textInputType: TextInputType.number,
                            ),
                          ),
                          Container(
                            width: width * 0.7,
                            margin: const EdgeInsets.all(10),
                            child: TextFormFieldCustom(
                              controller: totalGuestController,
                              labelText: 'จำนวนผู้เข้าพัก(ห้อง):',
                              requiredText: 'กรุณากรอกจำนวนผู้เข้าพัก(ห้อง)',
                              textInputType: TextInputType.number,
                            ),
                          ),
                          Container(
                            width: width * 0.7,
                            margin: const EdgeInsets.all(10),
                            child: TextFormFieldCustom(
                              controller: totalRoomController,
                              labelText: 'จำนวนห้องทั้งหมด',
                              requiredText: 'กรุณากรอกจำนวนห้องทั้งหมด',
                              textInputType: TextInputType.number,
                            ),
                          ),
                          Container(
                            width: width * 0.7,
                            margin: const EdgeInsets.all(10),
                            child: TextFormFieldCustom(
                              controller: roomSizeController,
                              labelText: 'ขนาดห้องพัก',
                              requiredText: 'กรุณากรอกขนาดห้องพัก',
                              textInputType: TextInputType.number,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => const SelectCategory(),
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              width: width * 0.7,
                              decoration: BoxDecoration(
                                color: AppConstant.bgTextFormField,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextCustom(
                                  title: categoryState
                                          .selectedCategory.categoryName.isEmpty
                                      ? 'เลือกหมวดหมู่'
                                      : categoryState
                                          .selectedCategory.categoryName,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: width * 0.7,
                            margin: const EdgeInsets.all(10),
                            child: TextFormFieldCustom(
                              controller: descriptionController,
                              labelText: 'รายละเอียด',
                              requiredText: '',
                              maxLines: 3,
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
                              itemCount: state.imagesDetail.length,
                              itemBuilder: (itemBuilder, imageItem) {
                                return Container(
                                  margin: const EdgeInsets.all(5),
                                  width: width * 0.3,
                                  height: height * 0.06,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.fill,
                                      image: FileImage(
                                          state.imagesDetail[imageItem]),
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
                                            context.read<ManageRoomBloc>().add(
                                                  DeleteImageDetailRoomEvent(
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
                            margin: const EdgeInsets.only(top: 10, bottom: 10),
                            width: width * 0.4,
                            height: 30,
                            child: ElevatedButton(
                              onPressed: () => dialogCamera(
                                context,
                                onSelectImageDetailRoom,
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
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: AppConstant.colorText,
                                      size: 15,
                                    ),
                                  ),
                                  Text(
                                    'เพิ่มรูปภาพห้องพัก',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: AppConstant.colorText,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  categoryState
                                      .selectedCategory.id.isNotEmpty) {
                                RoomModel roomModel = RoomModel(
                                  id: '',
                                  roomName: roomNameController.text,
                                  price: double.parse(priceController.text),
                                  imageCover: '',
                                  listImageDetail: [],
                                  businessId:
                                      categoryState.selectedCategory.businessId,
                                  categoryId: categoryState.selectedCategory.id,
                                  descriptionRoom: descriptionController.text,
                                  totalRoom:
                                      int.parse(totalRoomController.text),
                                  roomSize: roomSizeController.text,
                                  totalGuest:
                                      int.parse(totalGuestController.text),
                                );
                                context.read<ManageRoomBloc>().add(
                                      CreateRoomEvent(
                                        token: widget.token,
                                        roomModel: roomModel,
                                      ),
                                    );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (builder) => const DialogError(
                                    message: 'กรุณากรอกข้อมูลให้ครบ',
                                  ),
                                );
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppConstant.themeApp,
                            ),
                            child: const TextCustom(
                              title: 'สร้างข้อมูลห้องพัก',
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
