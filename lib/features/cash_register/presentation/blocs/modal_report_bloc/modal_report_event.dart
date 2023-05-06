part of 'modal_report_bloc.dart';

abstract class ModalReportEvent extends Equatable {
  const ModalReportEvent();

  @override
  List<Object> get props => [];
}

class ModalReportLoadedEvent extends ModalReportEvent {
  final String id;

  const ModalReportLoadedEvent(this.id);
}
