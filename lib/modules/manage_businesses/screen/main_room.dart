import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/category/bloc/category_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_businesses/screen/components/header_create_edit.dart';
import 'package:chonburi_mobileapp/modules/manage_room/bloc/manage_room_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_room/screen/create_room.dart';
import 'package:chonburi_mobileapp/modules/manage_room/screen/room_in_category.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class MainRoom extends StatefulWidget {
  final String token, businessId;
  const MainRoom({Key? key,required this.businessId,required this.token,}) : super(key: key);

  @override
  State<MainRoom> createState() => _MainRoomState();
}

class _MainRoomState extends State<MainRoom> {
   @override
  void initState() {
    context
        .read<CategoryBloc>()
        .add(FetchCategoryEvent(businessId: widget.businessId));
    context.read<ManageRoomBloc>().add(FetchsRoomEvent(businessId: widget.businessId));
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'รายการห้องพัก',
          style: TextStyle(color: AppConstant.colorTextHeader),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
      ),
      backgroundColor: AppConstant.backgroudApp,
      body: ListView(
        children: [
          HeaderCreateAndEdit(
            businessId: widget.businessId,
            token: widget.token,
            createProduct: CreateRoom(
              token: widget.token,
            ),
            type: 'ห้องพัก',
          ),
          RoomInCategory(
            token: widget.token,
          ),
        ],
      ),
    );
  }
}