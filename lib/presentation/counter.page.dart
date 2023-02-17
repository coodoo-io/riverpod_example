import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/presentation/counter.controller.dart';

class CounterPage extends ConsumerWidget {
  const CounterPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ref.watch(counterControllerProviderProvider).when(
        data: (data) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                Text(
                  '$data',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
          );
        },
        error: (error, stackTrace) {
          return Text(error.toString());
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref
            .read(counterControllerProviderProvider.notifier)
            .incrementCounter(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
