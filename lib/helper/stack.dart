import 'dart:collection';

class MyStack<T> {
  final _stack = Queue<T>();

  void push(T element) {
    _stack.addLast(element);
    // _stack.addLast(element);
  }
  
  
  T pop() {
    _stack.removeLast();
    final T lastElement = _stack.last;
    // _stack.removeLast();
    return lastElement;
  }

  void clear() {
    _stack.clear();
  }

  int count() => _stack.length;

  bool get isEmpty => _stack.isEmpty;
}
