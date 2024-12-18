import 'package:firebase_auth/firebase_auth.dart';

class FirebaseExceptionHandler {
  static String handleException(FirebaseException e) {
    switch (e.code) {
      case 'network-request-failed':
        return "Network error. Please check your connection.";
      case 'user-not-found':
        return "No user found with this email.";
      case 'wrong-password':
        return "Incorrect password. Please try again.";
      case 'email-already-in-use':
        return "This email is already in use.";
      case 'weak-password':
        return "The password is too weak. Please choose a stronger password.";
      case 'invalid-email':
        return "The email address is not valid.";
      default:
        return "An unexpected error occurred: ${e.message}";
    }
  }

  // Generic function to handle non-Firebase-specific errors
  static String handleGenericError(Object e) {
    if (e is FirebaseException) {
      return handleException(e);
    }
    return "An unexpected error occurred.";
  }
}
