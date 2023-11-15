import 'dart:async';

void main() async {
  await for (final n in names.capitalized) {
    print(n);
  }

  await for (final n in names.capitalized.capitalizedByTransformer) {
    print(n);
  }
}

extension on Stream<String> {
  Stream<String> get capitalized => map((event) => event.toUpperCase());
  Stream<String> get capitalizedByTransformer => transform(ToUpperCase());
}

Stream<String> names = Stream.fromIterable(['Seth', 'Henry', 'Peter']);

class ToUpperCase extends StreamTransformerBase<String, String> {
  @override
  Stream<String> bind(Stream<String> stream) {
    return stream.map(
      (name) => name.toUpperCase(),
    );
  }
}
