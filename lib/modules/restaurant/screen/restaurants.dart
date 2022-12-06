import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/restaurant/bloc/restaurant_bloc.dart';
import 'package:chonburi_mobileapp/modules/restaurant/screen/components/list_restaurants.dart';
import 'package:chonburi_mobileapp/widget/data_empty.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:chonburi_mobileapp/widget/text_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Restaurants extends StatefulWidget {
  const Restaurants({Key? key}) : super(key: key);

  @override
  State<Restaurants> createState() => _RestaurantsState();
}

class _RestaurantsState extends State<Restaurants> {
  TextEditingController searchController = TextEditingController(text: '');

  @override
  void initState() {
    fetchsRestaurants(false);
    super.initState();
  }

  void fetchsRestaurants(bool statusSearch) async {
    context.read<RestaurantBloc>().add(
          FetchsRestaurantsEvent(
            search: searchController.text,
            typeBusiness: "restaurant",
            statusSearch: statusSearch,
          ),
        );
  }

  void _onSearch() {
    fetchsRestaurants(true);
  }

  void _onClear() {
    searchController.text = '';
    fetchsRestaurants(false);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantBloc, RestaurantState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: SizedBox(
              height: 40,
              child: TextSearch(
                funcClear: _onClear,
                funcSearch: _onSearch,
                searchController: searchController,
                labelText: 'ค้นหาชื่อร้าน หรือ เมนุอาหาร',
                isSearch: state.isSearched,
              ),
            ),
            backgroundColor: AppConstant.themeApp,
            iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
            toolbarHeight: 80,
          ),
          backgroundColor: AppConstant.backgroudApp,
          body: RefreshIndicator(
            onRefresh: () => Future.sync(
              () => fetchsRestaurants(state.isSearched),
            ),
            child: state.loading
                ? const DialogLoading()
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextCustom(
                            title: state.isSearched
                                ? "ผลลัพธ์การค้านหา"
                                : "ร้านอาหารทั้งหมด",
                            fontSize: 16,
                          ),
                        ),
                        state.restaurants.isEmpty
                            ? const Center(child: DataEmpty())
                            : ListRestaurant(restaurants: state.restaurants),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
