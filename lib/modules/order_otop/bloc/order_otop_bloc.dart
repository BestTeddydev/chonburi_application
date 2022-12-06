import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:chonburi_mobileapp/modules/tracking_order_otop/models/order_otop_model.dart';
import 'package:chonburi_mobileapp/utils/services/order_otop_service.dart';
import 'package:equatable/equatable.dart';

part 'order_otop_event.dart';
part 'order_otop_state.dart';

class OrderOtopBloc extends Bloc<OrderOtopEvent, OrderOtopState> {
  OrderOtopBloc() : super(const OrderOtopState(orders: [])) {
    on<UpdateOrderOtopEvent>(updateOrderOtop);
    on<FetchMyOrdersOtopEvent>(fetchsOrderOtop);
  }
  void updateOrderOtop(
    UpdateOrderOtopEvent event,
    Emitter<OrderOtopState> emitter,
  ) async {
    try {
      emitter(OrderOtopState(orders: state.orders, loading: true));

      await OrderOtopService.editOrderOtop('/order/product/${event.orderOtopModel.id}',event.token, event.orderOtopModel);
      emitter(
        OrderOtopState(
          orders: state.orders,
          orderStatus: event.orderOtopModel.status,
          loaded: true,
          loading: false,
          message: "อัพเดทสถานะเรียบร้อย",
        ),
      );
    } catch (e) {
      emitter(OrderOtopState(
        orders: state.orders,
        hasError: true,
        loading: false,
        message: "อัพเดทสถานะล้มเหลว",
      ));
    }
  }

  void fetchsOrderOtop(
    FetchMyOrdersOtopEvent event,
    Emitter<OrderOtopState> emitter,
  ) async {
    try {
      List<OrderOtopModel> orders = await OrderOtopService.fetchsOrderOtop(
          event.businessId, event.token, "businessId");
      emitter(
        OrderOtopState(
          orders: orders,
        ),
      );
    } catch (e) {
      emitter(
        OrderOtopState(
          orders: state.orders,
          hasError: true,
          message: "เกิดเหตุขัดข้อง ขออภัยในความไม่สะดวก",
        ),
      );
    }
  }

  void setInitOrderStatus(
      SetInitOrderStatus event, Emitter<OrderOtopState> emitter) {
    emitter(
      OrderOtopState(
        orders: state.orders,
        orderStatus: event.status,
      ),
    );
  }

}
