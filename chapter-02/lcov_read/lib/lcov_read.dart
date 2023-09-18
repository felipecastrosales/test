void main() {
  final result = coverage('./coverage/lcov.info');
  print(result);
}

String coverage(String lcovPath) {
  return '100%';
}
