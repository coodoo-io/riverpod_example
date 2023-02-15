import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'counter.controller.g.dart';

@riverpod
class CounterControllerProvider extends _$CounterControllerProvider {
  @override
  FutureOr<int> build() {
    return 0;
  }

  void incrementCounter() async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(milliseconds: 1000));
    state = AsyncValue.data(state.value! + 1);
  }
}
