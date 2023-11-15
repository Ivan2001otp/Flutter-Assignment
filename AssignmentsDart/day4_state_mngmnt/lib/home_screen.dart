import 'package:day4_state_mngmnt/User.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import './main.dart';

//use of FutureProvider.
class HomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TODO: implement build
    /*
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Center(
            child: Text(''),
          )
        ],
      ),
    );
    */

    return Scaffold(
      body: ref.watch(streamProvider).when(data: (data) {
        return Center(
          child: Text(data.toString()),
        );
      }, error: (error, StackTrace) {
        return Center(
          child: Text(error.toString()),
        );
      }, loading: () {
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
    );

/*
  --- use of futureProvider.
    return ref.watch(fetchUserProvider).when(data: (data) {
      return Scaffold(
        body: Center(
          child: Text('data'),
        ),
      );
    }, error: (error, StackTrace) {
      return Scaffold(
        body: Center(
          child: Text(error.toString()),
        ),
      );
    }, loading: () {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    });

    */
  }
}

//ref helps to act as dependency injection.
final userRepositoryProvider = Provider((ref) => UserRepository());

class UserRepository {
  Future<User> fetchUserData() {
    const url = 'https://jsonplaceholder.typicode.com/users/1';
    return http.get(Uri.parse(url)).then((value) => User.fromJson(value.body));
  }
}

/*
-- use of stateProvider and StateProviderNotifier.
class HomePage extends ConsumerWidget {
  void onSubmit(WidgetRef ref, String value) {
    //State-Provider.
    // ref.read(nameProvider.notifier).update((state) => value);
    // ref.read(nameProvider.notifier).state = value;

    final user = ref.read(nameProvider.notifier);
    user.updateName(value);
  }

  void onSubmitAge(WidgetRef ref, String val) {
    final user = ref.read(nameProvider.notifier);
    user.updateAge(int.parse(val));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(nameProvider) as User; //explicit conversion

    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text(user.age.toString()),
        ),
        body: Column(
          children: [
            TextField(
              onSubmitted: (value) {
                onSubmit(ref, value);
              },
            ),
            TextField(
              onSubmitted: (value) {
                onSubmitAge(ref, value);
              },
            ),
            Center(
              child: Text(
                user.name.toString(),
                style: TextStyle(fontSize: 40),
              ),
            )
          ],
        ));
  }
}
*/

/*
class MyWidget extends ConsumerStatefulWidget {
  const MyWidget({super.key});

  @override
  ConsumerState<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<MyWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Center(
              child: Text(
                ref.watch(nameProvider),
                style: TextStyle(fontSize: 40),
              ),
            )
          ],
        ));
  }
}

//use ConsumerWidget
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Consumer(builder: (context, ref, child) {
        final myName = ref.watch(nameProvider);

        return Column(
          children: [
            Center(
              child: Text(
                myName,
                style: TextStyle(fontSize: 40),
              ),
            )
          ],
        );
      }),
    );
  }
}
*/
