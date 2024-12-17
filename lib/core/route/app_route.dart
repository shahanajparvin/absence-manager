import 'package:absence_manager/presentation/feature/absence/ui/pages/absence_detail_page.dart';
import 'package:absence_manager/presentation/feature/absence/ui/pages/absence_list_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';


enum AppRoutes {
  absenceDetail
}


final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) => const AbsenceListPage(),
    ),

    GoRoute(
        path: '/absenceDetail',
        name: AppRoutes.absenceDetail.name,
        builder: (BuildContext context, GoRouterState state) {
          return AbsenceDetailPage(
             absenceId: state.extra! as int,
          );
        }),
  ],
);