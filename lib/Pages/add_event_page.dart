// 📦 Import Flutter material design package for UI components
import 'package:flutter/material.dart';
// 📦 Import your custom Event model
import '../Models/event.dart';
import 'package:flutter/services.dart'; // 📦 Import for input formatters

// 📄 This is a stateful widget because it manages form input state
class AddEventPage extends StatefulWidget {
  // 📣 A callback function passed from the parent widget to handle the new event when it's created
  final Function(Event) onEventAdded;

  // 📌 Constructor for AddEventPage requiring the callback
  const AddEventPage({super.key, required this.onEventAdded});

  @override
  State<AddEventPage> createState() => _AddEventPageState();
}

// 📄 State class to hold the form fields, selected date, event category and logic
class _AddEventPageState extends State<AddEventPage> {
  // 📝 Controllers to read the text entered into the input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _monthController = TextEditingController();
  final TextEditingController _dayController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  // 📆 Variable to hold the selected date from the date picker (optional)
  DateTime? _selectedDate;

  // 📦 Map of predefined event categories associated with precise, meaningful icons
  final Map<String, IconData> _eventCategories = {
    'Birthday': Icons.cake,
    'Marriage Anniversary': Icons.favorite,
    'Meeting Anniversary': Icons.handshake,
    'Baptism': Icons.water_drop,
    'First Communion': Icons.church,
    'Death': Icons.airline_seat_individual_suite,
    'Graduation': Icons.school,
    'Ordination': Icons.workspace_premium,
    'Special Day': Icons.star,
    'Other': Icons.question_mark,
  };

  // 📌 Variable to track the currently selected category
  String? _selectedCategory;

  // 📌 Month names list for dropdown and validation
  final List<String> _monthNames = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  // 📌 Variable to track the selected month (by name)
  String? _selectedMonthName;

  // 📌 Variable to enable/disable year input manually
  bool _useYear = true;

  // 📦 Function called when the user presses the "Add Event" button
  void _submitEvent() {
    final name = _nameController.text;
    final title = _titleController.text;
    final note = _noteController.text;
    final yearText = _yearController.text;
    final dayText = _dayController.text;
    final monthText = _monthController.text;

    // 📌 Validate name and title presence
    if (name.isEmpty) {
      _showFieldError('Please enter a name', _nameController);
      return;
    }

    if (title.isEmpty) {
      _showFieldError('Please enter an event title', _titleController);
      return;
    }

    // 📌 Validate category
    if (_selectedCategory == null) {
      _showSnackError('Please select an event type');
      return;
    }

    // 📌 Validate month input
    int? month;
    if (monthText.isNotEmpty) {
      if (RegExp(r'^[1-9]$|^1[0-2]$').hasMatch(monthText)) {
        //if (RegExp(r'^\d+$').hasMatch(monthText)) {
        month = int.parse(monthText);

        if (month < 1 || month > 12) {
          _showFieldError('Month must be between 1 and 12', _monthController);
          return;
        }
        _selectedMonthName = _monthNames[month - 1];
      } else {
        // 📌 Try matching string input with month names (case-insensitive)
        final match = _monthNames.firstWhere(
          (m) => m.toLowerCase().startsWith(monthText.toLowerCase()),
          orElse: () => '',
        );
        if (match.isEmpty) {
          _showFieldError(
            'Month must be a valid name or number (1-12)',
            _monthController,
          );
          return;
        } else {
          _selectedMonthName = match;
          month = _monthNames.indexOf(match) + 1;
        }
      }
    }

    // 📌 Validate day input
    int? day;
    if (dayText.isNotEmpty) {
      day = int.tryParse(dayText);
      if (day == null || day < 1) {
        _showFieldError('Day must be between 1 and 31', _dayController);
        return;
      }
      final validatedYear =
          _useYear
              ? (int.tryParse(yearText) ?? DateTime.now().year)
              : DateTime.now().year;
      final maxDay = month != null ? _daysInMonth(validatedYear, month) : 31;
      if (day > maxDay) {
        _showFieldError(
          'Day must be between 1 and $maxDay for the selected month',
          _dayController,
        );
        return;
      }
    }

    // 📌 Validate year if enabled
    int? year;
    if (_useYear && yearText.isNotEmpty) {
      year = int.tryParse(yearText);
      final currentYear = DateTime.now().year;
      if (year == null || year < 1 || year > currentYear + 1) {
        _showFieldError(
          'Year must be between 1 and ${currentYear + 1}',
          _yearController,
        );
        return;
      }
      if (yearText.length != 4) {
        _showFieldError('Year must be exactly 4 digits', _yearController);
        return;
      }
    }

    // 📦 Create a new Event object with the collected form data
    final newEvent = Event(
      personName: name,
      eventTitle: title,
      year: _selectedDate?.year ?? year,
      month: _selectedDate?.month ?? month!,
      day: _selectedDate?.day ?? day!,
      note: note.isNotEmpty ? note : null,
    );

    // 📣 Call the parent widget's onEventAdded function to add the event
    widget.onEventAdded(newEvent);

    // ⬅️ Navigate back to the previous screen after adding the event
    Navigator.pop(context);
  }

  // 📦 Function to open the date picker dialog and set the selected date
  void _pickDate() async {
    final now = DateTime.now();
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: DateTime(now.year - 150),
      lastDate: DateTime(now.year + 1),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _yearController.text = pickedDate.year.toString();
        _selectedMonthName = _monthNames[pickedDate.month - 1];
        _monthController.text = pickedDate.month.toString();
        _dayController.text = pickedDate.day.toString();
      });
    }
  }

  // 📌 Helper function to calculate days in a month (accounts for leap years)
  int _daysInMonth(int year, int month) {
    if (month == 2) {
      return (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0)) ? 29 : 28;
    }
    /*
    if ((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
      return 29;
    } 
    else {
      return 28;
    }
    */
    const monthLength = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
    return monthLength[month - 1];
  }

  // 📢 Show error message for a specific TextField (centralized)
  void _showFieldError(String message, TextEditingController controller) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(message)),
        behavior: SnackBarBehavior.floating,
      ),
    );
    FocusScope.of(context).requestFocus(FocusNode());
    controller.selection = TextSelection(
      baseOffset: 0,
      extentOffset: controller.text.length,
    );
  }

  // 📢 Show a simple snack error
  void _showSnackError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Center(child: Text(message)),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: const Text('Add New Event')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'Name of the Person',
                  alignLabelWithHint: true,
                ),
              ),
              TextField(
                controller: _titleController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'Event Title',
                  alignLabelWithHint: true,
                ),
              ),

              const SizedBox(height: 20),
              // 📌 Toggle year input centrally above date picker
              SwitchListTile(
                title: const Center(child: Text('Include Year')),
                value: _useYear,
                onChanged: (value) {
                  setState(() {
                    _useYear = value;
                  });
                },
              ),

              // 📆 Tappable Date Picker Row
              InkWell(
                onTap: _pickDate,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.calendar_month),
                    const SizedBox(width: 10),
                    Text(
                      _selectedDate == null
                          ? 'Pick a Date (optional)'
                          : '${_selectedDate!.year}-${_selectedDate!.month}-${_selectedDate!.day}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),

              if (_useYear)
                TextField(
                  controller: _yearController,
                  textAlign: TextAlign.center,
                  decoration: const InputDecoration(
                    labelText: 'Year',
                    alignLabelWithHint: true,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(4),
                  ],
                ),

              TextField(
                controller: _monthController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'Month',
                  alignLabelWithHint: true,
                ),
              ),

              TextField(
                controller: _dayController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'Day',
                  alignLabelWithHint: true,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),

              const SizedBox(height: 20),

              // 📌 Event Type Picker with icon
              DropdownButton<String>(
                value: _selectedCategory,
                hint: const Text('Select Event Type'),
                isExpanded: true,
                items:
                    _eventCategories.keys.map((String category) {
                      return DropdownMenuItem<String>(
                        value: category,
                        child: Row(
                          children: [
                            Icon(_eventCategories[category]),
                            const SizedBox(width: 10),
                            Text(category),
                          ],
                        ),
                      );
                    }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
              ),

              if (_selectedCategory != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(_eventCategories[_selectedCategory], size: 50),
                ),

              TextField(
                controller: _noteController,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  labelText: 'Note (optional)',
                  alignLabelWithHint: true,
                ),
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: _submitEvent,
                child: const Text('Add Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
✅ Summary of Key Concepts:

- TextEditingController: Controls and reads user input from TextFields.
- ScaffoldMessenger: Shows in-app snackbars (temporary notification messages).
- Navigator.pop(context): Takes the user back to the previous screen.
- Function callback: Lets the parent widget handle data passed up from this page.
- SingleChildScrollView: Allows the form to scroll if the screen is too small.
- showDatePicker: Flutter built-in date picker dialog that handles valid dates,
- leap years, days in months, and more automatically.
- DropdownButton: Lets user select from a list of predefined values (here, event categories with precise icons).
- Map<String, IconData>: Holds event categories mapped to highly specific icons for clean, structured management.
- centerTitle & crossAxisAlignment.center: Aligns the app bar title and UI contents to the center for a balanced layout.
- DateTime: Dart’s built-in date object, handles leap years, valid month-day relationships internally.
- Manual fields and date picker coexist — either or both can be used, improving flexibility.
- Auto-fill: When using the picker, manually entered fields update automatically.
- SwitchListTile: lets users enable/disable the year input field dynamically.
- Validations and formatters for numeric ranges and length (like year only 4 digits max).
- Flexible month input: accepts number (1–12) or partial/full name (case-insensitive).
- Day validated according to month, leap years, and/or 31 max if no month.
- Focus and error handling directs users to the exact field in error.
- All labels and text fields centralized.
*/
