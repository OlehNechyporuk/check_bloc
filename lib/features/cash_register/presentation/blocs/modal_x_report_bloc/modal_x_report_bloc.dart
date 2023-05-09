import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/cash_register/domain/entity/report_entity.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/reports/get_x_report_use_case.dart';

part 'modal_x_report_event.dart';
part 'modal_x_report_state.dart';

class ModalXReportBloc extends Bloc<ModalXReportEvent, ModalXReportState> {
  final GetXReportUseCase _getXReportUseCase;

  ModalXReportBloc(this._getXReportUseCase)
      : super(const ModalXReportState.empty()) {
    on<ModalXReportLoadedEvent>(_loaded);
  }

  _loaded(ModalXReportLoadedEvent event, emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));

    final result = await _getXReportUseCase(NoParams());

    result.fold(
      (error) => emit(
        state.copyWith(
          status: BlocStateStatus.failure,
          errorText: error.message,
        ),
      ),
      (report) => emit(
        state.copyWith(status: BlocStateStatus.success, report: report),
      ),
    );
  }
}
