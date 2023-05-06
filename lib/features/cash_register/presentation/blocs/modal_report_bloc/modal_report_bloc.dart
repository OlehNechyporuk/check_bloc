import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/reports/get_report_use_case.dart';

part 'modal_report_event.dart';
part 'modal_report_state.dart';

class ModalReportBloc extends Bloc<ModalReportEvent, ModalReportState> {
  final GetReportUseCase _getReportUseCase;
  ModalReportBloc(this._getReportUseCase)
      : super(const ModalReportState.empty()) {
    on<ModalReportLoadedEvent>(_loaded);
  }

  _loaded(ModalReportLoadedEvent event, emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));

    final result = await _getReportUseCase(ReportUseCaseParams(event.id));

    result.fold((error) {
      emit(state.copyWith(
          errorText: error.message, status: BlocStateStatus.failure));
    }, (report) {
      emit(
        state.copyWith(
          status: BlocStateStatus.success,
          report: report,
        ),
      );
    });
  }
}
