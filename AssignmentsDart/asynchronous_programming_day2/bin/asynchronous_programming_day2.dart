import 'package:asynchronous_programming_day2/asynchronous_programming_day2.dart'
    as asynchronous_programming_day2;

void main(List<String> arguments) async {
  // print('Hello world: ${asynchronous_programming_day2.calculate()}!');

  print(await getAdderss());
  print(await getCityName());
  print(await getUserName());
}

Future<String> getAdderss() async {
  return 'myAddress';
}

Future<String> getUserName() => Future.value('Immanuel');

Future<String> getCityName() =>
    Future.delayed(Duration(seconds: 5), () => 'UB-City - 666');
