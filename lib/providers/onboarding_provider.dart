
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/onboarding_state.dart';
import '../models/experience_model.dart';
import '../services/api_service.dart';

class OnboardingNotifier extends StateNotifier<OnboardingState> {
  final ApiService _apiService = ApiService();

  OnboardingNotifier() : super(OnboardingState()) {
    loadExperiences();
  }

  Future<void> loadExperiences() async {
    state = state.copyWith(isLoading: true);
    try {
      final experiences = await _apiService.fetchExperiences();
      state = state.copyWith(
        experiences: experiences,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
      // Handle error appropriately
    }
  }

  void toggleExperienceSelection(int experienceId) {
    final List<int> updatedSelection = List.from(state.selectedExperienceIds);
    
    if (updatedSelection.contains(experienceId)) {
      updatedSelection.remove(experienceId);
    } else {
      updatedSelection.add(experienceId);
    }
    
    state = state.copyWith(selectedExperienceIds: updatedSelection);
  }

  void updateExperienceText(String text) {
    state = state.copyWith(experienceText: text);
  }

  void updateQuestionAnswer(String answer) {
    state = state.copyWith(questionAnswer: answer);
  }

  // Change these to accept nullable String
  void setAudioPath(String? path) {
    state = state.copyWith(audioPath: path);
  }

  void setVideoPath(String? path) {
    state = state.copyWith(videoPath: path);
  }

  // You can remove these methods since setAudioPath/setVideoPath now accept null
  // void clearAudioPath() {
  //   state = state.copyWith(audioPath: null);
  // }

  // void clearVideoPath() {
  //   state = state.copyWith(videoPath: null);
  // }
}

final onboardingProvider = StateNotifierProvider<OnboardingNotifier, OnboardingState>(
  (ref) => OnboardingNotifier(),
);