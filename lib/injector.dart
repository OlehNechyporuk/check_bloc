import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:check_bloc/features/crm/domain/usecase/cash_register/add_cash_register_crm_use_case.dart';
import 'package:check_bloc/features/crm/domain/usecase/cash_register/get_cash_register_crm_type_use_case.dart';
import 'package:check_bloc/features/crm/presentation/blocs/add_cash_register_crm_bloc/add_cash_register_crm_bloc.dart';
import 'package:check_bloc/features/crm/presentation/blocs/cash_register_crm_bloc/cash_register_crm_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/auth_api_provider.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/cash_register_api_data_provider.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/cashier_api_data_provider.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/db_shared_preferences.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/product_api_provider.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/receipt_api_provider.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/data_provider/shift_api_data_provider.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/repository/auth_repository_impl.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/repository/cash_register_repository_impl.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/repository/cashier_repositpry_impl.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/repository/payment_repository_impl.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/repository/product_repository_impl.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/repository/receipt_repository_impl.dart';
import 'package:check_bloc/features/cash_register/data/checkbox/repository/shift_repository_impl.dart';
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
import 'package:check_bloc/features/crm/domain/usecase/cash_register/get_cash_register_crm_use_case.dart';
import 'package:check_bloc/features/crm/domain/usecase/user/get_user_use_case.dart';
import 'package:check_bloc/features/crm/presentation/blocs/auth_crm_bloc/auth_crm_bloc.dart';
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

  //CASHREGISTER
  //data providers
  sl.registerLazySingleton<SessionDataProvider>(
    () => SessionDataProvider(sl()),
  );
  sl.registerLazySingleton<DbSharedPreferences>(
    () => DbSharedPreferences(sl()),
  );
  sl.registerLazySingleton<AuthApiProvider>(
    () => AuthApiProvider(sl()),
  );
  sl.registerLazySingleton<CashRegisterApiDataProvider>(
    () => CashRegisterApiDataProvider(sl()),
  );
  sl.registerLazySingleton<CashierApiDataProvider>(
    () => CashierApiDataProvider(sl()),
  );
  sl.registerLazySingleton<ProductApiDataProvider>(
    () => ProductApiDataProvider(sl()),
  );
  sl.registerLazySingleton<ReceiptApiProvider>(
    () => ReceiptApiProvider(sl()),
  );
  sl.registerLazySingleton<ShiftApiDataProvider>(
    () => ShiftApiDataProvider(sl()),
  );

  //repositories
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<CashRegisterRepository>(
    () => CashRegisterRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<CashierRepository>(
    () => CashierRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<PaymentRepository>(
    () => PaymentRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<ReceiptRepository>(
    () => ReceiptRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<ShiftRepository>(
    () => ShiftRepositoryImpl(sl(), sl()),
  );

  //use cases
  sl.registerLazySingleton<GetCashRegisterInfoUseCase>(
    () => GetCashRegisterInfoUseCase(sl()),
  );

  //blocs
  sl.registerFactory<AuthBloc>(() => AuthBloc(sl()));
  sl.registerFactory<BottomNavbarBloc>(() => BottomNavbarBloc());
  sl.registerFactory<CashRegisterBloc>(() => CashRegisterBloc(sl()));
  sl.registerFactory<CashRegisterFormBloc>(() => CashRegisterFormBloc(sl()));
  sl.registerFactory<CashierBloc>(() => CashierBloc(sl()));
  sl.registerFactory<LoginFormBloc>(() => LoginFormBloc(sl(), sl()));
  sl.registerFactory<PaymentsBloc>(() => PaymentsBloc(sl()));
  sl.registerFactory<ProductsBloc>(() => ProductsBloc(sl()));
  sl.registerFactory<ReceiptBloc>(() => ReceiptBloc(sl(), sl(), sl()));
  sl.registerFactory<ReceiptDeliveryBloc>(() => ReceiptDeliveryBloc(sl()));
  sl.registerFactory<ReceiptsHistoryBloc>(() => ReceiptsHistoryBloc(sl()));
  sl.registerFactory<ShiftBloc>(() => ShiftBloc(sl()));

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
