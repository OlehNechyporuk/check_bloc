import 'package:bloc/bloc.dart';
import 'package:check_bloc/domain/entity/receipt_payment.dart';
import 'package:check_bloc/domain/repository/payment_repository.dart';
import 'package:equatable/equatable.dart';

part 'payments_event.dart';
part 'payments_state.dart';

class PaymentsBloc extends Bloc<PaymentsEvent, PaymentsState> {
  final PaymetnRepository _paymentRepository;
  PaymentsBloc(this._paymentRepository) : super(const PaymentsState([])) {
    on<PaymentsLoadedEvent>(_loaded);
  }

  _loaded(PaymentsLoadedEvent event, emit) async {
    final payments = await _paymentRepository.getPayments();

    emit(state.copyWith(payments: payments));
  }
}
