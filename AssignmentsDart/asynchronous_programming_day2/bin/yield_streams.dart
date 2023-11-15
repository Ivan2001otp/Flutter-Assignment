import 'dart:async';

void main() async {
  /*
  await for (final i in maleNames()) {
    print(i);
  }

  await for (final i in femaleNames()) {
    print(i);
  }
  */
  await for (final i in allNames()) {
    print(i);
  }
}

Stream<String> femaleNames() async* {
  yield 'Ivana';
  yield 'Barbie';
  yield 'Tartarusz';
}

Stream<String> maleNames() async* {
  yield 'Gary';
  yield 'Famy';
}

Stream<String> allNames() async* {
  yield* femaleNames();
  yield* maleNames();
}
