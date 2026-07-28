import 'package:go_router/go_router.dart';
import 'package:prod_pin/src/features/index.dart';

import 'app_routes.dart';

final appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: AppRoutes.addCategory,
      builder: (context, state) => const AddCategoryScreen(),
    ),
    GoRoute(
      path: AppRoutes.editCategory,
      builder: (context, state) => EditCategoryScreen(
        category: state.extra as Category,
      ),
    ),
    GoRoute(
      path: AppRoutes.categoryDetail,
      builder: (context, state) => PinsScreen(
        category: state.extra as Category,
      ),
    ),
    GoRoute(
      path: AppRoutes.addPin,
      builder: (context, state) => AddPinScreen(
        category: state.extra as Category,
      ),
    ),
    GoRoute(
      path: AppRoutes.pinDetail,
      builder: (context, state) =>
          PinDetailScreen(id: state.pathParameters['id']!),
    ),
    GoRoute(
      path: AppRoutes.editPin,
      builder: (context, state) =>
          EditPinScreen(id: state.pathParameters['id']!),
    ),
  ],
);
