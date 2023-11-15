void main() async {
  final sum = await getAllAges().reduce((a, b) => a + b);
  print(sum);
}

int add(int a, int b) => a + b;
Stream<int> getAllAges() async* {
  yield 1;
  yield 2;
  yield 3;
  yield 4;
  yield 5;
  yield 6;
  yield 7;
}
