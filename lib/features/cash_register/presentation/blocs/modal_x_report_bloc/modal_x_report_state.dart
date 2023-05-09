part of 'modal_x_report_bloc.dart';

class ModalXReportState extends Equatable {
  final ReportEntity? report;
  final BlocStateStatus status;
  final String? errorText;

  const ModalXReportState({
    required this.report,
    required this.status,
    required this.errorText,
  });

  const ModalXReportState.empty()
      : report = null,
        status = BlocStateStatus.initial,
        errorText = null;

  @override
  List<Object?> get props => [report, status, errorText];

  ModalXReportState copyWith({
    ReportEntity? report,
    BlocStateStatus? status,
    String? errorText,
  }) {
    return ModalXReportState(
      report: report ?? this.report,
      status: status ?? this.status,
      errorText: errorText ?? this.errorText,
    );
  }
}
