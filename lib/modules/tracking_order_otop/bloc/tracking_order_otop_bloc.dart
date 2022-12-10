import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chonburi_mobileapp/modules/tracking_order_otop/models/order_otop_model.dart';
import 'package:chonburi_mobileapp/utils/services/order_otop_service.dart';
import 'package:chonburi_mobileapp/utils/services/upload_file_service.dart';
import 'package:equatable/equatable.dart';

part 'tracking_order_otop_event.dart';
part 'tracking_order_otop_state.dart';

class TrackingOrderOtopBloc
    extends Bloc<TrackingOrderOtopEvent, TrackingOrderOtopState> {
  TrackingOrderOtopBloc() : super(TrackingOrderOtopState(orders: const [])) {
    on<CreateOrderOtopEvent>(createOrderOtop);
    on<FetchOrdersOtopEvent>(fetchsOrderOtop);
    on<BuyerSetInitOrderStatusEvent>(setInitOrderStatus);
    on<BuyerUpdateOrderOtopEvent>(updateOrderOtop);
    on<BuyerSelectImagePaymentEvent>(selectImagePayment);
  }

  void createOrderOtop(
    CreateOrderOtopEvent event,
    Emitter<TrackingOrderOtopState> emitter,
  ) async {
    try {
      emitter(TrackingOrderOtopState(orders: state.orders, loading: true));
      if (event.imagePayment.path.isNotEmpty) {
        String imageRef =
            await UploadService.singleFile(event.imagePayment.path);
        event.orderOtopModel.imagePayment.add(imageRef);
      }
      await OrderOtopService.createOrderOtop(event.token, event.orderOtopModel);
      emitter(
        TrackingOrderOtopState(
          orders: state.orders,
          loaded: true,
          loading: false,
          message: "ชำระเงินเรียบร้อย ขอบคุณที่ใช้บริการครับ",
        ),
      );
    } catch (e) {
      emitter(TrackingOrderOtopState(
        orders: state.orders,
        hasError: true,
        loading: false,
        message: "ชำระเงินล้มเหลว ขออภัยในความไม่สะดวก",
      ));
    }
  }

  void fetchsOrderOtop(
    FetchOrdersOtopEvent event,
    Emitter<TrackingOrderOtopState> emitter,
  ) async {
    try {
      List<OrderOtopModel> orders = await OrderOtopService.fetchsOrderOtop(
          event.userId, event.token, "userId");
      emitter(
        TrackingOrderOtopState(
          orders: orders,
        ),
      );
    } catch (e) {
      emitter(
        TrackingOrderOtopState(
          orders: state.orders,
          hasError: true,
          message: "เกิดเหตุขัดข้อง ขออภัยในความไม่สะดวก",
        ),
      );
    }
  }

  void updateOrderOtop(
    BuyerUpdateOrderOtopEvent event,
    Emitter<TrackingOrderOtopState> emitter,
  ) async {
    try {
      emitter(TrackingOrderOtopState(
        orders: state.orders,
        loading: true,
        imagePayment: state.imagePayment,
      ));
      if (event.imagePayment.path.isNotEmpty) {
        String imageRef =
            await UploadService.singleFile(event.imagePayment.path);
        event.orderOtopModel.imagePayment.add(imageRef);
      }
      await OrderOtopService.editOrderOtop(
        '/order/product/customer/update/status/${event.orderOtopModel.id}',
        event.token,
        event.orderOtopModel,
      );
      emitter(
        TrackingOrderOtopState(
          orders: state.orders,
          orderStatus: event.orderOtopModel.status,
          loaded: true,
          loading: false,
          message: "อัพเดทสถานะเรียบร้อย",
          imagePayment: state.imagePayment,
        ),
      );
    } catch (e) {
      emitter(TrackingOrderOtopState(
        orders: state.orders,
        hasError: true,
        loading: false,
        message: "อัพเดทสถานะล้มเหลว",
        imagePayment: state.imagePayment,
      ));
    }
  }

  void setInitOrderStatus(
    BuyerSetInitOrderStatusEvent event,
    Emitter<TrackingOrderOtopState> emitter,
  ) {
    emitter(
      TrackingOrderOtopState(
        orders: state.orders,
        orderStatus: event.status,
        imagePayment: state.imagePayment,
      ),
    );
  }

  void selectImagePayment(
    BuyerSelectImagePaymentEvent event,
    Emitter<TrackingOrderOtopState> emitter,
  ) {
    emitter(
      TrackingOrderOtopState(
        orders: state.orders,
        orderStatus: state.orderStatus,
        imagePayment: event.image,
      ),
    );
  }
}
