import 'package:flutter/services.dart';

class HapticFeedbackService {
  HapticFeedbackService._();

  /// Light click for standard interactions (buttons, tabs, switches)
  static Future<void> light() async {
    await HapticFeedback.lightImpact();
  }

  /// Medium click for more significant actions (submitting forms)
  static Future<void> medium() async {
    await HapticFeedback.mediumImpact();
  }

  /// Heavy click for destructive or major actions
  static Future<void> heavy() async {
    await HapticFeedback.heavyImpact();
  }

  /// Success feedback for completed flows
  static Future<void> success() async {
    await HapticFeedback.lightImpact(); // Fallback if no explicit success available
  }

  /// Error feedback
  static Future<void> error() async {
    await HapticFeedback.vibrate();
  }
}
