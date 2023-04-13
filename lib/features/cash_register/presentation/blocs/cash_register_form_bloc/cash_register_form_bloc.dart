import 'package:bloc/bloc.dart';
import 'package:check_bloc/features/cash_register/domain/repository/cash_register_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'cash_register_form_event.dart';
part 'cash_register_form_state.dart';

class CashRegisterFormBloc
    extends Bloc<CashRegisterFormEvent, CashRegisterFormState> {
  final CashRegisterRepository _registerRepository;

  CashRegisterFormBloc(this._registerRepository)
      : super(CashRegisterFormState(null, TextEditingController())) {
    on<CashRegisterFormLoadEvent>(_loadLicenceKey);
    on<CashRegisterFormSubmitEvent>(_onSubmit);
  }

  _loadLicenceKey(CashRegisterFormLoadEvent event, emit) async {
    final String? key = await _registerRepository.getLicenseKey();
    final controller = TextEditingController(text: key);

    emit(state.copyWith(licenceKey: key, controller: controller));
  }

  _onSubmit(CashRegisterFormSubmitEvent event, emit) async {
    await _registerRepository.saveLicenseKey(state.controller.text);
  }

  @override
  Future<void> close() {
    state.controller.dispose();
    return super.close();
  }
}
