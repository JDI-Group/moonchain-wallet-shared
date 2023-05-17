import 'dart:collection';

class ListWithTotal<T> extends ListBase<T> {
  ListWithTotal(this.total, List<T> source) : innerSource = source;

  final List<T> innerSource;
  final int total;

  @override
  int get length => innerSource.length;

  @override
  set length(int newLength) => innerSource.length = newLength;

  @override
  T operator [](int index) => innerSource[index];

  @override
  void operator []=(int index, T value) => innerSource[index] = value;

  @override
  void add(T element) => innerSource.add(element);
}

extension ListWithTotalExt<T> on List<T> {
  ListWithTotal<T> withTotal(int total) => ListWithTotal(total, this);
}

class Location {
  Location(this.latitude, this.longitude);

  final double latitude;
  final double longitude;
}

abstract class Field<T> {
  T get value;
  set value(T value);
}
