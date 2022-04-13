import 'dart:collection';

import 'package:flutter/foundation.dart';

class CustomerModel extends ChangeNotifier {

  final List<String> _items = [];

  /// An unmodifiable view of the items..
  UnmodifiableListView<String> get items => UnmodifiableListView(_items);


  /// Adds [name] to list. This is the only way to modify the
  /// list from the outside.
  void add(String item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the list.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }
}