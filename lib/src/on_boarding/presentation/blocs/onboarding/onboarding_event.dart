abstract class OnboardingEvent {}

class OnNextPage extends OnboardingEvent {
  final int currentIndex;

  OnNextPage(this.currentIndex);
}

class OnCompleteOnboarding extends OnboardingEvent {}
