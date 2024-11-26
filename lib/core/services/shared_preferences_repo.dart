// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:studify/src/common/auth/data/models/user_profile_model.dart';

// class SharedPreferencesRepository {
//   SharedPreferencesRepository();

//   // Initialize SharedPreferences
//   // Future<void> init() async {
//   //   final prefs = await SharedPreferences.getInstance();
//   //   // Initialize SharedPreferences here if needed
//   // }
//   Future<void> saveUserProfile(UserProfileModel userProfile) async {
//     final prefs = await SharedPreferences.getInstance();
//     final userProfileJson = json.encode(userProfile.toJson());
//     prefs.setString('userProfile', userProfileJson);
//   }

// // Get UserProfileEntity from SharedPreferences
//   Future<UserProfileModel?> getUserProfile() async {
//     final prefs = await SharedPreferences.getInstance();
//     final userProfileJson = prefs.getString('userProfile');

//     if (userProfileJson != null) {
//       final Map<String, dynamic> userMap = json.decode(userProfileJson);
//       return UserProfileModel.fromJson(userMap);
//     }
//     return null;
//   }

//   Future<void> deleteUser() async {
//     final prefs = await SharedPreferences.getInstance();
//     prefs.remove('userProfile');
//   }
// }
