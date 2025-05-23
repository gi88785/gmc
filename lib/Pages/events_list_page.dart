import 'package:flutter/material.dart'; // 📦 Flutter UI package
import '../Models/event.dart'; // 📦 Import our Event model to use it here
import 'add_event_page.dart';

///
/// 📃 This page displays a list of events
///
class EventsListPage extends StatefulWidget {
  const EventsListPage({super.key});

  @override
  State<EventsListPage> createState() => _EventsListPageState();
}

class _EventsListPageState extends State<EventsListPage> {
  //
  // 📋 Sample list of events (we’ll replace this with local storage later)
  //
  List<Event> events = [
    Event(
      personName: 'Agathe',
      eventTitle: 'Marriage',
      year: 2015,
      month: 5,
      day: 22,
      note: 'A beautiful ceremony in Paris',
    ),
    Event(personName: 'Jean', eventTitle: 'Baptism', month: 8, day: 15),
  ];

  void _addNewEvent(Event newEvent) {
    setState(() {
      events.add(newEvent); // 📦 Add new event to the list
    });
  }

  // 🎨 Function that selects an icon based on the event type
  IconData _getEventIcon(String eventTitle) {
    switch (eventTitle.toLowerCase()) {
      case 'marriage':
        return Icons.favorite; // ❤️ For Marriage
      case 'baptism':
        return Icons.child_friendly; // 👶 For Baptism
      default:
        return Icons.event; // 📅 Default icon if type unknown
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Family Events'), // 📛 Title in the top AppBar
        centerTitle: true, // 👈 this centers the title on all platforms
      ),
      body: SafeArea(
        // 📱 Keeps content visible and away from notches, status bars, etc.
        child: ListView.builder(
          // 📃 Builds a scrollable list
          itemCount: events.length, // 🔢 How many items to display
          itemBuilder: (context, index) {
            // 👷 Function to build each item in the list
            final event = events[index]; // 📦 Get the current event

            return Card(
              // 📦 Each event is shown inside a Card widget
              margin: const EdgeInsets.all(10), // 📏 Margin around the card
              child: ListTile(
                // 📑 A standard list item
                title: Text(
                  '${event.personName} — ${event.eventTitle}', // 📝 Title of the card (Name and Event type)
                  style: const TextStyle(
                    fontWeight: FontWeight.bold, // 🎨 Make title bold
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // 📐 Align text to the start
                  children: [
                    if (event.hasDate)
                      Text(
                        'Date: ${event.formattedDate}', // 📆 Show event date if available
                      ),
                    Text(
                      event
                          .fullDescription, // 📝 Event description below the date
                    ),
                  ],
                ),
                leading: Icon(
                  _getEventIcon(
                    event.eventTitle,
                  ), // 🎨 Icon that represents the event type
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                ), // ➡️ Arrow on the right
                onTap: () {
                  // 📌 Action when the user taps on an event
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${event.personName}\'s event tapped!'),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
      // ✅ Floating action button for adding new events
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          // 📌 Navigate to the add event page when button is pressed
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddEventPage(onEventAdded: _addNewEvent),
            ),
          );
        },
      ),
    ); // 👈 Close the Scaffold properly here
  }
}

/*
| Code                            | What it does                                                                        |
| :------------------------------ | :---------------------------------------------------------------------------------- |
| `List<Event> events = [...]`    | Creates a list of sample event data                                                 |
| `ListView.builder`              | Makes a scrollable list where each item is built only when needed (efficient)       |
| `itemCount: events.length`      | Tells the list how many items to display                                            |
| `itemBuilder: (context, index)` | Function that builds each individual event card                                     |
| `Card`                          | A container with rounded corners, slight shadow                                     |
| `ListTile`                      | A built-in widget for neatly displaying an icon, title, subtitle, and trailing icon |
| `title`                         | Main text (bolded name + event title)                                               |
| `subtitle`                      | Secondary text: shows event date (if present) and event description                 |
| `leading`                       | An icon chosen based on event type (e.g. heart for marriage)                        |
| `trailing`                      | Small icon (arrow) on the right side                                                |
| `onTap`                         | Code to run when someone taps on the list item (shows a temporary message)          |
| `_getEventIcon()`               | Function that picks an icon according to the event type                             |
| `floatingActionButton`          | A button floating at the bottom-right for adding new events                         |
*/
