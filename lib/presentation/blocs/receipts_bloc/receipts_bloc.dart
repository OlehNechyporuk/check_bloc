import 'package:bloc/bloc.dart';
import 'package:check_bloc/domain/entity/receipt.dart';
import 'package:check_bloc/domain/repository/receipt_repository.dart';
import 'package:equatable/equatable.dart';

part 'receipts_event.dart';
part 'receipts_state.dart';

class ReceiptsBloc extends Bloc<ReceiptsEvent, ReceiptsState> {
  final ReceiptRepository _receiptRepository;
  ReceiptsBloc(this._receiptRepository) : super(InititalState()) {
    on<ReceiptsLoadedEvent>(_loaded);
    on<ReceiptShowHtmlEvent>(_showHtml);
  }

  _loaded(ReceiptsLoadedEvent event, emit) async {
    emit(InititalState());

    final receipts = await _receiptRepository.receipts();

    emit(LoadedState(receipts: receipts, receipt: null));
  }

  _showHtml(ReceiptShowHtmlEvent event, emit) async {
    final html = await _receiptRepository.getHtml(event.id);

    emit(LoadedState(receipts: const [], receipt: html));
  }
}
