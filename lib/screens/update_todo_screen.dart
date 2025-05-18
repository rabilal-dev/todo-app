import 'package:flutter/material.dart';
import 'package:todo/stores/to-do.store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo/components/DateInput.dart';

class UpdateTodoScreen extends ConsumerStatefulWidget {
  const UpdateTodoScreen({super.key});

  @override
  ConsumerState<UpdateTodoScreen> createState() => _UpdateTodoScreen();
}

class _UpdateTodoScreen extends ConsumerState<UpdateTodoScreen> {
  void _setDate(String dateString) {
    setState(() {});
  }

  @override
  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = ref.watch(itemsProvider);

    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final int taskIdex = args['todoIndex'] as int;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Update To-Do',
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
                    controller:
                        TextEditingController(text: items[taskIdex]['title']),
                    onChanged: (value) => setState(() {}),
                    decoration: const InputDecoration(
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: TextEditingController(
                        text: items[taskIdex]['description']),
                    onChanged: (value) => setState(() {}),
                    maxLines: 5,
                    decoration: const InputDecoration(
                      labelText: 'Enter description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DateInputField(
                    onChanged: _setDate,
                    selectedDate: items[taskIdex]['dueDate'],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                          backgroundColor: WidgetStateProperty.all<Color>(
                            Colors.green,
                          ),
                        ),
                        onPressed: () {
                          ref.read(itemsProvider.notifier).updateItem(taskIdex,
                              {...items[taskIdex], 'isCompleted': true});
                          Navigator.pushNamed(context, '/');
                        },
                        child: const Text(
                          "Mark as completed",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                            const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                          ),
                          backgroundColor: WidgetStateProperty.all<Color>(
                            Colors.redAccent,
                          ),
                        ),
                        onPressed: () {
                          ref
                              .read(itemsProvider.notifier)
                              .removeItem(items[taskIdex]);
                          Navigator.pushNamed(context, '/');
                        },
                        child: const Text(
                          "Delete task",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
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
