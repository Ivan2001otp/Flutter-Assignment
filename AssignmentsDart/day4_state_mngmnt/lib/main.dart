import 'package:day4_state_mngmnt/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import './home_screen.dart';
import 'package:riverpod/riverpod.dart';

final fetchUserProvider =
    FutureProvider((ref) => ref.watch(userRepositoryProvider));
void main() {
//  runApp(ProviderScope(child: MyApp()));
  runApp(ProviderScope(child: MyApp()));
}

// final nameProvider = Provider<String>((ref) => 'RiverPod');
/*
final nameProvider = StateProvider<String>((ref) {
  return 'Hiver';
});
*/

final nameProvider =
    /*state*/
    StateNotifierProvider<UserNotifier, User>((ref) => UserNotifier(
          const User(name: '', age: 0),
        ));

final streamProvider = StreamProvider.autoDispose((ref) async* {
  //helps to return stream values
  yield [1, 2, 3, 4, 5, 6, 7, 8, 9];
});

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Flutter Riverpod',
      home: HomePage(),
    );
  }
}
