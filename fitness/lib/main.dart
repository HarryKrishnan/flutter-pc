import 'package:flutter/material.dart';
import 'package:fitness/authservice.dart';
import 'package:fitness/dashboard.dart';
import 'package:fitness/loginpage.dart';
import 'package:fitness/report.dart';
import 'package:fitness/stats.dart';
import 'package:fitness/signinpage.dart';
import 'package:fitness/workoutscreen.dart';

void main() {
  runApp(fitness());
}

class fitness extends StatelessWidget {
  final AuthService _authService = AuthService();

  fitness({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fitness Tracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => FutureBuilder<bool>(
          future: _authService.isUserSignedIn(), // Check if user is signed in
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasData && snapshot.data == true) {
              // If user is signed in, navigate to the dashboard
              return DashboardPage();
            } else {
              // If not signed in, navigate to the signup page
              return SignupPage();
            }
          },
        ),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/dashboard': (context) => ProtectedRoute(child: DashboardPage()),
        '/profile': (context) => ProtectedRoute(child: StatsScreen()),
        '/workout': (context) => ProtectedRoute(child: WorkoutsScreen()),
        '/reports': (context) => ProtectedRoute(child: ReportPage()),
      },
    );
  }
}


class ProtectedRoute extends StatelessWidget {
  final Widget child;

  const ProtectedRoute({required this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthService _authService = AuthService();
      print("reacheddd yyyyyyyyyyyyyyyyyyyyyy");

    return FutureBuilder<bool>(
      future: _authService.isUserSignedIn(), // Check cookie status
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data == true) {
          return child; // User is signed in, show the protected page
        } else {
          // User is not signed in, redirect to the login page
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushReplacementNamed('/login');
          });
          return Container(); // Return an empty container while redirecting
        }
      },
    );
  }
}
