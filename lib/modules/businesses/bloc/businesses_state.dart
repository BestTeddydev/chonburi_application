part of 'businesses_bloc.dart';

class BusinessesState extends Equatable {
  final List<BusinessModel> businesses;
  final BusinessModel businessModel;
  final bool loading;
  final bool loaded;
  final bool hasError;
  final String message;
  final String typePayment;
  final File qrcodeRef; // image qr code for payment
  final File coverImage; // image of business
  BusinessesState({
    this.businesses = const <BusinessModel>[],
    this.loaded = false,
    this.loading = false,
    this.hasError = false,
    this.typePayment = 'พร้อมเพย์',
    this.message = '',
    BusinessModel? businessModel,
    File? qrcodeRef,
    File? coverImage,
  })  : businessModel = businessModel ??
            BusinessModel(
              id: '',
              businessName: '',
              sellerId: '',
              address: '',
              latitude: 0,
              longitude: 0,
              statusOpen: true,
              ratingCount: 0,
              point: 0,
              paymentNumber: '',
              qrcodeRef: '',
              phoneNumber: '',
              imageRef: '',
              ratePrice: 0,
              typeBusiness: '', typePayment: '', introduce: '',
            ),
        qrcodeRef = qrcodeRef ?? File(''),
        coverImage = coverImage ?? File('');

  @override
  List<Object> get props => [
        businesses,
        loading,
        loaded,
        hasError,
        businessModel,
        typePayment,
        qrcodeRef,
        coverImage,
      ];
}
