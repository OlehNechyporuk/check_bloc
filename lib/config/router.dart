import 'package:go_router/go_router.dart';

import 'package:check_bloc/config/main_navigation_name.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/cash_register_page.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/home/home_page.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/login_page.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/receipt/receipt_add_page.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/receipt/receipt_history_page.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/splash_page.dart';

final router = GoRouter(
  debugLogDiagnostics: false,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: MainNavigationName.splashPage,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/login',
      name: MainNavigationName.loginPage,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/home',
      name: MainNavigationName.homePage,
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'cash_register',
          name: MainNavigationName.cashRegisterPage,
          builder: (context, state) => const CashRegisterPage(),
        ),
        GoRoute(
          path: 'receipt_add_page',
          name: MainNavigationName.receiptAddPage,
          builder: (context, state) => const ReceiptAddPage(),
        ),
        GoRoute(
          path: 'receipt_history_page',
          name: MainNavigationName.receiptHistoryPage,
          builder: (context, state) => const ReceiptHistoryPage(),
        ),
      ],
    ),
  ],
);
