import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/domain/repository/counter.repository.interface.dart';

Provider<CounterRepoProviderInterface> counterrepoProvider =
    Provider<CounterRepoProviderInterface>((ref) => CounterRepoProvider());

class CounterRepoProvider extends CounterRepoProviderInterface {
  @override
  Future<int> increment(int old) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    return ++old;
  }
}
