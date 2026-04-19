import 'package:flutter_riverpod/flutter_riverpod.dart';

//here create riverpod provider and noitifier
final onboardingProvider = NotifierProvider<OnboardingNotifier, bool>(() {
  return OnboardingNotifier();
});

class OnboardingNotifier extends Notifier<bool> {
  @override
  //set the initial state
  //here user does not see the onboarding screen
  bool build() => false;
//updates the user to completed onboard
  void completeOnboarding() {
    state = true;
  }
}
