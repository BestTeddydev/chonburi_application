import 'package:chonburi_mobileapp/modules/category/bloc/category_bloc.dart';
import 'package:chonburi_mobileapp/modules/category/models/category_model.dart';
import 'package:chonburi_mobileapp/modules/manage_room/bloc/manage_room_bloc.dart';
import 'package:chonburi_mobileapp/modules/manage_room/models/room_models.dart';
import 'package:chonburi_mobileapp/modules/manage_room/screen/edit_room.dart';
import 'package:chonburi_mobileapp/widget/show_image_network.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoomInCategory extends StatefulWidget {
  final String token;
  const RoomInCategory({
    Key? key,
    required this.token,
  }) : super(key: key);

  @override
  State<RoomInCategory> createState() => _RoomInCategoryState();
}

class _RoomInCategoryState extends State<RoomInCategory> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return BlocBuilder<ManageRoomBloc, ManageRoomState>(
      builder: (context, state) {
        return BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, stateCategory) {
            return ListView.builder(
              shrinkWrap: true,
              physics: const ScrollPhysics(),
              itemCount: stateCategory.categories.length,
              itemBuilder: (context, index) {
                CategoryModel categoryModel = stateCategory.categories[index];
                List<RoomModel> rooms = state.rooms
                    .where(
                      (element) => element.categoryId == categoryModel.id,
                    )
                    .toList();
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextCustom(title: categoryModel.categoryName),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const BouncingScrollPhysics(),
                        itemCount: rooms.length,
                        itemBuilder: (context, indexProduct) {
                          RoomModel room = rooms[indexProduct];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: InkWell(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (builder) => EditRoom(
                                    category: categoryModel,
                                    room: room,
                                    token: widget.token,
                                  ),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.all(10),
                                    width: width * 0.24,
                                    height: 80,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: ShowImageNetwork(
                                        pathImage: room.imageCover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.5,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        TextCustom(
                                          title: room.roomName,
                                          maxLine: 2,
                                        ),
                                        TextCustom(
                                          title: '${room.price} ฿',
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
