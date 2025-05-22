import 'package:flutter/material.dart'; // 📦 Import Flutter's UI toolkit
import 'Pages/home_page.dart'; // 📄 (Optional) Import Flutter custom home page
//import 'Pages/events_list_page.dart'; // 📦 Import our Events List page

void main() {
  runApp(
    const GMCApp(),
  ); // 🏃‍♂️ Start the app by calling runApp and passing it our GMCApp widget
}

//
// 📱 This is the root widget of our app.
// Think of it like the main container for everything displayed.
//
class GMCApp extends StatelessWidget {
  const GMCApp({super.key}); // 📦 Constructor for the class

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title:
          'Gilles & Marie Family Calendar', // 🏷️ App title displayed in task switcher
      theme: ThemeData(
        primarySwatch: Colors.teal, // 🎨 Main color theme of the app
      ),
      home:
          const HomePage(), // 🏠 This is the screen we see when the app starts (commented out for now)
      //const EventsListPage(), // 📃 Our current home screen is the Events List Page
    );
  }
}
