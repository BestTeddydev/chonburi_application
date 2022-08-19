part of 'food_bloc.dart';

class FoodState extends Equatable {
  final List<FoodModel> foods;
  final File imageFood;
  final bool loading;
  final bool loaded;
  final bool hasError;
  final String message;
  FoodState({
    required this.foods,
    this.hasError = false,
    this.loaded = false,
    this.loading = false,
    this.message = '',
    File? imageFood,
  }) : imageFood = imageFood ?? File('');

  @override
  List<Object> get props =>
      [foods, loaded, loading, message, hasError, imageFood];
}
