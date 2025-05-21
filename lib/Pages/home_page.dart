import 'package:flutter/material.dart'; // 📦 Import Flutter UI toolkit

///
/// 🏠 This is the Home Page of the app.
/// It will display a simple title and welcome message for now.
///
class HomePage extends StatelessWidget {
  const HomePage({super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GMC Family Calendar'), // 📛 Top title bar
      ),
      body: const Center(
        child: Text(
          'Welcome to the GMC Family Calendar!',
          style: TextStyle(fontSize: 24), // 🎨 Make text a bit bigger
        ),
      ),
    );
  }
}
