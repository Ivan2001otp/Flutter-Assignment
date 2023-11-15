import 'dart:async';

void main() async {
  await for (final name in getNames().absorbErrorsUsingHandlerError()) {
    print(name);
  }
  print('\n');
  await for (final name in getNames().absorbErrorsUsingHandler()) {
    print(name);
  }
  print('\n');
  await for (final name in getNames().absorbErrorsUsingTransformer());
}

extension AbsorbErrors<T> on Stream<T> {
  //type1
  Stream<T> absorbErrorsUsingHandlerError() => handleError(
        (_, __) {},
      );

  //type2
  Stream<T> absorbErrorsUsingHandler() =>
      transform(StreamTransformer.fromHandlers(
        handleError: (error, stackTrace, sink) => sink.close(),
      ));

  Stream<T> absorbErrorsUsingTransformer() => transform(StreamErrorAbsorber());
}

Stream<String> getNames() async* {
  yield 'John';
  yield 'Hello';
  yield 'Yoho';

  throw ('Hello !');
}

class StreamErrorAbsorber<T> extends StreamTransformerBase<T, T> {
  @override
  Stream<T> bind(Stream<T> stream) {
    // TODO: implement bind
    final controller = StreamController<T>();

    stream.listen(
      controller.sink.add,
      onError: (_) {},
      onDone: controller.close,
    );

    return controller.stream;
  }
}
