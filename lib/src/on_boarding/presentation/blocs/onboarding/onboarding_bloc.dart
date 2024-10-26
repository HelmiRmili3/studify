import 'package:flutter_bloc/flutter_bloc.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final int totalPages;

  OnboardingBloc(this.totalPages) : super(OnboardingInitial(0)) {
    on<OnNextPage>((event, emit) {
      emit(OnboardingInitial(event.currentIndex));
    });

    on<OnCompleteOnboarding>((event, emit) {
      emit(OnboardingInitial(totalPages - 1));
    });
  }
}
