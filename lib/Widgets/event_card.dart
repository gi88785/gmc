import 'package:flutter/material.dart';
import '../Models/event.dart';

///
/// 📦 A reusable card widget to display an Event's details.
///
class EventCard extends StatelessWidget {
  final Event event;

  // 📌 Constructor requires an event
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 16,
      ), // 📏 Card margin
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ), // 🎨 Rounded corners
      elevation: 3, // 🖼️ Subtle shadow
      child: Padding(
        padding: const EdgeInsets.all(16), // 📏 Padding inside the card
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // 📐 Align content to the left
          children: [
            // 📝 Event Title
            Text(
              '${event.personName} - ${event.eventTitle}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8), // 📏 Spacing
            // 📅 Event Date
            Text(
              'Date: ${event.formattedDate}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            // 📑 Event Note or Description
            Text(
              event.fullDescription,
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
