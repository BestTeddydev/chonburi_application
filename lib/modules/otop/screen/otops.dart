import 'package:badges/badges.dart';
import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/otop/bloc/otop_bloc.dart';
import 'package:chonburi_mobileapp/modules/otop/screen/cart_product.dart';
import 'package:chonburi_mobileapp/modules/otop/screen/components/list_introduce_prod.dart';
import 'package:chonburi_mobileapp/modules/otop/screen/components/list_otop.dart';
import 'package:chonburi_mobileapp/widget/data_empty.dart';
import 'package:chonburi_mobileapp/widget/dialog_loading.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:chonburi_mobileapp/widget/text_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Otops extends StatefulWidget {
  const Otops({Key? key}) : super(key: key);

  @override
  State<Otops> createState() => _OtopsState();
}

class _OtopsState extends State<Otops> {
  TextEditingController searchController = TextEditingController(text: '');

  @override
  void initState() {
    fetchsOtops(false);
    super.initState();
  }

  void fetchsOtops(bool statusSearch) async {
    context.read<OtopBloc>().add(
          FetchsOtopsEvent(
            search: searchController.text,
            typeBusiness: "otop",
            statusSearch: statusSearch,
          ),
        );
    context.read<OtopBloc>().add(FetchsIntroduceProductsEvent());
  }

  void _onSearch() {
    fetchsOtops(true);
  }

  void _onClear() {
    searchController.text = '';
    fetchsOtops(false);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return BlocBuilder<OtopBloc, OtopState>(
      builder: (context, state) {
        return Scaffold(
          
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: SizedBox(
              height: 40,
              child: TextSearch(
                funcClear: _onClear,
                funcSearch: _onSearch,
                searchController: searchController,
                labelText: 'ค้นหาชื่อร้าน หรือ สินค้า',
                isSearch: state.isSearched,
              ),
            ),
            backgroundColor: AppConstant.themeApp,
            iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
            toolbarHeight: 80,
            actions: state.cartProduct.isNotEmpty
                ? [
                    SizedBox(
                      width: 60,
                      child: Badge(
                        badgeContent: Text('${state.cartProduct.length}'),
                        position: BadgePosition.topEnd(top: 0, end: 3),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (builder) => const CartProducts(),
                              ),
                            );
                          },
                          icon: const Icon(Icons.shopping_basket_outlined),
                        ),
                      ),
                    ),
                  ]
                : [],
          ),
          backgroundColor: AppConstant.backgroudApp,
          body: RefreshIndicator(
            onRefresh: () => Future.sync(
              () => fetchsOtops(state.isSearched),
            ),
            child: state.loading
                ? const DialogLoading()
                : SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextCustom(
                            title: 'เมนูสินค้าแนะนำ',
                            fontSize: 16,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(10),
                          width: width * 1,
                          height: height * 0.16,
                          child: ListIntroductProducts(
                            width: width,
                            height: height,
                            introducesProds: state.introducesProds,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextCustom(
                            title: state.isSearched
                                ? "ผลลัพธ์การค้านหา"
                                : "ร้านโอท็อปทั้งหมด",
                            fontSize: 16,
                          ),
                        ),
                        state.otops.isEmpty
                            ? const Center(child: DataEmpty())
                            : ListOtops(
                                otops: state.otops,
                                buildContext: context,
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
