
import '../models/experience_model.dart';

class OnboardingState {
  final List<Experience> experiences;
  final List<int> selectedExperienceIds;
  final String experienceText;
  final String questionAnswer;
  final String? audioPath;
  final String? videoPath;
  final bool isLoading;

  OnboardingState({
    this.experiences = const [],
    this.selectedExperienceIds = const [],
    this.experienceText = '',
    this.questionAnswer = '',
    this.audioPath,
    this.videoPath,
    this.isLoading = false,
  });

  OnboardingState copyWith({
    List<Experience>? experiences,
    List<int>? selectedExperienceIds,
    String? experienceText,
    String? questionAnswer,
    String? audioPath,
    String? videoPath,
    bool? isLoading,
  }) {
    return OnboardingState(
      experiences: experiences ?? this.experiences,
      selectedExperienceIds: selectedExperienceIds ?? this.selectedExperienceIds,
      experienceText: experienceText ?? this.experienceText,
      questionAnswer: questionAnswer ?? this.questionAnswer,
      audioPath: audioPath ?? this.audioPath,
      videoPath: videoPath ?? this.videoPath,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}