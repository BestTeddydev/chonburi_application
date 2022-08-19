import 'package:chonburi_mobileapp/constants/app_constant.dart';
import 'package:chonburi_mobileapp/modules/category/bloc/category_bloc.dart';
import 'package:chonburi_mobileapp/modules/category/screen/category_list.dart';
import 'package:chonburi_mobileapp/modules/category/screen/create_category.dart';
import 'package:chonburi_mobileapp/widget/dialog_error.dart';
import 'package:chonburi_mobileapp/widget/text_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HeaderCreateAndEdit extends StatelessWidget {
  final String token, businessId;
  final Widget createProduct;
  final String type;
  const HeaderCreateAndEdit({
    Key? key,
    required this.businessId,
    required this.token,
    required this.createProduct,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (builder) {
                      return SizedBox(
                        height: 120,
                        child: Column(
                          children: [
                            Container(
                              width: double.maxFinite,
                              height: 55,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(0, 0.4),
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  if (state.categories.isEmpty) {
                                    showDialog(
                                      context: context,
                                      builder: (b) => const DialogError(
                                          message: 'กรุณาเพิ่มหมวดหมู่'),
                                    );
                                    return;
                                  }
                                  Navigator.pop(builder);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (builder) => createProduct,
                                      ));
                                },
                                child:  TextCustom(title: 'สร้าง$type'),
                              ),
                            ),
                            Container(
                              width: double.maxFinite,
                              height: 60,
                              decoration: const BoxDecoration(
                                color: Colors.white,
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pop(builder);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => CreateCategory(
                                          businessId: businessId, token: token),
                                    ),
                                  );
                                },
                                child:  TextCustom(
                                    title: 'สร้างหมวดหมู่$type'),
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              },
              child: Row(
                children: [
                  Icon(
                    Icons.add,
                    color: AppConstant.colorText,
                  ),
                  const TextCustom(title: 'เพิ่ม')
                ],
              ),
            ),
            TextButton(
              onPressed: () async {
                await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (builder) => CategoryList(
                        token: token,
                        businessId: businessId,
                      ),
                    ));
              },
              child: Row(
                children: [
                  Icon(
                    Icons.note_alt_outlined,
                    color: AppConstant.colorText,
                  ),
                  const TextCustom(
                    title: 'แก้ไขหมวดหมู่',
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
