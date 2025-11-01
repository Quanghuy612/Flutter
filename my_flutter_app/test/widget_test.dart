import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:my_flutter_app/main.dart';
import 'package:my_flutter_app/app_state.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(
        create: (_) => ApplicationState(),
        child: const App(),
      ),
    );

    // Add your test expectations here if needed.
    expect(find.byType(App), findsOneWidget);
  });
}
