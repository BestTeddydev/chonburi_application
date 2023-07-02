import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/resorts/bloc/resort_bloc.dart';
import 'package:chonburi_mobileapp/modules/resorts/screen/components/list_resort.dart';
import 'package:chonburi_mobileapp/widget/data_empty.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:chonburi_mobileapp/widget/text_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Resorts extends StatefulWidget {
  const Resorts({Key? key}) : super(key: key);

  @override
  State<Resorts> createState() => _ResortsState();
}

class _ResortsState extends State<Resorts> {
  TextEditingController searchController = TextEditingController(text: '');

  @override
  void initState() {
    fetchsRestaurants(false);
    super.initState();
  }

  void fetchsRestaurants(bool statusSearch) async {
    context.read<ResortBloc>().add(
          FetchsResortsEvent(
            search: searchController.text,
            typeBusiness: "resort",
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
    return BlocBuilder<ResortBloc, ResortState>(
      builder: (context, state) {
        print('${state.checkInDate}checkin date');
        print('${state.checkOutDate}checkout date');
        return Scaffold(
          appBar: AppBar(
            title: SizedBox(
              height: 40,
              child: TextSearch(
                funcClear: _onClear,
                funcSearch: _onSearch,
                searchController: searchController,
                labelText: 'ค้นหาบ้านพัก',
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
                                : "บ้านพักทั้งหมด",
                            fontSize: 16,
                          ),
                        ),
                        state.resorts.isEmpty
                            ? const Center(child: DataEmpty())
                            : ListResorts(
                                resorts: state.resorts,
                                checkIn: state.checkInDate,
                                checkOut: state.checkOutDate,
                              ),
                      ],
                    ),
                  ),
          ),
        );
      },
    );
  }
}
