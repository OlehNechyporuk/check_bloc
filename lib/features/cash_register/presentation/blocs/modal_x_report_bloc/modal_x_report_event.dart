part of 'modal_x_report_bloc.dart';

abstract class ModalXReportEvent extends Equatable {
  const ModalXReportEvent();

  @override
  List<Object> get props => [];
}

class ModalXReportLoadedEvent extends ModalXReportEvent {}
