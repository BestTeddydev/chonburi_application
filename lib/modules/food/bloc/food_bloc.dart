import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chonburi_mobileapp/modules/food/models/food_model.dart';
import 'package:chonburi_mobileapp/utils/services/food_service.dart';
import 'package:chonburi_mobileapp/utils/services/upload_file_service.dart';
import 'package:equatable/equatable.dart';

part 'food_event.dart';
part 'food_state.dart';

class FoodBloc extends Bloc<FoodEvent, FoodState> {
  FoodBloc() : super(FoodState(foods: const [])) {
    on<FetchFoodEvent>(_fetchFood);
    on<CreateFoodEvent>(_createFood);
    on<EditFoodEvent>(_editFood);
    on<DeleteFoodEvent>(_deleteFood);
    on<SelectImageFoodEvent>(_selectImageFood);
  }
  void _fetchFood(FetchFoodEvent event, Emitter<FoodState> emitter) async {
    try {
      List<FoodModel> foods = await FoodService.fetchsFood(event.businessId);
      emitter(FoodState(foods: foods));
    } catch (e) {
      emitter(FoodState(foods: state.foods, hasError: true));
    }
  }

  void _createFood(CreateFoodEvent event, Emitter<FoodState> emitter) async {
    try {
      emitter(
        FoodState(
          foods: state.foods,
          loading: true,
          imageFood: state.imageFood,
        ),
      );
      if (state.imageFood.path.isNotEmpty) {
        String imageRef = await UploadService.singleFile(state.imageFood.path);
        event.foodModel.imageRef = imageRef;
      }
      FoodModel foodModel =
          await FoodService.createFood(event.token, event.foodModel);

      emitter(
        FoodState(
          foods: List.from(state.foods)..add(foodModel),
          loaded: true,
          message: 'บันทึกข้อมูลอาหารเรียบร้อย',
          loading: false,
        ),
      );
    } catch (e) {
      emitter(
        FoodState(
          foods: state.foods,
          hasError: true,
          message: 'บันทึกข้อมูลอาหารล้มเหลว',
        ),
      );
    }
  }

  void _editFood(EditFoodEvent event, Emitter<FoodState> emitter) async {
    try {
      emitter(
        FoodState(
          foods: state.foods,
          imageFood: state.imageFood,
          loading: true,
        ),
      );
      if (state.imageFood.path.isNotEmpty) {
        String imageRef = await UploadService.singleFile(state.imageFood.path);
        event.foodModel.imageRef = imageRef;
      }
      await FoodService.editFood(event.token, event.foodModel);
      int index = List<FoodModel>.from(state.foods).indexWhere(
        (element) => element.id == event.foodModel.id,
      );
      List<FoodModel> allFood = List<FoodModel>.from(state.foods)
        ..removeWhere(
          (element) => element.id == event.foodModel.id,
        );
      allFood.insert(index, event.foodModel);
      emitter(
        FoodState(
          foods: allFood,
          imageFood: state.imageFood,
          loaded: true,
          message: 'แก้ไขข้อมูลอาหารเรียบร้อย',
          loading: false,
        ),
      );
    } catch (e) {
      emitter(
        FoodState(
          foods: state.foods,
          hasError: true,
          message: 'แก้ไขข้อมูลอาหารล้มเหลว',
          loading: false,
        ),
      );
    }
  }

  void _deleteFood(DeleteFoodEvent event, Emitter<FoodState> emitter) async {
    try {
      await FoodService.deleteFood(event.token, event.docId);
      emitter(
        FoodState(
          foods: List.from(state.foods)
            ..removeWhere(
              (element) => element.id == event.docId,
            ),
          loaded: true,
          message: 'ลบข้อมูลอาหารเรียบร้อย',
        ),
      );
    } catch (e) {
      emitter(
        FoodState(
          foods: state.foods,
          hasError: true,
          message: 'ลบข้อมูลอาหารล้มเหลว',
        ),
      );
    }
  }

  void _selectImageFood(
      SelectImageFoodEvent event, Emitter<FoodState> emitter) async {
    emitter(FoodState(foods: state.foods, imageFood: event.imageRef));
  }
}
