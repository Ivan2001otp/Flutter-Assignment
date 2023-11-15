void main(List<String> args) async {
  final allNames = await getAllNames().toList();
  for (var n in allNames) {
    print(n);
  }
}

Stream<String> getAllNames() async* {
  yield 'abc';
  yield 'def';
  yield 'fgh';
}
