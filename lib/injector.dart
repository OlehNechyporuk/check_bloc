import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/repository/shift_repository_checkbox_impl.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/auth/change_current_cash_register_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/auth/check_auth_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/auth/login_cash_register_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/auth/logout_cash_register_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/cashier/get_cashier_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/shift/cash_in_shift_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/shift/cash_out_shift_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/shift/close_shift_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/shift/get_shift_use_case.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/shift/open_shift_use_case.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/checkbox_api_data_provider.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/db_shared_preferences.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/repository/auth_repository_checkbox_impl.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/repository/cash_register_repository_checkbox_impl.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/repository/cashier_repositpry_checkbox_impl.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/repository/payment_repository_checkbox_impl.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/repository/product_repository_checkbox_impl.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/repository/receipt_repository_checkbox_impl.dart';
import 'package:check_bloc/features/cash_register/domain/repository/auth_repository.dart';
import 'package:check_bloc/features/cash_register/domain/repository/cash_register_repository.dart';
import 'package:check_bloc/features/cash_register/domain/repository/cashier_repository.dart';
import 'package:check_bloc/features/cash_register/domain/repository/payment_repository.dart';
import 'package:check_bloc/features/cash_register/domain/repository/product_repository.dart';
import 'package:check_bloc/features/cash_register/domain/repository/receipt_repository.dart';
import 'package:check_bloc/features/cash_register/domain/repository/shift_repository.dart';
import 'package:check_bloc/features/cash_register/domain/usecases/cash_register/get_cash_register_info_use_case.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/bottom_nav_bloc/bottom_navbar_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/cash_register_bloc/cash_register_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/cash_register_form_bloc/cash_register_form_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/cashier_bloc/cashier_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/login_form_bloc/login_form_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/payments_bloc/payments_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/products_bloc/products_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/receipt_bloc/receipt_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/receipt_delivery_bloc/receipt_delivery_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/receipts_history_bloc/receipts_history_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/shift_bloc/shift_bloc.dart';
import 'package:check_bloc/features/crm/data/data_provider/auth_crm_data_provider.dart';
import 'package:check_bloc/features/crm/data/data_provider/cash_register_crm_data_provider.dart';
import 'package:check_bloc/features/crm/data/data_provider/user_crm_data_provider.dart';
import 'package:check_bloc/features/crm/data/repository/auth_repository_crm_impl.dart';
import 'package:check_bloc/features/crm/data/repository/cash_register_crm_repository_impl.dart';
import 'package:check_bloc/features/crm/data/repository/user_repository_crm_impl.dart';
import 'package:check_bloc/features/crm/domain/repository/auth_repository_crm.dart';
import 'package:check_bloc/features/crm/domain/repository/cash_register_crm_repository.dart';
import 'package:check_bloc/features/crm/domain/repository/user_repository_crm.dart';
import 'package:check_bloc/features/crm/domain/usecase/auth/check_user_auth_status_use_case.dart';
import 'package:check_bloc/features/crm/domain/usecase/auth/login_auth_crm_use_case.dart';
import 'package:check_bloc/features/crm/domain/usecase/auth/logout_auth_crm_use_case.dart';
import 'package:check_bloc/features/crm/domain/usecase/cash_register/add_cash_register_crm_use_case.dart';
import 'package:check_bloc/features/crm/domain/usecase/cash_register/get_cash_register_crm_type_use_case.dart';
import 'package:check_bloc/features/crm/domain/usecase/cash_register/get_cash_register_crm_use_case.dart';
import 'package:check_bloc/features/crm/domain/usecase/user/get_user_use_case.dart';
import 'package:check_bloc/features/crm/presentation/blocs/add_cash_register_crm_bloc/add_cash_register_crm_bloc.dart';
import 'package:check_bloc/features/crm/presentation/blocs/auth_crm_bloc/auth_crm_bloc.dart';
import 'package:check_bloc/features/crm/presentation/blocs/cash_register_crm_bloc/cash_register_crm_bloc.dart';
import 'package:check_bloc/features/crm/presentation/blocs/user_crm_bloc/user_crm_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDI() async {
  //util
  sl.registerSingleton<FlutterSecureStorage>(const FlutterSecureStorage());
  sl.registerLazySingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton<AssetsAudioPlayer>(() => AssetsAudioPlayer());

  sl.registerLazySingleton<SessionDataProvider>(
    () => SessionDataProvider(sl()),
  );
  sl.registerLazySingleton<DbSharedPreferences>(
    () => DbSharedPreferences(sl()),
  );

  //CASHREGISTER
  //data providers
  //Checkbox
  sl.registerLazySingleton<CheckboxApiDataProvider>(
    () => CheckboxApiDataProvider(sl()),
  );

  //repositories
  //Checkbox
  initCheckbox();

  //use cases
  sl.registerLazySingleton<CheckAuthCashRegisterUseCase>(
    () => CheckAuthCashRegisterUseCase(sl()),
  );
  sl.registerLazySingleton<GetCashRegisterInfoUseCase>(
    () => GetCashRegisterInfoUseCase(sl()),
  );
  sl.registerLazySingleton<LoginCashRegisterUseCase>(
    () => LoginCashRegisterUseCase(
      sl(),
    ),
  );
  sl.registerLazySingleton<ChangeCurrentCashRegisterUseCase>(
    () => ChangeCurrentCashRegisterUseCase(
      sl(),
    ),
  );
  sl.registerLazySingleton<LogoutCashRegisteruseCase>(
    () => LogoutCashRegisteruseCase(
      sl(),
    ),
  );
  sl.registerLazySingleton<OpenShiftUseCase>(() => OpenShiftUseCase(sl()));
  sl.registerLazySingleton<GetShiftUseCase>(() => GetShiftUseCase(sl()));
  sl.registerLazySingleton<CloseShiftUseCase>(() => CloseShiftUseCase(sl()));
  sl.registerLazySingleton<CashInShiftUseCase>(() => CashInShiftUseCase(sl()));
  sl.registerLazySingleton<CashOutShiftUseCase>(
    () => CashOutShiftUseCase(sl()),
  );
  sl.registerLazySingleton<GetCashierUseCase>(() => GetCashierUseCase(sl()));

  //blocs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl(), sl(), sl()));
  sl.registerFactory<BottomNavbarBloc>(() => BottomNavbarBloc());
  sl.registerFactory<CashRegisterBloc>(() => CashRegisterBloc(sl()));
  sl.registerFactory<CashRegisterFormBloc>(() => CashRegisterFormBloc(sl()));
  sl.registerFactory<CashierBloc>(() => CashierBloc(sl()));
  sl.registerFactory<LoginFormBloc>(() => LoginFormBloc(sl()));
  sl.registerFactory<PaymentsBloc>(() => PaymentsBloc(sl()));
  sl.registerFactory<ProductsBloc>(() => ProductsBloc(sl()));
  sl.registerFactory<ReceiptBloc>(() => ReceiptBloc(sl(), sl(), sl()));
  sl.registerFactory<ReceiptDeliveryBloc>(() => ReceiptDeliveryBloc(sl()));
  sl.registerFactory<ReceiptsHistoryBloc>(() => ReceiptsHistoryBloc(sl()));
  sl.registerFactory<ShiftBloc>(() => ShiftBloc(sl(), sl(), sl(), sl(), sl()));

  //CRM
  //data providers
  sl.registerLazySingleton<AuthCrmDataProvider>(
    () => AuthCrmDataProvider(sl()),
  );
  sl.registerLazySingleton<UserCrmDataProvider>(
    () => UserCrmDataProvider(sl()),
  );
  sl.registerLazySingleton<CashRegisterCrmDataProvider>(
    () => CashRegisterCrmDataProvider(sl()),
  );

  //repositories
  sl.registerLazySingleton<AuthRepositoryCrm>(
    () => AuthRepositoryCrmImpl(sl(), sl()),
  );
  sl.registerLazySingleton<UserRepositoryCrm>(
    () => UserRepositoryCrmImpl(sl(), sl()),
  );
  sl.registerLazySingleton<CashRegisterCrmRepository>(
    () => CashRegisterCrmRepositoryImpl(sl(), sl()),
  );

  //use cases
  sl.registerLazySingleton<CheckUserAuthStatusUseCase>(
    () => CheckUserAuthStatusUseCase(sl()),
  );
  sl.registerLazySingleton<LoginAuthCrmUseCase>(
    () => LoginAuthCrmUseCase(sl()),
  );
  sl.registerLazySingleton<LogoutAuthCrmUseCase>(
    () => LogoutAuthCrmUseCase(sl()),
  );
  sl.registerLazySingleton<GetUserUseCase>(
    () => GetUserUseCase(sl()),
  );
  sl.registerLazySingleton<GetCashRegistersCrmUseCase>(
    () => GetCashRegistersCrmUseCase(sl()),
  );
  sl.registerLazySingleton<GetCashRegisterCrmTypeUseCase>(
    () => GetCashRegisterCrmTypeUseCase(sl()),
  );
  sl.registerLazySingleton<AddCashRegisterCrmUseCase>(
    () => AddCashRegisterCrmUseCase(sl()),
  );

  //blocs
  sl.registerFactory<AuthCrmBloc>(() => AuthCrmBloc(sl(), sl(), sl()));
  sl.registerFactory<UserCrmBloc>(() => UserCrmBloc(sl()));
  sl.registerFactory<CashRegisterCrmBloc>(
    () => CashRegisterCrmBloc(sl(), sl()),
  );
  sl.registerFactory<AddCashRegisterCrmBloc>(
    () => AddCashRegisterCrmBloc(sl()),
  );
}

void initCheckbox() {
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryCheckboxImpl(sl(), sl()),
  );
  sl.registerLazySingleton<CashRegisterRepository>(
    () => CashRegisterRepositoryCheckboxImpl(sl(), sl()),
  );
  sl.registerLazySingleton<CashierRepository>(
    () => CashierRepositoryCheckboxImpl(sl(), sl()),
  );
  sl.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryCheckboxImpl(sl()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryCheckboxImpl(sl(), sl()),
  );
  sl.registerLazySingleton<ReceiptRepository>(
    () => ReceiptRepositoryCheckboxImpl(sl(), sl()),
  );
  sl.registerLazySingleton<ShiftRepository>(
    () => ShiftRepositoryCheckboxImpl(sl(), sl()),
  );
}

void disposeCheckbox() {
  sl.unregister<AuthRepository>();
  sl.unregister<CashRegisterRepository>();
  sl.unregister<CashierRepository>();
  sl.unregister<PaymentRepository>();
  sl.unregister<ProductRepository>();
  sl.unregister<ReceiptRepository>();
  sl.unregister<ShiftRepository>();
}
