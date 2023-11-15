void main(List<String> arguments) async {
  //stream is consumed by using await-for

  await for (final i in getNumbers()) {
    print(i);
  }
  try {
    await for (final name in getRandomName()) {
      print(name);
    }
  } catch (err) {
    print(err);
  }
}

Stream<int> getNumbers() async* {
  for (var i = 0; i < 3; i++) {
    await Future.delayed(
      Duration(seconds: 1),
    );
    yield i;
  }
}

Stream<String> getRandomName() async* {
  await Future.delayed(
    Duration(seconds: 2),
  );
  yield 'hello world';
  throw Exception('Random message');
}
