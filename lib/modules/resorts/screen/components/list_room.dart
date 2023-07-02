import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/auth/bloc/user_bloc.dart';
import 'package:chonburi_mobileapp/modules/auth/models/user_model.dart';
import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/modules/manage_room/models/room_left_models.dart';
import 'package:chonburi_mobileapp/modules/manage_room/models/room_models.dart';
import 'package:chonburi_mobileapp/modules/resorts/screen/booking_room.dart';
import 'package:chonburi_mobileapp/widget/dialog_comfirm.dart';
import 'package:chonburi_mobileapp/widget/image_blank.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ListRooms extends StatelessWidget {
  final List<RoomModel> rooms;
  final List<RoomLeftModel> roomsLeft;
  final BusinessModel resort;
  const ListRooms({
    Key? key,
    required this.rooms,
    required this.roomsLeft,
    required this.resort,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    int fnRoomLeft(String roomId, List<RoomLeftModel> roomsLet) {
      RoomLeftModel room = roomsLet.firstWhere(
          (element) => element.id == roomId,
          orElse: () => RoomLeftModel(id: roomId, roomLeft: 0));
      return room.roomLeft;
    }

    return ListView.builder(
        itemCount: rooms.length,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext buildContext, int index) {
          return Card(
            margin: const EdgeInsets.all(5.0),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    buildSwiperImage(width, height, rooms[index]),
                    Container(
                      margin: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextCustom(title: "${rooms[index].price} ฿"),
                      ),
                    ),
                  ],
                ),
                buildShowField(
                  ' ${rooms[index].roomName} (${rooms[index].roomSize} ตรม.)',
                  Icons.meeting_room,
                ),
                buildShowField(
                  'เข้าพักได้สูงสุด : ผู้ใหญ่ ${rooms[index].totalGuest} คน',
                  Icons.person,
                ),
                buildShowField(
                  'เหลือ : ${fnRoomLeft(rooms[index].id, roomsLeft)} ห้อง',
                  Icons.person,
                ),
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    return buildFooter(rooms, index, context, state.user);
                  },
                )
              ],
            ),
          );
        });
  }

  Row buildFooter(
    List<RoomModel> rooms,
    int index,
    BuildContext context,
    UserModel user,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 6),
              child: ElevatedButton(
                onPressed: () {
                  if (user.token.isEmpty) {
                    dialogWarningLogin(context);
                    return;
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) {
                        return BookingRoom(
                          room: rooms[index],
                          resort: resort,
                          user: user,
                        );
                      },
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: AppConstant.themeApp,
                ),
                child: const TextCustom(title: "ดูรายละเอียดและจองห้องพัก"),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Row buildShowField(String text, IconData icon) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Icon(icon),
        ),
        TextCustom(title: text),
      ],
    );
  }

  SizedBox buildSwiperImage(double width, double height, RoomModel room) {
    return SizedBox(
      width: width * 1,
      height: height * 0.22,
      child: room.imageCover.isEmpty
          ? const ImageBlank()
          : ShowImageNetwork(
              pathImage: room.imageCover,
            ),
    );
  }
}
