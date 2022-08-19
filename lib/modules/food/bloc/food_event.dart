
part of 'food_bloc.dart';

abstract class FoodEvent extends Equatable {
  const FoodEvent();

  @override
  List<Object> get props => [];
}

class FetchFoodEvent extends FoodEvent {
  final String businessId;
  const FetchFoodEvent({
    required this.businessId,
  });
}

class CreateFoodEvent extends FoodEvent {
  final String token;
  final FoodModel foodModel;
  const CreateFoodEvent({
    required this.token,
    required this.foodModel,
  });
}

class EditFoodEvent extends FoodEvent {
  final String token;
  final FoodModel foodModel;
  const EditFoodEvent({
    required this.token,
    required this.foodModel,
  });
}

class DeleteFoodEvent extends FoodEvent {
  final String token;
  final String docId;
  const DeleteFoodEvent({
    required this.token,
    required this.docId,
  });
}

class SelectImageFoodEvent extends FoodEvent {
  final File imageRef;
  const SelectImageFoodEvent({
    required this.imageRef,
  });
}
