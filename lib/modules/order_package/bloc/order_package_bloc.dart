import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chonburi_mobileapp/modules/order_package/models/order_package.dart';
import 'package:chonburi_mobileapp/utils/services/order_package_service.dart';
import 'package:chonburi_mobileapp/utils/services/upload_file_service.dart';
import 'package:equatable/equatable.dart';

part 'order_package_event.dart';
part 'order_package_state.dart';

class OrderPackageBloc extends Bloc<OrderPackageEvent, OrderPackageState> {
  OrderPackageBloc() : super(OrderPackageState(ordersPackages: const [])) {
    on<CreateOrderPackageEvent>(_createOrderPackage);
    on<FetchsOrderPackageEvent>(_fetchsOrderPackages);
    on<UpdateOrderPackageEvent>(_updateOrderPackageStatus);
    on<SelectImageReceiptEvent>(_selectImageReceipt);
    on<BillOrderPackageEvent>(_billOrderPackage);
  }

  void _createOrderPackage(
      CreateOrderPackageEvent event, Emitter<OrderPackageState> emitter) async {
    try {
      emitter(OrderPackageState(
          ordersPackages: state.ordersPackages, loading: true));
      await OrderPackageService.createOrderPackage(
          event.orderPackageModel, event.token);
      emitter(
        OrderPackageState(
          ordersPackages: state.ordersPackages,
          loaded: true,
          loading: false,
          message:
              'สั่งซื้อเรียบร้อย รอแอดมินอนุมัติไม่เกิน 1 วัน ขออภัยในความไม่สะดวก',
        ),
      );
    } catch (e) {
      emitter(
        OrderPackageState(
          ordersPackages: state.ordersPackages,
          hasError: true,
          loading: false,
          message: 'สั่งซื้อล้มเหลว กรุณาลองใหม่อีกครั้ง ',
        ),
      );
    }
  }

  void _fetchsOrderPackages(
      FetchsOrderPackageEvent event, Emitter<OrderPackageState> emitter) async {
    try {
      emitter(OrderPackageState(
        ordersPackages: state.ordersPackages,
        loading: true,
      ));
      List<OrderPackageModel> orders =
          await OrderPackageService.fetchOrderPackages(
        event.token,
        event.id,
        event.businessId,
      );
      emitter(OrderPackageState(
        ordersPackages: orders,
        loaded: true,
        loading: false,
      ));
    } catch (e) {
      log(e.toString());
      emitter(OrderPackageState(
        ordersPackages: state.ordersPackages,
        hasError: true,
      ));
    }
  }

  void _updateOrderPackageStatus(
    UpdateOrderPackageEvent event,
    Emitter<OrderPackageState> emitter,
  ) async {
    try {
      await OrderPackageService.approveOrderPackage(
          event.token, event.docId, event.status);
      emitter(
        OrderPackageState(
          ordersPackages: state.ordersPackages,
          loaded: true,
        ),
      );
    } catch (e) {
      emitter(
        OrderPackageState(
          ordersPackages: state.ordersPackages,
          hasError: true,
        ),
      );
    }
  }

  void _billOrderPackage(
    BillOrderPackageEvent event,
    Emitter<OrderPackageState> emitter,
  ) async {
    try {
      emitter(
        OrderPackageState(
          ordersPackages: state.ordersPackages,
          loading: true,
          reciepImage: state.reciepImage,
        ),
      );
      if (state.reciepImage.path.isNotEmpty) {
        String fileNamePayment =
            await UploadService.singleFile(state.reciepImage.path);
        await OrderPackageService.billOrderPackage(
          event.token,
          event.docId,
          event.status,
          fileNamePayment,
        );
        emitter(
          OrderPackageState(
              ordersPackages: state.ordersPackages,
              loaded: true,
              loading: false,
              reciepImage: state.reciepImage,
              message: 'ยื่นหลักฐานชำระเงินเรียบร้อย รอแอดมินอนุมัติเข้าร่วม'),
        );
      } else {
        emitter(
          OrderPackageState(
              ordersPackages: state.ordersPackages,
              hasError: true,
              loading: false,
              reciepImage: state.reciepImage,
              message: 'ไม่สามารถอัพโหลดรูปภาพได้'),
        );
      }
    } catch (e) {
      emitter(
        OrderPackageState(
            ordersPackages: state.ordersPackages,
            hasError: true,
            loading: false,
            reciepImage: state.reciepImage,
            message: 'ยืนยันการชำระเงินล้มเหลว'),
      );
    }
  }

  void _selectImageReceipt(
      SelectImageReceiptEvent event, Emitter<OrderPackageState> emitter) {
    emitter(
      OrderPackageState(
          ordersPackages: state.ordersPackages, reciepImage: event.image),
    );
  }
}
