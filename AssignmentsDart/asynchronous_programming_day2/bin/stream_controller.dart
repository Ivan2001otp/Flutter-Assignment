import 'dart:async';

void main() async {
  //less abstract,
  //defines approaches to add item in streams
  //stream controller - read&write
  //stream is read only.
  final controller = StreamController();
  controller.sink.add('hi');
  controller.sink.add('hello');

  await for (final val in controller.stream) {
    print(val);
  }

  controller.close();
}

class ToUpperCase extends StreamTransformerBase<String, String> {
  @override
  Stream<String> bind(Stream<String> stream) {
    return stream.map(
      (name) => name.toUpperCase(),
    );
  }
}
