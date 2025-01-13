// import 'dart:html';

// class AuthService {
//   Future<bool> isUserSignedIn() async {
//     // Check if the session token exists in Local Storage
//     String? token = window.localStorage['flutter.token1']; // Retrieve the token from Local Storage
//     return token != null; // Return true if the token exists, false otherwise

//     // #TODO, to check time and mark expiry
//   }

//   Future<void> logout() async {
//     // Clear the token from Local Storage on logout
//     window.localStorage.remove('flutter.token1'); // Clear stored session token
//   }

//   Future<bool> isKeyExists(String key) async {
//     // Check if a specific key exists in Local Storage
//     String? value = window.localStorage[key];
//     return value != null; // Return true if key exists, false otherwise
//   }
// }
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> isUserSignedIn() async {
    // Get the instance of SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if the token exists
    String? token = prefs.getString('token1');
    return token != null; // Return true if the token exists
  }

  Future<void> logout() async {
    // Get the instance of SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Remove the stored token
    await prefs.remove('flutter.token1');
  }

  Future<bool> isKeyExists(String key) async {
    // Get the instance of SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Check if the key exists
    return prefs.containsKey(key);
  }
}
