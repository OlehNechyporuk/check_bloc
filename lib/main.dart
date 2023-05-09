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
import 'package:check_bloc/features/cash_register/presentation/blocs/modal_report_bloc/modal_report_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/modal_x_report_bloc/modal_x_report_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/my_bloc_observer.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/payments_bloc/payments_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/products_bloc/products_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/receipt_bloc/receipt_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/receipt_delivery_bloc/receipt_delivery_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/receipts_history_bloc/receipts_history_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/shift_bloc/shift_bloc.dart';
import 'package:check_bloc/features/cash_register/presentation/blocs/shifts_history_bloc/shifts_history_bloc.dart';
import 'package:check_bloc/features/crm/presentation/blocs/add_cash_register_crm_bloc/add_cash_register_crm_bloc.dart';
import 'package:check_bloc/features/crm/presentation/blocs/auth_crm_bloc/auth_crm_bloc.dart';
import 'package:check_bloc/features/crm/presentation/blocs/cash_register_crm_bloc/cash_register_crm_bloc.dart';
import 'package:check_bloc/features/crm/presentation/blocs/user_crm_bloc/user_crm_bloc.dart';
import 'package:check_bloc/injector.dart';
import 'package:check_bloc/theme/theme_constants.dart';

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
          create: (context) => sl(),
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
        BlocProvider<ShiftsHistoryBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<ModalReportBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<ModalXReportBloc>(
          create: (context) => sl(),
        ),

        //crm
        BlocProvider<AuthCrmBloc>(
          create: (context) => sl()..add(AuthCrmCheckEvent()),
        ),
        BlocProvider<UserCrmBloc>(
          create: (context) => sl()..add(UserCrmLoadedEvent()),
        ),
        BlocProvider<CashRegisterCrmBloc>(
          create: (context) => sl()..add(CashRegisterCrmLoadedListEvent()),
        ),
        BlocProvider<AddCashRegisterCrmBloc>(
          create: (context) => sl(),
        ),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AuthCrmBloc, AuthCrmState>(
            listener: (context, state) {
              if (state.status == BlocStateStatus.success) {
                router.pushReplacementNamed(MainNavigationName.dashboarCrm);
              } else {
                router.goNamed(MainNavigationName.authCrm);
              }
            },
          ),
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: router,
          title: '${AppLocalizations.of(context)?.appTitle}',
          theme: lightTheme,
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
