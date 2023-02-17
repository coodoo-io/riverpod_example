// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:riverpod_example/data/repositories/counter.repository.dart';
import 'package:riverpod_example/domain/repository/counter.repository.interface.dart';
import 'package:riverpod_example/main.dart';

class MockCounterRepoProvider extends Mock implements CounterRepoProvider {}

class OwnMockCounterRepoProvider extends CounterRepoProviderInterface {
  @override
  Future<int> increment(int old) {
    return Future.value(10);
  }
}

void main() {
  late ProviderContainer providerContainer;
  late MockCounterRepoProvider counterRepoProvider;
  late OwnMockCounterRepoProvider ownMock;

  setUpAll(() async {
    counterRepoProvider = MockCounterRepoProvider();
    ownMock = OwnMockCounterRepoProvider();

    when(() => counterRepoProvider.increment(any()))
        .thenAnswer((invocation) => Future.value(10));
    WidgetsFlutterBinding.ensureInitialized();
    providerContainer = ProviderContainer(
        overrides: [counterrepoProvider.overrideWith((ref) => ownMock)]);
  });

  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(UncontrolledProviderScope(
        container: providerContainer, child: const MyApp()));

    await tester.pumpAndSettle();
    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pumpAndSettle();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('10'), findsOneWidget);
  });
}
