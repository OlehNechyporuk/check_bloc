import 'package:check_bloc/config/main_navigation_name.dart';
import 'package:check_bloc/presentation/pages/cash_register_page.dart';
import 'package:check_bloc/presentation/pages/home/home_page.dart';
import 'package:check_bloc/presentation/pages/login_page.dart';
import 'package:check_bloc/presentation/pages/receipt/receipt_add_page.dart';
import 'package:check_bloc/presentation/pages/receipt/receipt_history_page.dart';
import 'package:check_bloc/presentation/pages/receipt/receupt_success_page.dart';
import 'package:check_bloc/presentation/pages/splash_page.dart';
import 'package:go_router/go_router.dart';

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
          path: 'success_add_receipt',
          name: MainNavigationName.receiptSuccessAddPage,
          builder: (context, state) => const ReceiptSuccessPage(),
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
