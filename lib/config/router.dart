import 'package:check_bloc/features/cash_register/presentation/pages/reports/reports_history_page.dart';
import 'package:go_router/go_router.dart';

import 'package:check_bloc/config/main_navigation_name.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/cash_register_page.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/home/home_page.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/login_page.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/receipt/receipt_add_page.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/receipt/receipt_history_page.dart';
import 'package:check_bloc/features/cash_register/presentation/pages/splash_page_cash_register.dart';
import 'package:check_bloc/features/crm/presentation/pages/cash_register/add_cash_register_page.dart';
import 'package:check_bloc/features/crm/presentation/pages/dashboard/dashboard_page.dart';
import 'package:check_bloc/features/crm/presentation/pages/login_page_crm.dart';
import 'package:check_bloc/features/splash_page.dart';

final router = GoRouter(
  debugLogDiagnostics: false,
  initialLocation: '/',
  routes: [
    //cash register
    GoRoute(
      path: '/splash_page_cash_register:type&:title&:cash_register&:crm_title',
      name: CashRegisterNavigationName.splashPageCashRegister,
      builder: (context, state) => SplashPageCashRegister(
        type: state.params['type'],
        title: state.params['title'],
        cashRegisterId: state.params['cash_register'],
        crmRegisterTitle: state.params['crm_title'],
      ),
    ),

    GoRoute(
      path: '/home',
      name: CashRegisterNavigationName.homePage,
      builder: (context, state) => const HomePage(),
      routes: [
        GoRoute(
          path: 'cash_register',
          name: CashRegisterNavigationName.cashRegisterPage,
          builder: (context, state) => const CashRegisterPage(),
        ),
        GoRoute(
          path: 'receipt_add_page',
          name: CashRegisterNavigationName.receiptAddPage,
          builder: (context, state) => const ReceiptAddPage(),
        ),
        GoRoute(
          path: 'receipt_history_page',
          name: CashRegisterNavigationName.receiptHistoryPage,
          builder: (context, state) => const ReceiptHistoryPage(),
        ),
        GoRoute(
          path: 'reports_history_page',
          name: CashRegisterNavigationName.reportsHistoryPage,
          builder: (context, state) => const ReportsHistoryPage(),
        ),
      ],
    ),
    //crm
    GoRoute(
      path: '/',
      name: MainNavigationName.splashPage,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/crm_auth_login',
      name: MainNavigationName.authCrm,
      builder: (context, state) => const LoginPageCrm(),
    ),
    GoRoute(
      path: '/dashboard_crm',
      name: MainNavigationName.dashboarCrm,
      builder: (context, state) => const DashboardPage(),
      routes: [
        GoRoute(
          path: 'add_cash_register_crm',
          name: MainNavigationName.addCashRegisterCrm,
          builder: (context, state) => const AddCashRegisterPage(),
        ),
        GoRoute(
          path: 'login:type&:title&:cash_register&:crm_title',
          name: CashRegisterNavigationName.loginPage,
          builder: (context, state) => LoginPage(
            type: state.params['type'],
            title: state.params['title'],
            cashRegisterId: state.params['cash_register'] ?? '',
            crmRegisterTitle: state.params['crm_title'] ?? '',
          ),
        ),
      ],
    ),
  ],
);
