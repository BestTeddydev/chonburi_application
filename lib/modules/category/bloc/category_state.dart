part of 'category_bloc.dart';

class CategoryState extends Equatable {
  final List<CategoryModel> categories;
  final CategoryModel selectedCategory;
  final bool loading;
  final bool loaded;
  final bool hasError;
  final String message;
  CategoryState({
    required this.categories,
    this.hasError = false,
    this.loaded = false,
    this.loading = false,
    CategoryModel? selectedCategory,
    this.message = '',
  }) : selectedCategory = selectedCategory ??
            CategoryModel(
              id: '',
              categoryName: '',
              businessId: '',
            );

  @override
  List<Object> get props =>
      [categories, loaded, loading, hasError, selectedCategory, message];
}
