import 'dart:async';
import 'stream_transformers.dart';

void main() async {
  final result = await getNames()
      .asyncMap(
    (name) => extractCharacters(name),
  )
      .fold('', (previous, element) {
    final elements = element.join(' ');
    return '$previous - $elements ';
  });

  print(result);
}

Stream<String> getNames() async* {
  yield 'John';
  yield 'Jane';
  yield 'Racchel';
}

Future<List<String>> extractCharacters(String from) async {
  final chars = <String>[];
  for (final char in from.split('')) {
    await Future.delayed(Duration(milliseconds: 500));
    chars.add(char);
  }
  return chars;
}
