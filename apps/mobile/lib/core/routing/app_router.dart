import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/change_requests/presentation/change_requests_screen.dart';
import '../../features/change_requests/presentation/new_change_request_screen.dart';
import '../../features/projects/presentation/home_screen.dart';
import '../../features/projects/presentation/project_detail_screen.dart';
import '../../features/projects/presentation/projects_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import 'scaffold_with_nav_bar.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavBar(navigationShell: navigationShell);
      },
      branches: [
        // Tab 0: Inicio
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              name: 'home',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        // Tab 1: Proyectos
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/projects',
              name: 'projects',
              builder: (context, state) => const ProjectsScreen(),
              routes: [
                GoRoute(
                  path: ':projectId',
                  name: 'project-detail',
                  builder: (context, state) => ProjectDetailScreen(
                    projectId: state.pathParameters['projectId'] ?? '',
                  ),
                ),
              ],
            ),
          ],
        ),
        // Tab 2: Cambios
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/change-requests',
              name: 'change-requests',
              builder: (context, state) => const ChangeRequestsScreen(),
            ),
          ],
        ),
        // Tab 3: Perfil
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              name: 'profile',
              builder: (context, state) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
    // Full screen route for New Change Request
    GoRoute(
      path: '/change-requests/new',
      parentNavigatorKey: _rootNavigatorKey,
      name: 'new-change-request',
      builder: (context, state) => const NewChangeRequestScreen(),
    ),
  ],
);
