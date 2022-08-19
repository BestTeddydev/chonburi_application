// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/home/screen/home_seller.dart';
import 'package:chonburi_mobileapp/modules/location/bloc/location_bloc.dart';
import 'package:chonburi_mobileapp/modules/location/screen/show_maps.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/bloc/manage_businesses_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/models/place_model.dart';
import 'package:chonburi_mobileapp/utils/helper/transform_image.dart';
import 'package:chonburi_mobileapp/widget/dialog_camera.dart';
import 'package:chonburi_mobileapp/widget/dialog_comfirm.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/dialog_success.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:chonburi_mobileapp/widget/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditPlace extends StatefulWidget {
  final String userId;
  final String token;
  final PlaceModel place;
  const EditPlace({
    Key? key,
    required this.token,
    required this.userId,
    required this.place,
  }) : super(key: key);

  @override
  State<EditPlace> createState() => _EditPlaceState();
}

class _EditPlaceState extends State<EditPlace> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController placeController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  // TextEditingController priceController = TextEditingController();
  onSelectImagePlace(File image) {
    context.read<ManageBusinessesBloc>().add(
          SelectImagePlaceEvent(image: image),
        );
  }

  @override
  void initState() {
    super.initState();
    placeController.text = widget.place.placeName;
    addressController.text = widget.place.address;
    descriptionController.text = widget.place.description;
    // priceController.text = widget.place.price.toString();
    convertImageToFile();
  }

  convertImageToFile() async {
    try {
      List<File> imagesFiles = [];
      List<int> numbers = [];
      for (int i = 0; i < widget.place.imageList.length; i++) {
        String filePath = widget.place.imageList[i];
        File file = await TransfromImage.convertUrlToFile(filePath);
        imagesFiles.add(file);
        numbers.add(i);
      }
      context.read<ManageBusinessesBloc>().add(
            ConvertImageUrlEvent(images: imagesFiles),
          );
    } catch (e) {
      log(e.toString());
    }
  }

  onDeletePlace(BuildContext context) {
    Navigator.pop(context);
    context.read<ManageBusinessesBloc>().add(
          DeletePlaceEvent(token: widget.token, docId: widget.place.id),
        );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (builder) => const HomeSellerService(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'แก้ไขสถานที่ท่องเที่ยว',
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
            PlaceModel place = state.place;
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
                        // Container(
                        //   width: width * 0.7,
                        //   margin: const EdgeInsets.all(10),
                        //   child: TextFormFieldCustom(
                        //     controller: priceController,
                        //     labelText: 'ราคาค่าเข้าสถานที่',
                        //     requiredText: 'กรุณากรอกราคาค่าเข้าสถานที่',
                        //   ),
                        // ),
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
                        Center(
                          child: ShowMap(
                            lat: widget.place.lat,
                            lng: widget.place.lng,
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
                        Container(
                          width: width * 0.6,
                          margin: const EdgeInsets.all(10),
                          child: ElevatedButton(
                            onPressed: () {
                              dialogConfirm(
                                context,
                                onDeletePlace,
                                'คุณแน่ใจแล้วใช่หรือไม่ที่จะลบสถานที่แห่งนี้',
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              primary: AppConstant.bgCancelActivity,
                            ),
                            child: const TextCustom(
                              title: 'ลบสถานที่',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                              fontColor: Colors.white,
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
                                      id: place.id,
                                      placeName: placeController.text,
                                      address: addressController.text,
                                      description: descriptionController.text,
                                      imageList: imageList,
                                      videoRef: place.videoRef,
                                      ratingCount: place.ratingCount,
                                      point: place.point,
                                      lat: locationState.curLat,
                                      lng: locationState.curLng,
                                      ownerId: place.ownerId,
                                      price: 0,
                                      // price: double.parse(priceController.text),
                                    );
                                    context.read<ManageBusinessesBloc>().add(
                                          UpdatePlaceEvent(
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
                                  title: 'แก้ไขสถานที่ท่องเที่ยว',
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                ),
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
