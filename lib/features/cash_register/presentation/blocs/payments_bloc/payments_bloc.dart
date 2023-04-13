import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:check_bloc/features/cash_register/domain/entity/receipt_payment_entity.dart';
import 'package:check_bloc/features/cash_register/domain/repository/payment_repository.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  final PaymentRepository _paymentRepository;
  PaymentsBloc(this._paymentRepository) : super(const PaymentsState([])) {
    on<PaymentsLoadedEvent>(_loaded);
  }

  _loaded(PaymentsLoadedEvent event, emit) async {
    final payments = await _paymentRepository.getPayments();

    emit(state.copyWith(payments: payments));
  }
}
