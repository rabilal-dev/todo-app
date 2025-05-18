import 'package:flutter_riverpod/flutter_riverpod.dart';

// Define a provider for a list of strings (can be any type)
final itemsProvider =
    StateNotifierProvider<ItemsNotifier, List<Map<String, dynamic>>>((ref) {
  return ItemsNotifier();
});

class ItemsNotifier extends StateNotifier<List<Map<String, dynamic>>> {
  ItemsNotifier()
      : super([
          {
            'title': 'Item1',
            'isCompleted': false,
            'description': 'test item',
            'dueDate': '20-05-2025',
            'createdAt':''
          }
        ]);

  // Add an item to the list
  void addItem(Map<String, dynamic> item) {
    state = [...state, item]; // Create new list with added item (immutability)
  }

  // Optionally, remove an item
  void removeItem(Map<String, dynamic> item) {
    state = state.where((i) => i != item).toList();
  }

  // Update an item in the list by index
  void updateItem(int index, Map<String, dynamic> newItem) {
    if (index < 0 || index >= state.length) return;
    state = [
      for (int i = 0; i < state.length; i++)
        if (i == index) newItem else state[i]
    ];
  }
}
