part of 'package_bloc.dart';

class PackageState extends Equatable {
  final PackageTourModel packagesTour;
  final List<OrderActivityModel> buyActivity;
  final bool isError;
  final String packageId;
  PackageState({
    PackageTourModel? packagesTour,
    List<OrderActivityModel>? buyActivity,
    this.isError = false,
    this.packageId = "",
  })  : packagesTour = packagesTour ??
            PackageTourModel(
              round: [],
              contactName: '',
              contactPhone: '',
              createdBy: '',
              dayForrent: [],
              dayTrips: '',
              id: '',
              mark: '',
              packageImage: '',
              packageName: '',
              price: 0.0,
              introduce: '',
              accountPayment: '',
              imagePayment: '',
              typePayment: '',
              description: '',
            ),
        buyActivity = buyActivity ?? <OrderActivityModel>[];

  @override
  List<Object> get props => [packagesTour, buyActivity, isError, packageId];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'buyActivity': buyActivity.map((x) => x.toMap()).toList(),
      'packageId': packageId,
    };
  }

  factory PackageState.fromMap(Map<String, dynamic> map) {
    return PackageState(
      buyActivity: List<OrderActivityModel>.from(
        map['buyActivity']?.map(
          (x) => OrderActivityModel.fromMap(x),
        ),
      ),
      packageId: map['packageId'],
    );
  }
}
