import 'package:bloc/bloc.dart';
import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/core/usecases/usecase.dart';
import 'package:check_bloc/features/crm/domain/entity/user_entity.dart';
import 'package:check_bloc/features/crm/domain/usecase/user/get_user_use_case.dart';
import 'package:equatable/equatable.dart';

part 'user_crm_event.dart';
part 'user_crm_state.dart';

class UserCrmBloc extends Bloc<UserCrmEvent, UserCrmState> {
  final GetUserUseCase _getUserUseCase;

  UserCrmBloc(this._getUserUseCase) : super(const UserCrmState.empty()) {
    on<UserCrmLoadedEvent>(_load);
  }

  _load(UserCrmLoadedEvent event, emit) async {
    emit(state.copyWith(status: BlocStateStatus.loading));

    final result = await _getUserUseCase(NoParams());

    result.fold(
      (error) => emit(
        state.copyWith(
          status: BlocStateStatus.failure,
          errorText: error.message,
        ),
      ),
      (user) => emit(
        state.copyWith(
          status: BlocStateStatus.success,
          user: user,
        ),
      ),
    );
  }
}
