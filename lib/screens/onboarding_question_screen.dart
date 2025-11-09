import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/onboarding_provider.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/wavy_progress_bar.dart';
import '../widgets/wave_background.dart';
import '../widgets/media_recorder_widget.dart';
import '../models/onboarding_state.dart';

class OnboardingQuestionScreen extends ConsumerStatefulWidget {
  const OnboardingQuestionScreen({super.key});

  @override
  ConsumerState<OnboardingQuestionScreen> createState() => _OnboardingQuestionScreenState();
}

class _OnboardingQuestionScreenState extends ConsumerState<OnboardingQuestionScreen> 
    with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _textFocusNode = FocusNode();
  final TextEditingController _textController = TextEditingController();
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setupKeyboardListeners();
    _initializeText();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    _textFocusNode.dispose();
    _textController.dispose();
    super.dispose();
  }

  void _initializeText() {
    final questionAnswer = ref.read(onboardingProvider).questionAnswer;
    _textController.text = questionAnswer;
  }

  void _setupKeyboardListeners() {
    _textFocusNode.addListener(() {
      if (_textFocusNode.hasFocus && _isKeyboardVisible) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        });
      }
    });
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    setState(() {
      _isKeyboardVisible = bottomInset > 0;
    });
  }

  void _onTextChanged(String text) {
    ref.read(onboardingProvider.notifier).updateQuestionAnswer(text);
  }

  void _onNextPressed() {
    final state = ref.read(onboardingProvider);
    
    // Log the current state
    print('Question Answer: ${state.questionAnswer}');
    print('Audio Path: ${state.audioPath}');
    print('Video Path: ${state.videoPath}');
    
    // Navigate to next screen or submit
    // Navigator.push(...);
  }

  double _getTextFieldHeight() {
    final state = ref.read(onboardingProvider);
    final hasMedia = state.audioPath != null || state.videoPath != null;
    
    if (_isKeyboardVisible) {
      return hasMedia ? 120 : 180;
    }
    return hasMedia ? 160 : 250;
  }

  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingProvider);
    final hasMedia = onboardingState.audioPath != null || onboardingState.videoPath != null;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Background with waves
          const WaveBackground(),
          
          // Content
          _buildContent(onboardingState, hasMedia),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.effectBgBlur80,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 20),
        color: AppColors.text1,
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.close, size: 24),
          color: AppColors.text1,
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
      title: const WavyProgressBar(progress: 0.66),
      centerTitle: true,
    );
  }

  Widget _buildContent(OnboardingState onboardingState, bool hasMedia) {
    return SingleChildScrollView(
      controller: _scrollController,
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top spacing (reduces when keyboard is visible)
          SizedBox(height: _isKeyboardVisible ? 40 : 120),
          
          // Header section
          _buildHeaderSection(),
          
          const SizedBox(height: 24),
          
          // Description text field
          _buildQuestionField(onboardingState),
          
          const SizedBox(height: 16),
          
          // Media recorders section
          if (!_isKeyboardVisible) _buildMediaRecordersSection(onboardingState),
          
          const SizedBox(height: 24),
          
          // Next button
          _buildNextButtonSection(onboardingState, hasMedia),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Step number
          Text(
            '02',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.text4,
              letterSpacing: 1.2,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Title
          Text(
            'Why do you want to host with us?',
            style: AppTextStyles.heading1.copyWith(
              color: AppColors.text1,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Subtitle
          Text(
            'Tell us about your intent and what motivates you to create experiences.',
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.text3,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionField(OnboardingState onboardingState) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: _getTextFieldHeight(),
            decoration: BoxDecoration(
              color: AppColors.surfaceWhite2,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: _textFocusNode.hasFocus 
                    ? AppColors.primaryAccent 
                    : AppColors.border1,
                width: 1.5,
              ),
            ),
            child: TextField(
              controller: _textController,
              focusNode: _textFocusNode,
              maxLines: null,
              maxLength: 600,
              style: AppTextStyles.bodyText.copyWith(color: AppColors.text2),
              decoration: InputDecoration(
                hintText: '/ Start typing here',
                hintStyle: AppTextStyles.bodyText.copyWith(color: AppColors.text3),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
                counterStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.text4),
              ),
              onChanged: _onTextChanged,
              cursorColor: AppColors.primaryAccent,
            ),
          ),
          
          // Character count
          if (!_isKeyboardVisible) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                '${onboardingState.questionAnswer.length}/600',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.text4),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // In the _buildMediaRecordersSection method, update the onDelete callbacks:

Widget _buildMediaRecordersSection(OnboardingState onboardingState) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 24),
    child: Column(
      children: [
        // Audio Recorder
        if (onboardingState.audioPath == null) 
          MediaRecorderWidget.audio(
            onRecordingComplete: (String audioPath) {
              ref.read(onboardingProvider.notifier).setAudioPath(audioPath);
            },
            onDelete: () {
              ref.read(onboardingProvider.notifier).setAudioPath(null); // This should work now
            },
          ),
        
        if (onboardingState.audioPath == null && onboardingState.videoPath == null) 
          const SizedBox(height: 12),
        
        // Video Recorder
        if (onboardingState.videoPath == null)
          MediaRecorderWidget.video(
            onRecordingComplete: (String videoPath) {
              ref.read(onboardingProvider.notifier).setVideoPath(videoPath);
            },
            onDelete: () {
              ref.read(onboardingProvider.notifier).setVideoPath(null); // This should work now
            },
          ),
      ],
    ),
  );
}

  Widget _buildNextButtonSection(OnboardingState onboardingState, bool hasMedia) {
    final hasText = onboardingState.questionAnswer.trim().isNotEmpty;
    final canProceed = hasText || hasMedia;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: _calculateButtonWidth(hasMedia),
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: canProceed 
                  ? const LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryAccent],
                    )
                  : null,
              border: Border.all(
                color: canProceed ? AppColors.border3 : AppColors.border1,
                width: 1.5,
              ),
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(12),
              onTap: canProceed ? _onNextPressed : null,
              child: Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Next',
                      style: AppTextStyles.buttonLarge.copyWith(
                        color: canProceed ? AppColors.text1 : AppColors.text3,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 20,
                      color: canProceed ? AppColors.text1 : AppColors.text3,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  double _calculateButtonWidth(bool hasMedia) {
    if (_isKeyboardVisible) {
      return double.infinity;
    }
    
    final state = ref.read(onboardingProvider);
    final showBothMediaButtons = state.audioPath == null && state.videoPath == null;
    
    if (showBothMediaButtons) {
      return MediaQuery.of(context).size.width * 0.5;
    } else if (state.audioPath == null || state.videoPath == null) {
      return MediaQuery.of(context).size.width * 0.65;
    } else {
      return double.infinity;
    }
  }
}