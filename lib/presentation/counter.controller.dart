import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_example/data/repositories/counter.repository.dart';

part 'counter.controller.g.dart';

@Riverpod(keepAlive: false)
class CounterControllerProvider extends _$CounterControllerProvider {
  @override
  FutureOr<int> build() {
    return 0;
  }

  void incrementCounter() async {
    state = const AsyncValue.loading();
    var data = await ref.read(counterrepoProvider).increment(state.value!);
    state = AsyncValue.data(data);
  }
}
