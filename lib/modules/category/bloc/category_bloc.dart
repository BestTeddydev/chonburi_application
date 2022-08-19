import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:chonburi_mobileapp/modules/category/models/category_model.dart';
import 'package:chonburi_mobileapp/utils/services/category_service.dart';
import 'package:equatable/equatable.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryState(categories: const [])) {
    on<FetchCategoryEvent>(_fetchCategory);
    on<CreateCategoryEvent>(_createCategory);
    on<EditCategoryEvent>(_editCategory);
    on<DeleteCategoryEvent>(_deleteCategory);
    on<SelectCategoryEvent>(_selectCategory);
  }
  void _fetchCategory(
      FetchCategoryEvent event, Emitter<CategoryState> emitter) async {
    try {
      List<CategoryModel> categories =
          await CategoryService.fetchCategoryBusiness(event.businessId);
      emitter(
        CategoryState(
          categories: categories,
        ),
      );
    } catch (e) {
      emitter(
        CategoryState(categories: state.categories, hasError: true),
      );
    }
  }

  void _createCategory(
      CreateCategoryEvent event, Emitter<CategoryState> emitter) async {
    try {
      CategoryModel categoryModel =
          await CategoryService.createCategory(event.token, event.category);

      emitter(
        CategoryState(
            categories: List.from(state.categories)..add(categoryModel),
            loaded: true,
            message: 'บันทึกหมวดหมู่เรียบร้อย'),
      );
    } catch (e) {
      emitter(
        CategoryState(
            categories: state.categories,
            hasError: true,
            message: 'บันทึกหมวดหมู่ล้มเหลว'),
      );
    }
  }

  void _editCategory(
      EditCategoryEvent event, Emitter<CategoryState> emitter) async {
    try {
      await CategoryService.editCategory(event.token, event.category);
      int index = List<CategoryModel>.from(state.categories).indexWhere(
        (element) => element.id == event.category.id,
      );
      List<CategoryModel> allCategory =
          List<CategoryModel>.from(state.categories)
            ..removeWhere(
              (element) => element.id == event.category.id,
            );
      allCategory.insert(index, event.category);
      emitter(
        CategoryState(
            categories: allCategory,
            loaded: true,
            message: 'แก้ไขหมวดหมู่เรียบร้อย'),
      );
    } catch (e) {
      emitter(
        CategoryState(
            categories: state.categories,
            hasError: true,
            message: 'แก้ไขหมวดหมู่ล้มเหลว'),
      );
    }
  }

  void _deleteCategory(
      DeleteCategoryEvent event, Emitter<CategoryState> emitter) async {
    try {
      await CategoryService.deleteCategory(event.token, event.category.id);
      List<CategoryModel> allCategory =
          List<CategoryModel>.from(state.categories)
            ..removeWhere(
              (element) => element.id == event.category.id,
            );
      emitter(
        CategoryState(
          categories: allCategory,
          loaded: true,
          message: 'ลบหมวดหมู่เรียบร้อย',
        ),
      );
    } catch (e) {
      log(e.toString());
      emitter(
        CategoryState(
            categories: state.categories,
            hasError: true,
            message: 'ลบหมวดหมู่ล้มเหลว'),
      );
    }
  }

  void _selectCategory(
      SelectCategoryEvent event, Emitter<CategoryState> emitter) {
    emitter(
      CategoryState(
        categories: state.categories,
        selectedCategory: event.category,
      ),
    );
  }
}
