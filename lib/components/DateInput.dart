import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateInputField extends StatefulWidget {
  final ValueChanged<String> onChanged;
  final String? selectedDate;
  const DateInputField({super.key, required this.onChanged, this.selectedDate});

  @override
  State<DateInputField> createState() => _DateInputFieldState();
}

class _DateInputFieldState extends State<DateInputField> {
  late TextEditingController _controller;
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();

    // Initialize the selected date from the widget or default to null
    selectedDate = widget.selectedDate != null
        ? DateFormat('yyyy-MM-dd').parse(widget.selectedDate!)
        : null;

    // Initialize the controller
    _controller = TextEditingController(
      text: widget.selectedDate ?? '',
    );
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _controller.text = DateFormat('yyyy-MM-dd').format(picked);
      });
      widget.onChanged(DateFormat('yyyy-MM-dd').format(picked));
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _controller,
      readOnly: true,
      decoration: const InputDecoration(
        labelText: 'Select Date',
        suffixIcon: Icon(Icons.calendar_today),
        border: OutlineInputBorder(), // optional enhancement
      ),
      onTap: () => _selectDate(context),
    );
  }
}
