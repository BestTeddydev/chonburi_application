part of 'restaurant_bloc.dart';

class RestaurantState extends Equatable {
  final List<BusinessModel> restaurants;
  final List<CategoryModel> categories;
  final List<FoodModel> foods;
  final bool loading;
  final bool loaded;
  final bool hasError;
  final String message;
  final bool isSearched;
  const RestaurantState({
    required this.restaurants,
    this.categories = const [],
    this.foods = const [],
    this.hasError = false,
    this.loaded = false,
    this.loading = false,
    this.message = '',
    this.isSearched = false,
  });

  @override
  List<Object> get props => [
        restaurants,
        categories,
        foods,
        isSearched,
        loaded,
        loading,
        hasError,
        message,
      ];
}
