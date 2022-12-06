import 'dart:io';

import 'package:chonburi_mobileapp/modules/businesses/models/business_models.dart';
import 'package:chonburi_mobileapp/modules/category/models/category_model.dart';
import 'package:chonburi_mobileapp/modules/otop/models/product_cart_model.dart';
import 'package:chonburi_mobileapp/modules/product/models/product_models.dart';
import 'package:chonburi_mobileapp/utils/services/business_service.dart';
import 'package:chonburi_mobileapp/utils/services/category_service.dart';
import 'package:chonburi_mobileapp/utils/services/product_service.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'otop_event.dart';
part 'otop_state.dart';

class OtopBloc extends HydratedBloc<OtopEvent, OtopState> {
  OtopBloc() : super(OtopState()) {
    on<FetchsOtopsEvent>(_fetchsotops);
    on<FetchsCategoryOtopEvent>(_fetchsCategories);
    on<FetchsProductsEvent>(_fetchsProducts);
    on<AddProductToCartEvent>(_addProductToCart);
    on<ClearCartProductEvent>(_clearCartProduct);
    on<FetchOtopEvent>(_fetchOtop);
    on<UpdateProductInCartEvent>(_updateProductInCart);
    on<FetchsIntroduceProductsEvent>(_fetchsIntroducesProducts);
    on<SelectPaymentImageEvent>(_selectImagePayment);
    on<ClearCartProductOfBusinessEvent>(_clearProductBusiness);
  }
  void _fetchsotops(
    FetchsOtopsEvent event,
    Emitter<OtopState> emitter,
  ) async {
    try {
      emitter(OtopState(
        otops: state.otops,
        loading: true,
        cartProduct: state.cartProduct,
      ));
      List<BusinessModel> otops =
          await BusinessService.fetchBusiness(event.search, event.typeBusiness);
      emitter(
        OtopState(
          otops: otops,
          loading: false,
          loaded: true,
          isSearched: event.statusSearch,
          cartProduct: state.cartProduct,
          introducesProds: state.introducesProds,
        ),
      );
    } catch (e) {
      emitter(
        OtopState(
          otops: state.otops,
          hasError: true,
          message: 'เกิดเหตุขัดข้อง ขออภัยในความไม่สะดวก',
          cartProduct: state.cartProduct,
          introducesProds: state.introducesProds,
        ),
      );
    }
  }

  void _fetchOtop(
    FetchOtopEvent event,
    Emitter<OtopState> emitter,
  ) async {
    BusinessModel otop =
        await BusinessService.fetchBusinessById(event.businessId);
    emitter(
      OtopState(
        otops: state.otops,
        categories: state.categories,
        products: state.products,
        cartProduct: state.cartProduct,
        otop: otop,
        introducesProds: state.introducesProds,
      ),
    );
  }

  void _fetchsCategories(
    FetchsCategoryOtopEvent event,
    Emitter<OtopState> emitter,
  ) async {
    try {
      List<CategoryModel> categories =
          await CategoryService.fetchCategoryBusiness(event.businessId);
      emitter(
        OtopState(
          otops: state.otops,
          categories: categories,
          products: state.products,
          cartProduct: state.cartProduct,
          otop: state.otop,
          introducesProds: state.introducesProds,
        ),
      );
    } catch (e) {
      emitter(
        OtopState(
          otops: state.otops,
          hasError: true,
          message: 'เกิดเหตุขัดข้อง ขออภัยในความไม่สะดวก',
          cartProduct: state.cartProduct,
          otop: state.otop,
          introducesProds: state.introducesProds,
        ),
      );
    }
  }

  void _fetchsProducts(
    FetchsProductsEvent event,
    Emitter<OtopState> emitter,
  ) async {
    try {
      List<ProductModel> products =
          await ProductService.fetchsProduct(event.businessId);
      emitter(
        OtopState(
          otops: state.otops,
          categories: state.categories,
          products: products,
          cartProduct: state.cartProduct,
          otop: state.otop,
          introducesProds: state.introducesProds,
        ),
      );
    } catch (e) {
      emitter(
        OtopState(
          otops: state.otops,
          hasError: true,
          message: 'เกิดเหตุขัดข้อง ขออภัยในความไม่สะดวก',
          cartProduct: state.cartProduct,
          otop: state.otop,
          introducesProds: state.introducesProds,
        ),
      );
    }
  }

  void _fetchsIntroducesProducts(
    FetchsIntroduceProductsEvent event,
    Emitter<OtopState> emitter,
  ) async {
    try {
      List<ProductModel> introduces =
          await ProductService.fetchsIntroductsProduct();
      emitter(
        OtopState(
          otops: state.otops,
          categories: state.categories,
          products: state.products,
          introducesProds: introduces,
          cartProduct: state.cartProduct,
          otop: state.otop,
        ),
      );
    } catch (e) {
      emitter(
        OtopState(
          otops: state.otops,
          hasError: true,
          message: 'เกิดเหตุขัดข้อง ขออภัยในความไม่สะดวก',
          cartProduct: state.cartProduct,
          otop: state.otop,
          introducesProds: state.introducesProds,
        ),
      );
    }
  }

  void _addProductToCart(
    AddProductToCartEvent event,
    Emitter<OtopState> emitter,
  ) {
    emitter(
      OtopState(
        otops: state.otops,
        categories: state.categories,
        products: state.products,
        introducesProds: state.introducesProds,
        cartProduct: List.from(state.cartProduct)
          ..add(
            event.productCart,
          ),
        otop: state.otop,
      ),
    );
  }

  void _updateProductInCart(
    UpdateProductInCartEvent event,
    Emitter<OtopState> emitter,
  ) {
    int index = List.from(state.cartProduct).indexWhere(
      (element) => element.productId == event.productCart.productId,
    );
    List<ProductCartModel> allProductCarts = List.from(state.cartProduct)
      ..removeWhere(
        (element) => element.productId == event.productCart.productId,
      );
    if (event.productCart.amount > 1) {
      allProductCarts.insert(index, event.productCart);
    }
    emitter(
      OtopState(
        otops: state.otops,
        categories: state.categories,
        products: state.products,
        introducesProds: state.introducesProds,
        cartProduct: allProductCarts,
        otop: state.otop,
      ),
    );
  }

  void _clearProductBusiness(
    ClearCartProductOfBusinessEvent event,
    Emitter<OtopState> emitter,
  ) {
    List<ProductCartModel> allProductCarts = List.from(state.cartProduct)
      ..removeWhere(
        (element) => element.businessId == event.businessId,
      );
    emitter(
      OtopState(
        otops: state.otops,
        categories: state.categories,
        products: state.products,
        introducesProds: state.introducesProds,
        cartProduct: allProductCarts,
        otop: state.otop,
      ),
    );
  }

  void _clearCartProduct(
    ClearCartProductEvent event,
    Emitter<OtopState> emitter,
  ) {
    emitter(
      OtopState(
        otops: state.otops,
        categories: state.categories,
        products: state.products,
        introducesProds: state.introducesProds,
        cartProduct: const [],
        otop: state.otop,
      ),
    );
  }

  void _selectImagePayment(
    SelectPaymentImageEvent event,
    Emitter<OtopState> emitter,
  ) {
    emitter(
      OtopState(
        otops: state.otops,
        categories: state.categories,
        products: state.products,
        introducesProds: state.introducesProds,
        cartProduct: state.cartProduct,
        otop: state.otop,
        imagePayment: event.image,
      ),
    );
  }

  @override
  OtopState? fromJson(Map<String, dynamic> json) {
    return OtopState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(OtopState state) {
    return state.toMap();
  }
}
