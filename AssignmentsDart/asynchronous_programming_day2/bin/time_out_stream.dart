import 'dart:async';

class TimeoutBetweenEvents<E> extends StreamTransformerBase<E, E> {
  final Duration duration;

  const TimeoutBetweenEvents({required this.duration});

  @override
  Stream<E> bind(Stream<E> stream) {
    // TODO: implement bind

    StreamController<E>? controller;
    StreamSubscription<E>? subscription;

    Timer? timer;

    controller = StreamController(onListen: () {
      subscription = stream.listen((event) {
        (data) {
          timer?.cancel();
          timer = Timer.periodic(duration, (timer) {
            controller?.addError(
              TimeoutBetweenEventsException('Timeout'),
            );
          });
          controller?.add(data);
        };
      });
    }, onCancel: () {
      subscription?.cancel();
      timer?.cancel();
    });

    return controller.stream;
  }
}

class TimeoutBetweenEventsException implements Exception {
  final String message;
  TimeoutBetweenEventsException(this.message);
}
