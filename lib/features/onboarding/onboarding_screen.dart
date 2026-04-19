import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:widgethub/core/routing/onboarding_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
//instead of writing ui three times manually it just store data in a list and build ui dynamically
  final List<Map<String, String>> _onboardingData = [
    {
      'title': 'Welcome this is  WidgetHub',
      'description': 'Your ultimate productivity .',
      'icon': 'widgets',
    },
    {
      'title': 'Learn Flutter',
      'description': 'Explore various widgets in action across all platforms.',
      'icon': 'school',
    },
    {
      'title': 'Boost Productivity',
      'description': 'Manage tasks, view FAQs, and consume APIs seamlessly.',
      'icon': 'rocket_launch',
    },
  ];
//converts string to icon
  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'widgets':
        return Icons.widgets;
      case 'school':
        return Icons.school;
      case 'rocket_launch':
        return Icons.rocket_launch;
      default:
        return Icons.star;
    }
  }
//after user completeonboarding goes to dashboard
  void _completeOnboarding() {
    ref.read(onboardingProvider.notifier).completeOnboarding();
    context.go('/dashboard');
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _completeOnboarding,
                child: const Text('Skip'),
              ),
            ),
            Expanded(
              //pageview is a horizaontally scroallble screen
              //pagecontroller controls the scrollable like go to next page or go to specfuc page with animations
              //pageview.builder create the pages manually
              child: PageView.builder(
                controller: _pageController,
                //it is a callback function it runs every time the page chnages
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                //totalnumber of pages
                itemCount: _onboardingData.length,
                //build each page it runs 3 times
                itemBuilder: (context, index) {
                  //get the current page data
                  final data = _onboardingData[index];
                  return Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _getIconData(data['icon']!),
                          size: 120,
                          color: theme.colorScheme.primary,
                        ),
                        const SizedBox(height: 40),
                        Text(
                          data['title']!,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.headlineMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          data['description']!,
                          textAlign: TextAlign.center,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              //dot indicator at the bottom section and next ,getstarted button
              child: Row(
                //it creates left side dot and right side buttons give speace between them
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    //it creates multiple dorts automaticallyy
                    children: List.generate(
                      //no of dots equals to the number of pages
                      _onboardingData.length,
                      //callback funtion runs automtaically when value chnages
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentPage == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? theme.colorScheme.primary
                              : theme.colorScheme.primary.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_currentPage == _onboardingData.length - 1) {
                        _completeOnboarding();
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                    ),
                    child: Text(
                      _currentPage == _onboardingData.length - 1
                          ? 'Get Started'
                          : 'Next',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
