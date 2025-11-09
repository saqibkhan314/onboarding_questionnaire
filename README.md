# Hotspot Host Onboarding

A Flutter-based onboarding application designed to streamline the host application process through an interactive questionnaire with text, audio, and video response capabilities.

## 📱 Features

### Experience Selection
- **Interactive Experience Cards**: Browse and select from various hosting experiences with visual cards
- **Multi-Selection Support**: Choose multiple experience types that match your interests
- **Dynamic Backgrounds**: Experience cards display images from the API with grayscale effects for unselected items
- **Additional Information**: 250-character text field to describe your perfect hotspot vision
- **Smooth Animations**: Card selection animations and responsive layout adaptations

### Onboarding Questionnaire
- **Comprehensive Questions**: Detailed questions about hosting motivation and intent
- **Flexible Response Options**:
  - 600-character text input for detailed written responses
  - Audio recording with real-time visualization
  - Video recording with preview capabilities
- **Dynamic UI**: Layout automatically adjusts when keyboard appears or media is recorded
- **Progress Tracking**: Visual progress indicator showing completion status

## 🛠 Technical Implementation

### Architecture & State Management
- **Flutter Framework** with Material Design principles
- **Riverpod** for efficient and scalable state management
- **Clean Architecture** with clear separation of concerns
- **Provider Pattern** for dependency injection and state sharing

### Custom UI Components
- **Wave Background**: Custom painter for immersive visual experience
- **Wavy Progress Bar**: Animated progress indicator with wave design
- **Experience Cards**: Custom cards with selection states and animations
- **Media Recorder Widgets**: Unified interface for audio and video recording

### API Integration
- **RESTful API Communication** using Dio HTTP client
- **Experience Data Fetching** from `https://staging.chamberofsecrets.8club.co/v1/experiences`
- **Error Handling** with comprehensive fallback states
- **Loading States** with proper user feedback

## 🎨 Design System

### Colors
- **Primary**: `#6366F1` (Indigo)
- **Primary Accent**: `#8B5CF6` (Purple)
- **Text Colors**: Multiple shades for hierarchy (text1, text2, text3, text4)
- **Surface Colors**: Dark theme optimized with surface whites and borders
- **Gradients**: Carefully crafted gradients for visual depth