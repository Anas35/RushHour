class Pair<T> {
  final T first;
  final T last;

  Pair(this.first, this.last);

  @override
  String toString() => '[$first, $last]';
}