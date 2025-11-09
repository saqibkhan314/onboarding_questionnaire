// import 'package:flutter/material.dart';
// import '../theme/app_colors.dart';
// import '../theme/app_text_styles.dart';

// class MediaRecorderWidget extends StatelessWidget {
//   final bool isAudio;
//   final VoidCallback onRecordingComplete;
//   final VoidCallback onDelete;
//   final bool isRecording;

//   const MediaRecorderWidget({
//     super.key,
//     required this.isAudio,
//     required this.onRecordingComplete,
//     required this.onDelete,
//     this.isRecording = false,
//   });

//   factory MediaRecorderWidget.audio({
//     required VoidCallback onRecordingComplete,
//     required VoidCallback onDelete,
//     bool isRecording = false,
//   }) {
//     return MediaRecorderWidget(
//       isAudio: true,
//       onRecordingComplete: onRecordingComplete,
//       onDelete: onDelete,
//       isRecording: isRecording,
//     );
//   }

//   factory MediaRecorderWidget.video({
//     required VoidCallback onRecordingComplete,
//     required VoidCallback onDelete,
//     bool isRecording = false,
//   }) {
//     return MediaRecorderWidget(
//       isAudio: false,
//       onRecordingComplete: onRecordingComplete,
//       onDelete: onDelete,
//       isRecording: isRecording,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 56,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(
//           color: isRecording ? AppColors.primaryAccent : AppColors.border2,
//           width: 1.5,
//         ),
//         gradient: isRecording 
//             ? const LinearGradient(
//                 colors: [
//                   Color(0x146366F1),
//                   Color(0x0A6366F1),
//                 ],
//               )
//             : null,
//       ),
//       child: Material(
//         color: Colors.transparent,
//         child: InkWell(
//           borderRadius: BorderRadius.circular(12),
//           onTap: _handleTap,
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               children: [
//                 // Icon
//                 Container(
//                   width: 32,
//                   height: 32,
//                   decoration: BoxDecoration(
//                     color: AppColors.surfaceWhite2,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Icon(
//                     isAudio ? Icons.mic_rounded : Icons.videocam_rounded,
//                     size: 18,
//                     color: AppColors.text2,
//                   ),
//                 ),
                
//                 const SizedBox(width: 12),
                
//                 // Text
//                 Text(
//                   isAudio ? 'Record Audio' : 'Record Video',
//                   style: AppTextStyles.bodyMedium.copyWith(
//                     color: AppColors.text2,
//                   ),
//                 ),
                
//                 const Spacer(),
                
//                 // Recording indicator (if recording)
//                 if (isRecording)
//                   Container(
//                     width: 12,
//                     height: 12,
//                     decoration: const BoxDecoration(
//                       color: AppColors.primaryAccent,
//                       shape: BoxShape.circle,
//                     ),
//                   ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _handleTap() {
//     // For now, simulate recording completion
//     // In real implementation, this would open camera/mic
//     onRecordingComplete();
//   }
// }
















import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

class MediaRecorderWidget extends StatelessWidget {
  final bool isAudio;
  final Function(String) onRecordingComplete; // Should accept String parameter
  final VoidCallback onDelete;
  final bool isRecording;

  const MediaRecorderWidget({
    super.key,
    required this.isAudio,
    required this.onRecordingComplete,
    required this.onDelete,
    this.isRecording = false,
  });

  factory MediaRecorderWidget.audio({
    required Function(String) onRecordingComplete, // Fixed type
    required VoidCallback onDelete,
    bool isRecording = false,
  }) {
    return MediaRecorderWidget(
      isAudio: true,
      onRecordingComplete: onRecordingComplete,
      onDelete: onDelete,
      isRecording: isRecording,
    );
  }

  factory MediaRecorderWidget.video({
    required Function(String) onRecordingComplete, // Fixed type
    required VoidCallback onDelete,
    bool isRecording = false,
  }) {
    return MediaRecorderWidget(
      isAudio: false,
      onRecordingComplete: onRecordingComplete,
      onDelete: onDelete,
      isRecording: isRecording,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isRecording ? AppColors.primaryAccent : AppColors.border2,
          width: 1.5,
        ),
        gradient: isRecording 
            ? const LinearGradient(
                colors: [
                  Color(0x146366F1),
                  Color(0x0A6366F1),
                ],
              )
            : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: _handleTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                // Icon
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.surfaceWhite2,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    isAudio ? Icons.mic_rounded : Icons.videocam_rounded,
                    size: 18,
                    color: AppColors.text2,
                  ),
                ),
                
                const SizedBox(width: 12),
                
                // Text
                Text(
                  isAudio ? 'Record Audio' : 'Record Video',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.text2,
                  ),
                ),
                
                const Spacer(),
                
                // Recording indicator (if recording)
                if (isRecording)
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryAccent,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleTap() {
    // For now, simulate recording completion with a mock file path
    // In real implementation, this would open camera/mic and return actual file path
    final mockFilePath = isAudio 
        ? '/storage/emulated/0/audio_recording.mp3'
        : '/storage/emulated/0/video_recording.mp4';
    
    onRecordingComplete(mockFilePath);
  }
}