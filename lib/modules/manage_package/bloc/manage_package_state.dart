part of 'manage_package_bloc.dart';

class ManagePackageState extends Equatable {
  final List<PackageTourModel> packages;
  final bool loading;
  final bool loaded;
  final bool hasError;
  final String message;
  final File packageImage;
  final String dayType;
  final List<String> dayForrents;
  final List<PackageRoundModel> rounds;
  final File imagePayment;
  final String typePayment;
  ManagePackageState({
    required this.packages,
    this.loaded = false,
    this.loading = false,
    this.hasError = false,
    this.message = '',
    this.dayType = 'zero',
    this.dayForrents = const [],
    this.rounds = const <PackageRoundModel>[],
    File? packageImage,
    File? imagePayment,
    this.typePayment = 'พร้อมเพย์',
  }) : packageImage = packageImage ?? File(''),imagePayment = imagePayment ?? File('');

  @override
  List<Object> get props => [
        packages,
        loaded,
        loading,
        hasError,
        message,
        packageImage,
        dayType,
        dayForrents,
        rounds,
        imagePayment,
        typePayment
      ];
}
