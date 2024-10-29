abstract class OnboardingState {
  final int currentPage;

  OnboardingState(this.currentPage);
}

class OnboardingInitial extends OnboardingState {
  OnboardingInitial(super.currentPage);
}
