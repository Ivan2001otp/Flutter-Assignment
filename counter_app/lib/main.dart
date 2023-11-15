import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(
    child: MaterialApp(
      theme: ThemeData(primarySwatch: Colors.purple),
      home: CounterPage(),
    ),
  ));
}

class CounterPage extends ConsumerStatefulWidget {
  const CounterPage({super.key});

  @override
  ConsumerState createState() => _CounterPageState();
}

final counterValue = StateProvider<int>((ref) {
  return 0;
});

class _CounterPageState extends ConsumerState {
  int _counterValue = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        return Scaffold(
            floatingActionButton: FloatingActionButton(
                child: Icon(
                  Icons.add,
                  size: 30,
                ),
                onPressed: () {
                  ref.read(counterValue.notifier).state++;
                }),
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${ref.watch(counterValue)}',
                    style: TextStyle(fontSize: 50),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      if (ref.read(counterValue).toInt() > 0) {
                        ref.read(counterValue.notifier).state--;
                      }
                    },
                    child: Icon(
                      Icons.unfold_less_rounded,
                      size: 30,
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }
}
