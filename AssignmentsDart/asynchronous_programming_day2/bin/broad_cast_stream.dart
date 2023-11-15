import 'dart:async';
import 'dart:math';

import 'stream_transformers.dart';

void main() async {
  await broadCastStreamExample();
}

Future<void> broadCastStreamExample() async {
  late final StreamController<String> controller;

  controller = StreamController<String>.broadcast();

  final sub1 = controller.stream.listen((name) {
    print('sub1 : $name');
  });

  final sub2 = controller.stream.listen((name) {
    print('sub2 : $name');
  });

  final sub3 = controller.stream.listen((event) {
    print('sub3 : $event');
  });

  controller.sink.add('darick');
  controller.sink.add('ivan');
  controller.sink.add('joel');

  controller.onCancel = () {
    sub1.cancel();
    sub2.cancel();
    sub3.cancel();
  };
}
