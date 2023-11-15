void main(List<String> arguments) async {
  int length = await getDesiredString().then((value) => getStringLength(value));

  print(length);
}

Future<String> getDesiredString() =>
    Future.delayed(Duration(seconds: 2), () => 'Immanuel Dsouza');

Future<int> getStringLength(String res) {
  return Future.value(res.length);
}
