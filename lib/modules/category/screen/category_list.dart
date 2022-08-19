import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/category/bloc/category_bloc.dart';
import 'package:chonburi_mobileapp/modules/category/models/category_model.dart';
import 'package:chonburi_mobileapp/modules/category/screen/edit_category.dart';
import 'package:chonburi_mobileapp/widget/data_empty.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryList extends StatefulWidget {
  final String businessId, token;
  const CategoryList({
    Key? key,
    required this.businessId,
    required this.token,
  }) : super(key: key);

  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'หมวดหมู่ทั้งหมด',
          style: TextStyle(color: AppConstant.colorTextHeader),
        ),
        backgroundColor: AppConstant.themeApp,
        iconTheme: IconThemeData(color: AppConstant.colorTextHeader),
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          return state.categories.isEmpty
              ? const Center(
                  child: DataEmpty(
                    title: 'ไม่มีข้อมูลหมวดหมู่',
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemCount: state.categories.length,
                  itemBuilder: (itemBuilder, int index) {
                    CategoryModel category = state.categories[index];
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (builder) => EditCategory(
                              businessId: widget.businessId,
                              token: widget.token,
                              category: category,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: double.maxFinite,
                        margin: const EdgeInsets.all(10.0),
                        height: 60,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black45,
                              offset: Offset(0, 0.6),
                              blurRadius: 10.0,
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextCustom(title: category.categoryName),
                            ),
                            const Icon(Icons.arrow_forward_ios)
                          ],
                        ),
                      ),
                    );
                  },
                );
        },
      ),
    );
  }
}
