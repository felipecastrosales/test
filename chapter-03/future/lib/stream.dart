Stream<String> get streamList async* {
  yield 'felipe';
  await Future.delayed(const Duration(milliseconds: 500));
  yield '07';
}
