part of 'receipt_delivery_bloc.dart';

class ReceiptDeliveryState extends Equatable {
  final String? email;
  final String? phone;
  final BlocStateStatus status;
  final String? errorText;

  const ReceiptDeliveryState({
    required this.email,
    required this.phone,
    required this.status,
    required this.errorText,
  });

  const ReceiptDeliveryState.empty()
      : email = null,
        phone = null,
        status = BlocStateStatus.initial,
        errorText = null;

  @override
  List<Object?> get props => [email, phone, status, errorText];

  ReceiptDeliveryState copyWith({
    String? email,
    String? phone,
    BlocStateStatus? status,
    String? errorText,
  }) {
    return ReceiptDeliveryState(
      email: email,
      phone: phone,
      status: status ?? this.status,
      errorText: errorText,
    );
  }
}
