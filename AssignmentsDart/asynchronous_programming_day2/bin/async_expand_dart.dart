//sequence of streams
void main() async {
  await for (final ch in getNames().asyncExpand(
    (values) => getCharacters(values),
  )) {
    print(ch);
  }
}

Stream<String> getCharacters(String fromString) async* {
  for (var i = 0; i < fromString.length; i++) {
    await Future.delayed(Duration(seconds: 1));
    yield fromString[i];
  }
}

Stream<String> getNames() async* {
  await Future.delayed(Duration(seconds: 1));
  yield ('Hi');
  await Future.delayed(Duration(seconds: 2));
  yield ('Hello');
}
