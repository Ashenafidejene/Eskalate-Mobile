extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

extension IterableExtensions<T> on Iterable<T> {
  Iterable<T> distinctBy(Object Function(T e) getKey) {
    final keys = <Object>{};
    return where((element) => keys.add(getKey(element)));
  }
}
