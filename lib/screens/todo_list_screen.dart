import 'package:flutter/material.dart';
import 'package:todo/stores/to-do.store.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodoListScreen extends ConsumerWidget {
  const TodoListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Map<String, dynamic>> items = ref.watch(itemsProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'To-Do List',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
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
            child: Column(
              children: [
                const SizedBox(height: 20),
                Expanded(
                  child: items.isEmpty
                      ? const Center(child: Text('No tasks yet.'))
                      : Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListView.builder(
                            itemCount: items.length,
                            itemBuilder: (context, index) {
                              return Card(
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      '/update',
                                      arguments: {'todoIndex': index},
                                    );
                                  },
                                  title: Text(
                                    items[index]['title'],
                                    style: TextStyle(
                                      color: items[index]['isCompleted']
                                          ? Colors.green
                                          : null,
                                      decoration: !items[index]['isCompleted']
                                          ? TextDecoration.none
                                          : TextDecoration.lineThrough,
                                    ),
                                  ),
                                  leading: Checkbox(
                                    activeColor: Colors.green,
                                    value: items[index]['isCompleted'] as bool,
                                    onChanged: (bool? val) => {
                                      ref
                                          .read(itemsProvider.notifier)
                                          .updateItem(index, {
                                        ...items[index],
                                        'isCompleted': val
                                      })
                                    },
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => {Navigator.pushNamed(context, '/add')},
      ),
    );
  }
}
