
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/experiences_provider.dart'; // Updated import
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import '../widgets/experience_card.dart';
import '../widgets/wavy_progress_bar.dart';
import '../widgets/wave_background.dart';
import 'onboarding_question_screen.dart';
import '../models/experience_model.dart';

class ExperienceSelectionScreen extends ConsumerStatefulWidget {
  const ExperienceSelectionScreen({super.key});

  @override
  ConsumerState<ExperienceSelectionScreen> createState() => _ExperienceSelectionScreenState();
}

class _ExperienceSelectionScreenState extends ConsumerState<ExperienceSelectionScreen> 
    with WidgetsBindingObserver {
  final ScrollController _scrollController = ScrollController();
  final FocusNode _textFocusNode = FocusNode();
  bool _isKeyboardVisible = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setupKeyboardListeners();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.dispose();
    _textFocusNode.dispose();
    super.dispose();
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

  void _onExperienceTap(int experienceId) {
    final currentIds = ref.read(selectedExperienceIdsProvider);
    final updatedIds = List<int>.from(currentIds);
    
    if (updatedIds.contains(experienceId)) {
      updatedIds.remove(experienceId);
    } else {
      updatedIds.add(experienceId);
    }
    
    ref.read(selectedExperienceIdsProvider.notifier).state = updatedIds;
  }

  void _onNextPressed() {
    final selectedIds = ref.read(selectedExperienceIdsProvider);
    final experienceText = ref.read(experienceTextProvider);
    
    // Log the current state
    print('Selected Experiences: $selectedIds');
    print('Experience Text: $experienceText');
    
    // Navigate to next screen
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => const OnboardingQuestionScreen(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 400),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final experiencesAsync = ref.watch(experiencesProvider);
    final selectedIds = ref.watch(selectedExperienceIdsProvider);
    final experienceText = ref.watch(experienceTextProvider);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Background with waves
          const WaveBackground(),
          
          // Content
          _buildContent(experiencesAsync, selectedIds, experienceText),
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
      title: const WavyProgressBar(progress: 0.33),
      centerTitle: true,
    );
  }

  Widget _buildContent(AsyncValue<List<Experience>> experiencesAsync, List<int> selectedIds, String experienceText) {
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
          
          // Step indicator and title section
          _buildHeaderSection(),
          
          const SizedBox(height: 24),
          
          // Experiences horizontal list
          _buildExperiencesList(experiencesAsync, selectedIds),
          
          const SizedBox(height: 32),
          
          // Description text field
          _buildDescriptionField(experienceText),
          
          const SizedBox(height: 24),
          
          // Next button
          _buildNextButton(selectedIds),
          
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
            '01',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.text4,
              letterSpacing: 1.2,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Title
          Text(
            'What kind of hotspots do you want to host?',
            style: AppTextStyles.heading1.copyWith(
              color: AppColors.text1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperiencesList(AsyncValue<List<Experience>> experiencesAsync, List<int> selectedIds) {
    return SizedBox(
      height: 160,
      child: experiencesAsync.when(
        data: (experiences) => ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 24, right: 16),
          itemCount: experiences.length,
          itemBuilder: (context, index) {
            final experience = experiences[index];
            final isSelected = selectedIds.contains(experience.id);
            
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: ExperienceCard(
                experience: experience,
                isSelected: isSelected,
                onTap: () => _onExperienceTap(experience.id),
              ),
            );
          },
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'Failed to load experiences',
            style: AppTextStyles.bodyText.copyWith(color: AppColors.text3),
          ),
        ),
      ),
    );
  }

  Widget _buildDescriptionField(String experienceText) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: _isKeyboardVisible ? 120 : 140,
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
              focusNode: _textFocusNode,
              maxLines: null,
              maxLength: 250,
              style: AppTextStyles.bodyText.copyWith(color: AppColors.text2),
              decoration: InputDecoration(
                hintText: '/ Describe your perfect hotspot',
                hintStyle: AppTextStyles.bodyText.copyWith(color: AppColors.text3),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
                counterStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.text4),
              ),
              onChanged: (value) => ref.read(experienceTextProvider.notifier).state = value,
              cursorColor: AppColors.primaryAccent,
            ),
          ),
          
          // Character count
          if (!_isKeyboardVisible) ...[
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.only(left: 4),
              child: Text(
                '${experienceText.length}/250',
                style: AppTextStyles.bodySmall.copyWith(color: AppColors.text4),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildNextButton(List<int> selectedIds) {
    final hasSelection = selectedIds.isNotEmpty;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: hasSelection 
              ? const LinearGradient(
                  colors: [AppColors.primary, AppColors.primaryAccent],
                )
              : null,
          border: Border.all(
            color: hasSelection ? AppColors.border3 : AppColors.border1,
            width: 1.5,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: hasSelection ? _onNextPressed : null,
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Next',
                    style: AppTextStyles.buttonLarge.copyWith(
                      color: hasSelection ? AppColors.text1 : AppColors.text3,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 20,
                    color: hasSelection ? AppColors.text1 : AppColors.text3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}