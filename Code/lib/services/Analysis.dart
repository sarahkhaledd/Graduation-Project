import 'package:firebase_analytics/firebase_analytics.dart';

class Analysis {
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<void> signup() async {
    await analytics.logSignUp(
      signUpMethod: 'test sign up method',
    );
  }
}