import 'package:flutter/material.dart'; // 📦 Import Flutter's UI toolkit
import 'events_list_page.dart'; // 📦 Import the EventsListPage (make sure this file exists)

//
// 🏠 This is the Home Page of the app.
// It displays a simple centered welcome message on all platforms.
//
class HomePage extends StatelessWidget {
  const HomePage({super.key}); // Constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GMC Family Calendar'), // 📛 App's top title bar
        centerTitle: true, // 👈 this centers the title on all platforms
      ),
      body: SafeArea(
        // 📱 Keeps content inside visible screen area on phones & tablets
        child: Center(
          // 📦 Center everything horizontally and vertically
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // 🎯 Center content vertically
            crossAxisAlignment:
                CrossAxisAlignment.center, // 🎯 Center content horizontally
            children: [
              // 📅 Calendar Icon
              const Icon(Icons.calendar_month, size: 80, color: Colors.teal),
              const SizedBox(height: 20), // 📏 Adds vertical space (20 pixels)
              // 📝 Welcome text
              const Text(
                'Welcome to the GMC Family Calendar!',
                textAlign:
                    TextAlign
                        .center, // 📝 Make sure text is centered in its box
                style: TextStyle(
                  fontSize: 28, // 🎨 Adjust text size
                  fontWeight: FontWeight.bold, // 🎨 Make text bold
                ),
              ),
              const SizedBox(
                height: 20,
              ), // 📏 Adds vertical space (20 pixels) below the text
              // 📆 Open Calendar Button
              ElevatedButton(
                onPressed: () {
                  // 📦 Navigate to Events List Page when button is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              const EventsListPage(), // 📦 Create and navigate to EventsListPage
                    ),
                  );
                },
                child: const Text('Open Calendar'), // 📖 Button label text
              ),
            ], // 👈 Closing bracket for children list — previously missing
          ),
        ),
      ),
    );
  }
}
