// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'cash_register_form_bloc.dart';

class CashRegisterFormState extends Equatable {
  final String? licenceKey;
  final TextEditingController controller;
  const CashRegisterFormState(this.licenceKey, this.controller);

  @override
  List<Object?> get props => [licenceKey, controller];

  CashRegisterFormState copyWith({
    String? licenceKey,
    TextEditingController? controller,
  }) {
    return CashRegisterFormState(
      licenceKey ?? this.licenceKey,
      controller ?? this.controller,
    );
  }
}
