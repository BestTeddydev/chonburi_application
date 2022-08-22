import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chonburi_mobileapp/modules/product/models/product_models.dart';
import 'package:chonburi_mobileapp/utils/services/product_service.dart';
import 'package:chonburi_mobileapp/utils/services/upload_file_service.dart';
import 'package:equatable/equatable.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductState(products: const [])) {
    on<FetchsProductEvent>(_fetchProduct);
    on<CreateProductEvent>(_createProduct);
    on<UpdateProductEvent>(_editProduct);
    on<DeleteProductEvent>(_deleteProduct);
    on<SelectImageProductEvent>(_selectimageProduct);
    on<UpdateStatusEvent>(_updateStatus);
  }
  void _fetchProduct(
      FetchsProductEvent event, Emitter<ProductState> emitter) async {
    try {
      List<ProductModel> products =
          await ProductService.fetchsProduct(event.businessId);
      emitter(ProductState(products: products));
    } catch (e) {
      emitter(ProductState(products: state.products, hasError: true));
    }
  }

  void _createProduct(
      CreateProductEvent event, Emitter<ProductState> emitter) async {
    try {
      emitter(
        ProductState(
          products: state.products,
          loading: true,
          imageProduct: state.imageProduct,
        ),
      );
      if (state.imageProduct.path.isNotEmpty) {
        String imageRef =
            await UploadService.singleFile(state.imageProduct.path);
        event.productModel.imageRef = imageRef;
      }
      ProductModel product =
          await ProductService.createProduct(event.token, event.productModel);

      emitter(
        ProductState(
          products: List.from(state.products)..add(product),
          loaded: true,
          message: 'บันทึกข้อมูลสินค้าเรียบร้อย',
          loading: false,
        ),
      );
    } catch (e) {
      emitter(
        ProductState(
          products: state.products,
          hasError: true,
          message: 'บันทึกข้อมูลสินค้าล้มเหลว',
        ),
      );
    }
  }

  void _editProduct(
      UpdateProductEvent event, Emitter<ProductState> emitter) async {
    try {
      emitter(
        ProductState(
          products: state.products,
          imageProduct: state.imageProduct,
          loading: true,
        ),
      );
      if (state.imageProduct.path.isNotEmpty) {
        String imageRef =
            await UploadService.singleFile(state.imageProduct.path);
        event.productModel.imageRef = imageRef;
      }
      await ProductService.editProduct(event.token, event.productModel);
      int index = List<ProductModel>.from(state.products).indexWhere(
        (element) => element.id == event.productModel.id,
      );
      List<ProductModel> allProducts = List<ProductModel>.from(state.products)
        ..removeWhere(
          (element) => element.id == event.productModel.id,
        );
      allProducts.insert(index, event.productModel);
      emitter(
        ProductState(
          products: allProducts,
          imageProduct: state.imageProduct,
          loaded: true,
          message: 'แก้ไขข้อมูลสินค้าเรียบร้อย',
          loading: false,
        ),
      );
    } catch (e) {
      emitter(
        ProductState(
          products: state.products,
          hasError: true,
          message: 'แก้ไขข้อมูลสินค้าล้มเหลว',
          loading: false,
        ),
      );
    }
  }

  void _updateStatus(UpdateStatusEvent event, Emitter<ProductState> emitter) async{
    await ProductService.editProduct(event.token, event.productModel);
      int index = List<ProductModel>.from(state.products).indexWhere(
        (element) => element.id == event.productModel.id,
      );
      List<ProductModel> allProducts = List<ProductModel>.from(state.products)
        ..removeWhere(
          (element) => element.id == event.productModel.id,
        );
      allProducts.insert(index, event.productModel);
      emitter(
        ProductState(
          products: allProducts,
        ),
      );
  }

  void _deleteProduct(
      DeleteProductEvent event, Emitter<ProductState> emitter) async {
    try {
      await ProductService.deleteProduct(event.token, event.productModel.id);
      emitter(
        ProductState(
          products: List.from(state.products)
            ..removeWhere(
              (element) => element.id == event.productModel.id,
            ),
          loaded: true,
          message: 'ลบข้อมูลสินค้าเรียบร้อย',
        ),
      );
    } catch (e) {
      emitter(
        ProductState(
          products: state.products,
          hasError: true,
          message: 'ลบข้อมูลสินค้าล้มเหลว',
        ),
      );
    }
  }

  void _selectimageProduct(
    SelectImageProductEvent event,
    Emitter<ProductState> emitter,
  ) async {
    emitter(
      ProductState(
        products: state.products,
        imageProduct: event.imageRef,
      ),
    );
  }
}
