import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:widgethub/core/responsive/responsive_shell.dart';

//this file decides the responsives shell
class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    //GoRouterState.of(context).uri.path gives the current path
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/tasks')) return 1;
    if (location.startsWith('/faq')) return 2;
    if (location.startsWith('/api')) return 3;
    if (location.startsWith('/settings')) return 4;
    return 0;//dashboard
  }
  //if user taps the index it will navigate to that page

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/dashboard');
        break;
      case 1:
        context.go('/tasks');
        break;
      case 2:
        context.go('/faq');
        break;
      case 3:
        context.go('/api');
        break;
      case 4:
        context.go('/settings');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _calculateSelectedIndex(context);


    return ResponsiveShell(
      mobile: Scaffold(
        body: child,
        bottomNavigationBar: NavigationBar(
          selectedIndex: currentIndex,
          onDestinationSelected: (index) => _onItemTapped(index, context),
          destinations: const [
            NavigationDestination(icon: Icon(Icons.dashboard), label: 'Home'),
            NavigationDestination(icon: Icon(Icons.check_box), label: 'Tasks'),
            NavigationDestination(icon: Icon(Icons.question_answer), label: 'FAQ'),
            NavigationDestination(icon: Icon(Icons.api), label: 'API'),
            NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
          ],
        ),
      ),
      tablet: Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: currentIndex,
              onDestinationSelected: (index) => _onItemTapped(index, context),
              labelType: NavigationRailLabelType.all,
              destinations: const [
                NavigationRailDestination(icon: Icon(Icons.dashboard), label: Text('Home')),
                NavigationRailDestination(icon: Icon(Icons.check_box), label: Text('Tasks')),
                NavigationRailDestination(icon: Icon(Icons.question_answer), label: Text('FAQ')),
                NavigationRailDestination(icon: Icon(Icons.api), label: Text('API')),
                NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: child),
          ],
        ),
      ),
      desktop: Scaffold(
        body: Row(
          children: [
            NavigationRail(
              extended: true,
              selectedIndex: currentIndex,
              onDestinationSelected: (index) => _onItemTapped(index, context),
              destinations: const [
                NavigationRailDestination(icon: Icon(Icons.dashboard), label: Text('Home')),
                NavigationRailDestination(icon: Icon(Icons.check_box), label: Text('Tasks')),
                NavigationRailDestination(icon: Icon(Icons.question_answer), label: Text('FAQ')),
                NavigationRailDestination(icon: Icon(Icons.api), label: Text('API')),
                NavigationRailDestination(icon: Icon(Icons.settings), label: Text('Settings')),
              ],
            ),
            const VerticalDivider(thickness: 1, width: 1),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}
