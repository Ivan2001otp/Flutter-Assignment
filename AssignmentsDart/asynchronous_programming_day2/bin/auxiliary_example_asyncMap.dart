void main() async {
  final names3Times = await getNames().asyncExpand(
    (name) => generateThreetimes(name),
  );

  await for (final n in names3Times) {
    print(n);
  }
}

Stream<String> getNames() async* {
  yield 'Gary';
  yield 'Hello';
  yield 'Harry';
}

Stream<String> generateThreetimes(String val) =>
    Stream.fromIterable(Iterable.generate(3, (_) => val));
