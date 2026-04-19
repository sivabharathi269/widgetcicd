import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:widgethub/core/responsive/responsive_shell.dart';
import 'package:widgethub/features/tour/guided_tour_overlay.dart';

bool _hasSeenTourGlobally = false;

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  //create unique id for task
  final GlobalKey _tasksCardKey = GlobalKey();
  
  @override
  void initState() {
    super.initState();
    //WidgetsBinding is a flutter class that handles  ui frames and rendering
    //addPostFrameCallback is method that is called after the current frame is rendered
    //when flutter creates the widgets it creates the widgets in the mry than it draws on the screen
    //why we need to write this... before drwaing the  screen run _checkAndShowTour() too early:
    // Flutter can’t find the card
    // The overlay can’t position itself
    // The tour won’t appear correct
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndShowTour();
    });
  }

  void _checkAndShowTour() {
    //check if the user has seen the tour globally if not shown them
    if (!_hasSeenTourGlobally) {
      GuidedTourOverlay.showTour(
        context,
        targetKey: _tasksCardKey,
        //when the user closes the tour it will set the _hasSeenTourGlobally to true it is a paramter of GuidedTourOverlay
        onDismiss: () {
          _hasSeenTourGlobally = true;
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: LayoutBuilder(
        builder: (context, constraints) {
          int crossAxisCount = 2; // Mobile default
          if (ResponsiveShell.isDesktop(context) || ResponsiveShell.isTablet(context)) {
            crossAxisCount = 4;
          }
//generally gridview in vertical -main axis
          return GridView.count(
            //no of columns 4 columns per row
            crossAxisCount: crossAxisCount,
            padding: const EdgeInsets.all(16),
            //horixontal spacong
            mainAxisSpacing: 16,
            //vertical
            crossAxisSpacing: 16,
            children: [
              _buildCard(context, 'Tasks', Icons.check_box, '/tasks', Colors.blue, key: _tasksCardKey),
              _buildCard(context, 'FAQ', Icons.question_answer, '/faq', Colors.orange),
              _buildCard(context, 'API Demo', Icons.api, '/api', Colors.green),
              _buildCard(context, 'Settings', Icons.settings, '/settings', Colors.purple),
            ],
          );
        },
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, String route, Color color, {Key? key}) {
    return Card(
      key: key,
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      //cutts off the overflow and smooth the edges
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.go(route),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [color.withValues(alpha: 0.7), color],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 60, color: Colors.white),
              const SizedBox(height: 16),
              Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

