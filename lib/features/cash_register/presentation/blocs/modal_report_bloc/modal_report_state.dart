part of 'modal_report_bloc.dart';

class ModalReportState extends Equatable {
  final BlocStateStatus status;
  final String? report;
  final String? errorText;

  const ModalReportState({
    required this.status,
    required this.report,
    required this.errorText,
  });

  const ModalReportState.empty()
      : status = BlocStateStatus.initial,
        report = null,
        errorText = null;

  @override
  List<Object?> get props => [status, report, errorText];

  ModalReportState copyWith({
    BlocStateStatus? status,
    String? report,
    String? errorText,
  }) {
    return ModalReportState(
      status: status ?? this.status,
      report: report ?? this.report,
      errorText: errorText ?? this.errorText,
    );
  }
}
