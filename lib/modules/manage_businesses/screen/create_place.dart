import 'dart:io';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/location/bloc/location_bloc.dart';
import 'package:chonburi_mobileapp/modules/location/screen/show_maps.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/bloc/manage_businesses_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/models/place_model.dart';
import 'package:chonburi_mobileapp/widget/dialog_camera.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:chonburi_mobileapp/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreatePlace extends StatefulWidget {
  final String userId;
  final String token;
  const CreatePlace({
    Key? key,
    required this.token,
    required this.userId,
  }) : super(key: key);

  @override
  State<CreatePlace> createState() => _CreatePlaceState();
}

class _CreatePlaceState extends State<CreatePlace> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController placeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  onSelectImagePlace(File image) {
    context.read<ManageBusinessesBloc>().add(
          SelectImagePlaceEvent(image: image),
        );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'สร้างสถานที่ท่องเที่ยว',
          style: TextStyle(color: AppConstant.colorTextHeader),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
      ),
      body: BlocListener<ManageBusinessesBloc, ManageBusinessesState>(
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
        child: BlocBuilder<ManageBusinessesBloc, ManageBusinessesState>(
          builder: (context, state) {
            return SafeArea(
              child: GestureDetector(
                onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
                behavior: HitTestBehavior.opaque,
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          width: width * 0.7,
                          margin: const EdgeInsets.all(10),
                          child: TextFormFieldCustom(
                            controller: placeController,
                            labelText: 'ชื่อสถานที่',
                            requiredText: 'กรุณากรอกชื่อสถานที่',
                          ),
                        ),
                        Container(
                          width: width * 0.7,
                          margin: const EdgeInsets.all(10),
                          child: TextFormFieldCustom(
                            controller: priceController,
                            labelText: 'ราคาค่าเข้าสถานที่',
                            requiredText: 'กรุณากรอกราคาค่าเข้าสถานที่',
                          ),
                        ),
                        Container(
                          width: width * 0.7,
                          margin: const EdgeInsets.all(10),
                          child: TextFormFieldCustom(
                            controller: descriptionController,
                            labelText: 'รายละเอียด',
                            requiredText: '',
                            maxLines: 5,
                          ),
                        ),
                        Container(
                          width: width * 0.7,
                          margin: const EdgeInsets.all(10),
                          child: TextFormFieldCustom(
                            controller: addressController,
                            labelText: 'ที่อยู่',
                            requiredText: 'กรุณากรอกที่อยู่',
                            maxLines: 3,
                          ),
                        ),
                        const Center(
                          child: ShowMap(),
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
                            physics: const BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: state.imagePlaces.length,
                            itemBuilder: (itemBuilder, imageItem) {
                              return Container(
                                margin: const EdgeInsets.all(5),
                                width: width * 0.3,
                                height: height * 0.06,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image:
                                        FileImage(state.imagePlaces[imageItem]),
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
                                              .read<ManageBusinessesBloc>()
                                              .add(
                                                RemoveImagePlaceEvent(
                                                  indexImage: imageItem,
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
                          width: 135,
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () =>
                                dialogCamera(context, onSelectImagePlace),
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
                        BlocBuilder<LocationBloc, LocationState>(
                          builder: (context, locationState) {
                            return SizedBox(
                              width: width * 1,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate() &&
                                      state.imagePlaces.isNotEmpty) {
                                    List<String> imageList = [];
                                    for (var i = 0;
                                        i < state.imagePlaces.length;
                                        i++) {
                                      String pathFile =
                                          state.imagePlaces[i].path;
                                      imageList.add(pathFile);
                                    }
                                    PlaceModel placeModel = PlaceModel(
                                      id: '',
                                      placeName: placeController.text,
                                      address: addressController.text,
                                      description: descriptionController.text,
                                      imageList: imageList,
                                      videoRef: '',
                                      ratingCount: 0,
                                      point: 0,
                                      lat: locationState.curLat,
                                      lng: locationState.curLng,
                                      ownerId: widget.userId,
                                      price: double.parse(priceController.text),
                                    );
                                    context.read<ManageBusinessesBloc>().add(
                                          CreatePlaceEvent(
                                            token: widget.token,
                                            placeModel: placeModel,
                                          ),
                                        );
                                  } else {
                                    showDialog(
                                      context: context,
                                      builder: (builder) => const DialogError(
                                        message:
                                            'กรุณากรอกข้อมูลและแนบรูปภาพอย่างน้อย 1 รูป',
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  primary: AppConstant.bgTextFormField,
                                ),
                                child: const TextCustom(
                                    title: 'สร้างสถานที่ท่องเที่ยว'),
                              ),
                            );
                          },
                        )
                      ],
                    ),
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
