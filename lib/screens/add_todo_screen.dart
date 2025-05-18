import 'package:flutter/material.dart';
import 'package:todo/stores/to-do.store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:todo/components/DateInput.dart';

class AddTodoScreen extends ConsumerStatefulWidget {
  const AddTodoScreen({super.key});

  @override
  ConsumerState<AddTodoScreen> createState() => _AddTodoScreen();
}

class _AddTodoScreen extends ConsumerState<AddTodoScreen> {
  String _title = '';
  String _details = '';
  String _date = '';

  void _setDate(String dateString) {
    setState(() {
      _date = dateString;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Add To-Do',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  TextField(
                    onChanged: (value) => setState(() {
                      _title = value;
                    }),
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    onChanged: (value) => setState(() {
                      _details = value;
                    }),
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Enter description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DateInputField(onChanged: _setDate),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                      ),
                      backgroundColor: WidgetStateProperty.all<Color>(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    onPressed: () {
                      final now = DateTime.now();
                      // ignore: avoid_print
                      final Map<String, dynamic> item = {
                        'dueDate': _date,
                        'title': _title,
                        'description': _details,
                        'isCompleted': false,
                        'createdAt': DateFormat('dd-mm-yyyy').format(now)
                      };
                      ref.read(itemsProvider.notifier).addItem(item);
                      Navigator.pushNamed(context, '/');
                    },
                    child: const Text(
                      "Add Task",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
