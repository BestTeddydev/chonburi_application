part of 'restaurant_bloc.dart';

abstract class RestaurantEvent extends Equatable {
  const RestaurantEvent();

  @override
  List<Object> get props => [];
}

class FetchsRestaurantsEvent extends RestaurantEvent {
  final String search;
  final String typeBusiness;
  final bool statusSearch;
  const FetchsRestaurantsEvent({
    required this.search,
    required this.typeBusiness,
    required this.statusSearch,
  });
}

class FetchsCategoryEvent extends RestaurantEvent {
  final String businessId;
  const FetchsCategoryEvent({
    required this.businessId,
  });
}

class FetchsFoodsEvent extends RestaurantEvent {
  final String businessId;
  const FetchsFoodsEvent({
    required this.businessId,
  });
}
