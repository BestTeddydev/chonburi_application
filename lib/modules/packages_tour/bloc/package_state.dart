part of 'package_bloc.dart';

class PackageState extends Equatable {
  final DateTime checkDate;
  final DateTime checkEndDate;
  final int totalMember;
  final PackageTourModel packagesTour;
  final List<OrderActivityModel> buyActivity;
  final bool loaded;
  final bool isError;
  final String packageId;
  final List<PackageTourModel> packages;
  final File slipPayment; // slip payment
  PackageState({
    this.packages = const [],
    PackageTourModel? packagesTour,
    List<OrderActivityModel>? buyActivity,
    this.loaded = false,
    this.isError = false,
    this.packageId = "",
    DateTime? checkDate,
    DateTime? checkEndDate,
    this.totalMember = 0,
    File? slipPayment,
  })  : packagesTour = packagesTour ??
            PackageTourModel(
              round: [],
              createdBy: '',
              dayForrent: [],
              dayTrips: '',
              id: '',
              mark: '',
              packageImage: '',
              packageName: '',
              price: 0.0,
              introduce: '',
              description: '',
              contactAdmin: ContactAdminModel(
                accountPayment: '',
                address: '',
                createdBy: '',
                fullName: '',
                id: '',
                phoneNumber: '',
                typePayment: '',
                imagePayment: '',
                profileRef: '',
              ),
            ),
        buyActivity = buyActivity ?? <OrderActivityModel>[],
        checkDate = checkDate ?? DateTime.now(),
        checkEndDate = checkEndDate ?? DateTime.now(),
        slipPayment = slipPayment ?? File('');

  @override
  List<Object> get props => [
        packagesTour,
        buyActivity,
        isError,
        packageId,
        packages,
        totalMember,
        checkDate,
        slipPayment,
        loaded,
        checkEndDate
      ];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'buyActivity': buyActivity.map((x) => x.toMap()).toList(),
      'packageId': packageId,
      'checkDate': checkDate.millisecondsSinceEpoch,
      'checkEndDate': checkEndDate.millisecondsSinceEpoch,
      'totalMember': totalMember
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
        checkDate: DateTime.fromMillisecondsSinceEpoch(map['checkDate']),
        checkEndDate: DateTime.fromMillisecondsSinceEpoch(map['checkEndDate']),
        totalMember: map['totalMember']);
  }
}
