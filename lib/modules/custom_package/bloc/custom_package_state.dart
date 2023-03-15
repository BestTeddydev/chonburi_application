part of 'custom_package_bloc.dart';

class CustomPackageState extends Equatable {
  final bool hasError;
  final bool loading;
  final bool loaded;
  final List<PackageRoundModel> rounds;
  final List<OrderCustomModel> orders;
  const CustomPackageState({
    this.rounds = const <PackageRoundModel>[],
    this.orders = const<OrderCustomModel>[],
    this.hasError = false,
    this.loaded = false,
    this.loading = false,
  });

  @override
  List<Object> get props => [rounds,hasError,loading,loaded,orders];
}
