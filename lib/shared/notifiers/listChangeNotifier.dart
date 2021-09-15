

import 'package:flutter/cupertino.dart';

class ListChangeNotifier<T> extends ChangeNotifier {
  List<T> _list;

  List<T> get list => _list;

  set list(List<T> value) {
    _list = value;
    notifyListeners();
  }

  ListChangeNotifier({List<T> initialData}){
    _list = initialData ?? [];
  }

  add(T value, [num index]) {
    _list.insert(index > -1 ? index : list.length, value);
    notifyListeners();
  }

  update(T value, num index) {
    _list[index] = value;
    notifyListeners();
  }
}