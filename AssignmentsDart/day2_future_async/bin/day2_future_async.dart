import 'package:day2_future_async/day2_future_async.dart' as day2_future_async;
import 'dart:async';
import 'dart:io';

const String fakeUrl = 'https://fakestoreapi.com/products';
List<String> urls = [
  'https://fakestoreapi.com/products',
  'https://fakestoreapi.com/carts',
  'https://fakestoreapi.com/users'
];

// 1.Write a function that downloads a list of URLs asynchronously and returns a list of the downloaded contents.

class Dummy {
  int id;
  String title;
  double price;
  String description;
  String category;
  String imageUrl;

  factory Dummy(int id, String title, double price, String desc,
      String category, String image) {
    return Dummy._internal(id, title, price, desc, category, image);
  }

  Dummy._internal(this.id, this.title, this.price, this.description,
      this.category, this.imageUrl);
}

Future<List<String>> fetchUrls(List<String> urls) async {
  /*
  List<Future<String>> futureList = urls
      .map((element) {
        HttpClient()
            .getUrl(Uri.parse(element))
            .then((value) => value.toString());
      })
      .cast<Future<String>>()
      .toList();*/

  List<Future<String>> futureList = urls
      .map((e) =>
          HttpClient().getUrl(Uri.parse(e)).then((value) => value.toString()))
      .toList();

  List<String> finalResponse = await Future.wait(futureList);
  return finalResponse;
}

// 2.Write a function that takes a list of asynchronous tasks and returns a Future that completes when all of the tasks have completed.
/*
List<Future<void>> tasks = [
  Future.delayed(Duration(seconds: 3)),
  Future.delayed(Duration(seconds: 5)),
  Future.delayed(Duration(seconds: 7)),
];

Future<void> awaitAll(List<Future<void>> tasks) async {
  Completer<void> completer = Completer<void>();

  int countTasks = 0;

  for (Future<void> task in tasks) {
    task.then((value) {
      //called when the task is completed - onValue calllback.
      countTasks++;
      print('completed $countTasks task\n');

      if (countTasks == tasks.length) {
        completer.complete();
      }
    });
  }

  return completer.future;
}
*/

List<Future<void>> tasks = [
  Future.delayed(Duration(seconds: 3)),
  Future.delayed(Duration(seconds: 6)),
  Future.delayed(Duration(seconds: 9)),
];

Future<void> getTasksDoneinSequence(List<Future<void>> tasks) async {
  Completer<void> completer = Completer<void>();

  int count = 0;

  for (Future<void> t in tasks) {
    t.then((value) {
      count++;
      print('task-$count completed\n');

      if (count == tasks.length) {
        completer.complete();
      }
    });
  }

  return completer.future;
}

// 3.Write a function that takes a list of asynchronous tasks and returns a Future that completes when any of the tasks complete.
Future<void> awaitAny(List<Future<void>> tasks) async {
  Completer<void> completer = Completer<void>();

  for (Future<void> task in tasks) {
    task.then((value) {
      print('executed\n');
      completer.complete();
    });
  }

  completer.future;
}

Future<void> delayWork() async {
  Future.delayed(Duration(seconds: 10));
  print('terminated');
}

void cancellableFuture(Future<void> future) {
  /*
    CancelableOperation cancelableOperation = CancelableOperation
    .fromFuture(longOne, onCancel: () {
      print("cancel called");
    });
    cancelableOperation.cancel();
   */
}

Future<T> retry<T>(Future<T> future, Duration interval, int maxTries) async {
  int retries = 0;

  while (retries < maxTries) {
    try {
      return await future;
    } catch (error) {
      retries++;
      //wait for specific time
      await Future.delayed(interval);
    }
  }

  throw Exception('Something went wrong!');
}

Future<String> fetchUrl(String url) async {
  Completer<String> completer = Completer();
  String? response;

  await HttpClient()
      .getUrl(Uri.parse(url))
      .then((value) => response = value.toString());
  if (response != null) {
    return Future<String>.value(response);
  }

  throw Exception('Failed to fetch url\n');
}

void main() async {
  /*
  1.
  try {
    Future<List<String>> l1 = fetchUrls(urls);
    List<String> response = await l1;

    for (String content in response) {
      print('printed\n');
      print(content);
      print('\n');
    }
  } catch (err) {
    // throw Exception('Something happened');
    print(err.toString());
  } finally {
    print('terminated!');
  }
  */

  // await awaitAll(tasks);1
  // await getTasksDoneinSequence(tasks);2
  // try {3
  //   await awaitAny(tasks);
  // } catch (err) {
  //   throw Exception(err.toString());
  // }

  // delayWork();4

  //5.
  /*Future<void> future = Future.delayed(Duration(seconds: 10));
  cancellableFuture(future);
  */
  final result =
      await retry<String>(fetchUrl(urls[0]), Duration(seconds: 4), 3);
  print(result);
}
