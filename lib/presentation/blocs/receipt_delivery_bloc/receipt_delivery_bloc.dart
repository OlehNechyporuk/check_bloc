import 'package:bloc/bloc.dart';
import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/domain/repository/receipt_repository.dart';
import 'package:equatable/equatable.dart';

part 'receipt_delivery_event.dart';
part 'receipt_delivery_state.dart';

class ReceiptDeliveryBloc
    extends Bloc<ReceiptDeliveryEvent, ReceiptDeliveryState> {
  final ReceiptRepository _receiptRepository;
  ReceiptDeliveryBloc(this._receiptRepository)
      : super(const ReceiptDeliveryState.empty()) {
    on<ReceiptDeliveryInitialEvent>(_initial);
    on<ReceiptDeliverySendEmailEvent>(_sendEmail);
    on<ReceiptDeliverySendSmsEvent>(_sendSms);
  }

  _initial(ReceiptDeliveryInitialEvent event, emit) {
    emit(const ReceiptDeliveryState.empty());
  }

  _sendEmail(ReceiptDeliverySendEmailEvent event, emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));

    final result =
        await _receiptRepository.sendEmail(event.receiptId, event.email);

    result.fold(
      (error) => emit(
        state.copyWith(
          status: BlocStateStatus.failure,
          errorText: error.message,
        ),
      ),
      (success) {
        if (success) {
          emit(
            state.copyWith(
              status: BlocStateStatus.success,
              errorText: null,
              email: null,
            ),
          );
        }
      },
    );
  }

  _sendSms(ReceiptDeliverySendSmsEvent event, emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));

    final result =
        await _receiptRepository.sendSms(event.receiptId, event.phone);

    result.fold(
      (error) => emit(
        state.copyWith(
          status: BlocStateStatus.failure,
          errorText: error.message,
        ),
      ),
      (success) {
        if (success) {
          emit(
            state.copyWith(
              status: BlocStateStatus.success,
              errorText: null,
              phone: null,
            ),
          );
        }
      },
    );
  }
}
