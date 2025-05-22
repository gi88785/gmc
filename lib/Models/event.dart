//
// 📦 Event Model — this represents a family event in our calendar
//

class Event {
  // 📌 Properties of the event:
  final String personName; // 👤 Name of the person (e.g. Agathe)
  final String eventTitle; // 📌 Title of the event (e.g. Marriage)
  final int? year; // 📅 Year (optional)
  final int month; // 📅 Month (required)
  final int day; // 📅 Day (required)
  final String? note; // 📝 Optional custom note or description

  //
  // 📦 Constructor — this is called when you create a new Event object
  //
  Event({
    required this.personName,
    required this.eventTitle,
    this.year, // optional
    required this.month,
    required this.day,
    this.note, // optional
  });

  //
  // 📐 Helper: Calculate age based on the year if available
  //
  int? get age {
    if (year == null) {
      return null; // If year isn’t known, we can’t calculate age
    }
    final currentYear = DateTime.now().year;
    return currentYear - year!;
  }

  //
  // 📑 Helper: Get a display-friendly date string (with or without year)
  //
  String get formattedDate {
    if (year != null) {
      return '$day/$month/$year';
    } else {
      return '$day/$month';
    }
  }

  //
  // 📑 Helper: Check if event has a complete date (year, month, and day)
  //
  bool get hasDate {
    return year != null;
  }

  //
  // 📑 Helper: Generate a default description if note is not provided
  //
  String get fullDescription {
    if (note != null && note!.isNotEmpty) {
      return note!;
    } else if (year != null) {
      return '$personName had $eventTitle on $formattedDate, it\'s been ${age!} years.';
    } else {
      return '$personName had $eventTitle on $formattedDate.';
    }
  }

  //
  // 📤 Convert Event object to a Map — useful for saving to local storage later
  //
  Map<String, dynamic> toMap() {
    return {
      //'date': date.toIso8601String(), // convert DateTime to String for storage
      'personName': personName,
      'eventTitle': eventTitle,
      'year': year,
      'month': month,
      'day': day,
      'note': note,
    };
  }

  //
  // 📥 Create an Event object from a Map — when loading data from storage
  //
  factory Event.fromMap(Map<String, dynamic> map) {
    return Event(
      //date: DateTime.parse(map['date']), // convert String back to DateTime
      personName: map['personName'],
      eventTitle: map['eventTitle'],
      year: map['year'],
      month: map['month'],
      day: map['day'],
      note: map['note'],
    );
  }
}

/*
| Code                                  | What it does                                                                               |
| :------------------------------------ | :----------------------------------------------------------------------------------------- |
| `class Event`                         | Creates a new class (blueprint) called `Event`                                             |
| `final String title`                  | A text property for the event’s name                                                       |
| `final DateTime date`                 | A property to store the date of the event                                                  |
| `final String description`            | Text for an optional description                                                           |
| `Event({ required this.title, ... })` | Constructor that forces us to provide these 3 values when creating a new Event             |
| `toMap()`                             | Turns an Event object into a Map (like a JSON object), so we can save it later             |
| `fromMap()`                           | A factory constructor that takes a Map (like from storage) and turns it back into an Event |

| What                     | Why                                                     |
| :----------------------- | :------------------------------------------------------ |
| `personName`             | So we know whose event it is                            |
| `eventTitle`             | To describe the event                                   |
| `year` (optional)        | Because you said sometimes the year is unknown          |
| `month` & `day`          | Always needed for a date                                |
| `note` (optional)        | User can write a note or we auto-generate one           |
| `age` getter             | Calculates age if year is known                         |
| `formattedDate` getter   | Shows date nicely with or without year                  |
| `fullDescription` getter | Uses custom note if available, otherwise auto-generates |
| `toMap()` & `fromMap()`  | So we can save and load these from storage later        |

*/
