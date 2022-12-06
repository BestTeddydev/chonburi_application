import 'package:bloc/bloc.dart';
import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/modules/category/models/category_model.dart';
import 'package:chonburi_mobileapp/modules/food/models/food_model.dart';
import 'package:chonburi_mobileapp/utils/services/business_service.dart';
import 'package:chonburi_mobileapp/utils/services/category_service.dart';
import 'package:chonburi_mobileapp/utils/services/food_service.dart';
import 'package:equatable/equatable.dart';

part 'restaurant_event.dart';
part 'restaurant_state.dart';

class RestaurantBloc extends Bloc<RestaurantEvent, RestaurantState> {
  RestaurantBloc() : super(const RestaurantState(restaurants: [])) {
    on<FetchsRestaurantsEvent>(_fetchsRestaurants);
    on<FetchsCategoryEvent>(_fetchsCategories);
    on<FetchsFoodsEvent>(_fetchsFoods);
  }
  void _fetchsRestaurants(
    FetchsRestaurantsEvent event,
    Emitter<RestaurantState> emitter,
  ) async {
    try {
      emitter(RestaurantState(restaurants: state.restaurants, loading: true));
      List<BusinessModel> restaurants =
          await BusinessService.fetchBusiness(event.search, event.typeBusiness);
      emitter(
        RestaurantState(
          restaurants: restaurants,
          loading: false,
          loaded: true,
          isSearched: event.statusSearch,
        ),
      );
    } catch (e) {
      emitter(
        RestaurantState(
          restaurants: state.restaurants,
          hasError: true,
          message: 'เกิดเหตุขัดข้อง ขออภัยในความไม่สะดวก',
        ),
      );
    }
  }

  void _fetchsCategories(
    FetchsCategoryEvent event,
    Emitter<RestaurantState> emitter,
  ) async {
    try {
      List<CategoryModel> categories =
          await CategoryService.fetchCategoryBusiness(event.businessId);
      emitter(
        RestaurantState(
            restaurants: state.restaurants,
            categories: categories,
            foods: state.foods),
      );
    } catch (e) {
      emitter(
        RestaurantState(
          restaurants: state.restaurants,
          hasError: true,
          message: 'เกิดเหตุขัดข้อง ขออภัยในความไม่สะดวก',
        ),
      );
    }
  }

  void _fetchsFoods(
    FetchsFoodsEvent event,
    Emitter<RestaurantState> emitter,
  ) async {
    try {
      List<FoodModel> foods = await FoodService.fetchsFood(event.businessId);
      emitter(
        RestaurantState(
            restaurants: state.restaurants,
            categories: state.categories,
            foods: foods),
      );
    } catch (e) {
      emitter(
        RestaurantState(
          restaurants: state.restaurants,
          hasError: true,
          message: 'เกิดเหตุขัดข้อง ขออภัยในความไม่สะดวก',
        ),
      );
    }
  }
}
