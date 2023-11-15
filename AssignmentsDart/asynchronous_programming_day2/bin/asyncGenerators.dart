void main() async {
  await for (final i in numberGenerators()) {
    print(i);
  }

  await for (final i in numberGenerators(start: 0, end: 10, f: evenNums)) {
    print(i);
  }

  await for (final i in numberGenerators(start: 1, end: 8, f: oddNums)) {
    print(i);
  }
}

typedef isIncluded = bool Function(int value);

bool evenNums(int val) => val % 2 == 0;
bool oddNums(int val) => val % 2 != 0;

Stream<int> numberGenerators({
  int start = 0,
  int end = 4,
  isIncluded? f,
}) async* {
  for (var i = start; i < end; i++) {
    if (/*f?.call(i) == true*/ f == null || f(i)) {
      //if the funciton is callable.
      yield i;
    }
  }
}
