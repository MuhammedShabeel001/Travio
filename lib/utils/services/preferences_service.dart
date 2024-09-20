import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const _onboardingKey = 'onboardingCompleted';

  // Check if onboarding has been completed
  Future<bool> shouldShowOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? true; // Show onboarding if it's the first launch
  }

  // Set onboarding completed
  Future<void> setOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, false);
  }
}
