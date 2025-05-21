import 'package:flutter/material.dart'; // 📦 Import Flutter's UI toolkit
import 'Pages/home_page.dart'; // 📄 Import Flutter custom home page

void main() {
  runApp(
    const GMCApp(),
  ); // 🏃‍♂️ Start the app by calling runApp and giving it our GMCApp widget
}

///
/// 📱 This is the root widget of our app.
/// Think of it like the main container for everything.
///
class GMCApp extends StatelessWidget {
  const GMCApp({super.key}); // Constructor for the class

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gilles & Marie Family Calendar', // 🏷️ App title
      theme: ThemeData(
        primarySwatch: Colors.teal, // 🎨 Main color theme
      ),
      home:
          const HomePage(), // 🏠 This is the screen we see when the app starts
    );
  }
}
