import 'dart:math';

import 'package:check_bloc/config/main_navigation_name.dart';
import 'package:check_bloc/data/checkbox/data_provider/auth_api_provider.dart';
import 'package:check_bloc/data/checkbox/data_provider/cash_register_api_data_provider.dart';
import 'package:check_bloc/data/checkbox/data_provider/cashier_api_data_provider.dart';
import 'package:check_bloc/data/checkbox/data_provider/db_shared_preferences.dart';
import 'package:check_bloc/data/checkbox/data_provider/product_api_provider.dart';
import 'package:check_bloc/data/checkbox/data_provider/receipt_api_provider.dart';
import 'package:check_bloc/data/checkbox/data_provider/session_data_provider.dart';
import 'package:check_bloc/data/checkbox/data_provider/shift_api_data_provider.dart';
import 'package:check_bloc/data/checkbox/repository/auth_repository_impl.dart';
import 'package:check_bloc/data/checkbox/repository/cash_register_repository_impl.dart';
import 'package:check_bloc/data/checkbox/repository/cashier_repositpry_impl.dart';
import 'package:check_bloc/data/checkbox/repository/payment_repository_impl.dart';
import 'package:check_bloc/data/checkbox/repository/product_repository_impl.dart';
import 'package:check_bloc/data/checkbox/repository/receipt_repository_impl.dart';
import 'package:check_bloc/data/checkbox/repository/shift_repository_impl.dart';
import 'package:check_bloc/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:check_bloc/presentation/blocs/bottom_nav_bloc/bottom_navbar_bloc.dart';
import 'package:check_bloc/presentation/blocs/cash_register_bloc/cash_register_bloc.dart';
import 'package:check_bloc/presentation/blocs/cash_register_form_bloc/cash_register_form_bloc.dart';
import 'package:check_bloc/presentation/blocs/cashier_bloc/cashier_bloc.dart';
import 'package:check_bloc/presentation/blocs/login_form_bloc/login_form_bloc.dart';
import 'package:check_bloc/config/router.dart';
import 'package:check_bloc/presentation/blocs/my_bloc_observer.dart';
import 'package:check_bloc/presentation/blocs/payments_bloc/payments_bloc.dart';
import 'package:check_bloc/presentation/blocs/products_bloc/products_bloc.dart';
import 'package:check_bloc/presentation/blocs/receipt_bloc/receipt_bloc.dart';
import 'package:check_bloc/presentation/blocs/receipts_bloc/receipts_bloc.dart';
import 'package:check_bloc/presentation/blocs/shift_bloc/shift_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'package:intl/intl.dart';

void main() {
  initializeDateFormatting('uk', null);
  Bloc.observer = MyGlobalObserver();
  const app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const sessionStorage = SessionDataProvider();
  static final dbSharedPreferences = DbSharedPreferences();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => const AuthRepositoryImpl(
            sessionStorage,
            AuthApiProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => const ProductRepositoryImpl(
            sessionStorage,
            ProductApiDataProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => const CashierRepositoryImpl(
            sessionStorage,
            CashierApiDataProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => const CashRegisterRepositoryImpl(
            sessionStorage,
            CashRegisterApiDataProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => const ShiftRepositoryImpl(
            sessionStorage,
            ShiftApiDataProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => PaymentRepositoryImpl(dbSharedPreferences),
        ),
        RepositoryProvider(
          create: (context) => const ReceiptRepositoryImpl(
            sessionStorage,
            ReceiptApiProvider(),
          ),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(
              RepositoryProvider.of<AuthRepositoryImpl>(context),
            )..add(AutCheckEvent()),
          ),
          BlocProvider<BottomNavbarBloc>(
            create: (context) => BottomNavbarBloc(),
          ),
          BlocProvider<LoginFormBloc>(
            create: (context) => LoginFormBloc(
              BlocProvider.of<AuthBloc>(context),
              RepositoryProvider.of<AuthRepositoryImpl>(context),
            ),
          ),
          BlocProvider<ProductsBloc>(
            create: (context) => ProductsBloc(
              RepositoryProvider.of<ProductRepositoryImpl>(context),
            ),
          ),
          BlocProvider<CashierBloc>(
            create: (context) => CashierBloc(
              RepositoryProvider.of<CashierRepositoryImpl>(context),
            ),
          ),
          BlocProvider<CashRegisterBloc>(
            create: (context) => CashRegisterBloc(
              RepositoryProvider.of<CashRegisterRepositoryImpl>(context),
            )..add(CashRegisterLoadEvent()),
          ),
          BlocProvider<CashRegisterFormBloc>(
            create: (context) => CashRegisterFormBloc(
              RepositoryProvider.of<CashRegisterRepositoryImpl>(context),
            )..add(CashRegisterFormLoadEvent()),
          ),
          BlocProvider<ShiftBloc>(
            create: (context) => ShiftBloc(
              RepositoryProvider.of<ShiftRepositoryImpl>(context),
            )..add(ShiftInitialEvent()),
          ),
          BlocProvider<ReceiptBloc>(
            create: (context) => ReceiptBloc(
              RepositoryProvider.of<ReceiptRepositoryImpl>(context),
            )..add(ReceiptInitialEvent()),
          ),
          BlocProvider(
            create: (context) => PaymentsBloc(
              RepositoryProvider.of<PaymentRepositoryImpl>(context),
            )..add(PaymentsLoadedEvent()),
          ),
          BlocProvider<ReceiptsBloc>(
            create: (context) => ReceiptsBloc(
              RepositoryProvider.of<ReceiptRepositoryImpl>(context),
            ),
          ),
        ],
        child: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              router.pushReplacementNamed(MainNavigationName.homePage);
            } else {
              router.goNamed(MainNavigationName.loginPage);
            }
          },
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                color: Colors.white,
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.black),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

extension DoubleExt on double {
  String toUAH() {
    return NumberFormat.simpleCurrency(
      name: '',
    ).format((this / 100));
  }
}

extension DoubleRoundedExt on double {
  String toRoundedUAH() {
    num mod = pow(10.0, 1);
    return NumberFormat.simpleCurrency(
      name: '',
    ).format((((this / 100) * mod).round().toDouble() / mod));
  }
}

extension DateUkraine on DateTime {
  String toLocalTime() {
    var formatter = DateFormat.yMd('uk').add_Hms();
    return formatter.format(toLocal());
  }
}