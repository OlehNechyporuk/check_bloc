import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'package:check_bloc/config/constants.dart';
import 'package:check_bloc/config/main_navigation_name.dart';
import 'package:check_bloc/config/router.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/auth_bloc/auth_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/bottom_nav_bloc/bottom_navbar_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/cash_register_bloc/cash_register_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/cash_register_form_bloc/cash_register_form_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/cashier_bloc/cashier_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/login_form_bloc/login_form_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/my_bloc_observer.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/payments_bloc/payments_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/products_bloc/products_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/receipt_bloc/receipt_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/receipt_delivery_bloc/receipt_delivery_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/receipts_history_bloc/receipts_history_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/shift_bloc/shift_bloc.dart';
import 'package:check_bloc/features/crm/presentation/blocs/auth_crm_bloc/auth_crm_bloc.dart';
import 'package:check_bloc/injector.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Intl.defaultLocale = 'uk';
  Bloc.observer = MyGlobalObserver();
  await initializeDI();
  const app = MyApp();
  runApp(app);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //cash_register/features
        BlocProvider<AuthBloc>(
          create: (context) => sl()..add(AutCheckEvent()),
        ),
        BlocProvider<BottomNavbarBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<LoginFormBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<ProductsBloc>(
          create: (context) => sl()..add(ProductsLoadedEvent()),
        ),
        BlocProvider<CashierBloc>(
          create: (context) => sl()..add(CashierLoadEvent()),
        ),
        BlocProvider<CashRegisterBloc>(
          create: (context) => sl()..add(CashRegisterLoadEvent()),
        ),
        BlocProvider<CashRegisterFormBloc>(
          create: (context) => sl()..add(CashRegisterFormLoadEvent()),
        ),
        BlocProvider<ShiftBloc>(
          create: (context) => sl()..add(ShiftInitialEvent()),
        ),
        BlocProvider<ReceiptBloc>(
          create: (context) => sl()..add(ReceiptInitialEvent()),
        ),
        BlocProvider<PaymentsBloc>(
          create: (context) => sl()..add(PaymentsLoadedEvent()),
        ),
        BlocProvider<ReceiptsHistoryBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<ReceiptDeliveryBloc>(
          create: (context) => sl(),
        ),

        //crm
        BlocProvider<AuthCrmBloc>(
          create: (context) => sl()..add(AuthCrmCheckEvent()),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthCrmBloc, AuthCrmState>(
            listener: (context, state) {
              if (state.status == BlocStateStatus.success) {
                router
                    .pushReplacementNamed(CashRegisterNavigationName.homePage);
              } else {
                router.goNamed(MainNavigationName.authCrm);
              }
            },
          ),
          // BlocListener<AuthBloc, AuthState>(
          //   listener: (context, state) {
          //     if (state is AuthSuccess) {
          //       router
          //           .pushReplacementNamed(CashRegisterNavigationName.homePage);
          //     } else {
          //       router.goNamed(CashRegisterNavigationName.loginPage);
          //     }
          //   },
          // ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          title: '//${AppLocalizations.of(context)?.appTitle}',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              color: Colors.white,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
            ),
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('uk', ''),
          ],
        ),
      ),
    );
  }
}
