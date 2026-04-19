import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:widgethub/core/routing/main_shell.dart';
import 'package:widgethub/core/routing/onboarding_provider.dart';
import 'package:widgethub/features/api/api_detail_screen.dart';
import 'package:widgethub/features/api/api_screen.dart';
import 'package:widgethub/features/dashboard/dashboard_screen.dart';
import 'package:widgethub/features/faq/faq_screen.dart';
import 'package:widgethub/features/onboarding/onboarding_screen.dart';
import 'package:widgethub/features/settings/settings_screen.dart';
import 'package:widgethub/features/tasks/task_screen.dart';

//provider instance for go router
final routerProvider = Provider<GoRouter>((ref) {

  final hasCompletedOnboarding = ref.watch(onboardingProvider);
//it returns the obj of go router
  return GoRouter(
    initialLocation: hasCompletedOnboarding ? '/dashboard' : '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      

      GoRoute(
        path: '/dashboard',
        builder: (context, state) => const MainShell(child: DashboardScreen()),
      ),
      GoRoute(
        path: '/tasks',
        builder: (context, state) => const MainShell(child: TaskScreen()),
      ),
      GoRoute(
        path: '/faq',
        builder: (context, state) => const MainShell(child: FaqScreen()),
      ),
      GoRoute(
        path: '/api',
        builder: (context, state) => const MainShell(child: ApiScreen()),
        //nested routes
        routes: [
          GoRoute(
            path: 'detail',
            builder: (context, state) {
              //pass the data to the detail screen
              final post = state.extra as Map<String, dynamic>;
              return ApiDetailScreen(post: post);
            },
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const MainShell(child: SettingsScreen()),
      ),
    ],
  );
});
