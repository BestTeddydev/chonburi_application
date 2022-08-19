part of 'category_bloc.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();

  @override
  List<Object> get props => [];
}

class FetchCategoryEvent extends CategoryEvent {
  final String businessId;
  const FetchCategoryEvent({
    required this.businessId,
  });
}

class CreateCategoryEvent extends CategoryEvent {
  final String token;
  final CategoryModel category;
  const CreateCategoryEvent({
    required this.token,
    required this.category,
  });
  
}

class EditCategoryEvent extends CategoryEvent {
  final String token;
  final CategoryModel category;
  const EditCategoryEvent({
    required this.token,
    required this.category,
  });
}

class DeleteCategoryEvent extends CategoryEvent {
  final String token;
  final CategoryModel category;
  const DeleteCategoryEvent({
    required this.token,
    required this.category,
  });
}

class SelectCategoryEvent extends CategoryEvent {
  final CategoryModel category;
  const SelectCategoryEvent({
    required this.category,
  });
}
