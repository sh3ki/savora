import 'package:flutter_test/flutter_test.dart';
import 'package:savora/main.dart';

void main() {
  testWidgets('Savora smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const SavoraApp());
    expect(find.byType(SavoraApp), findsOneWidget);
  });
}
