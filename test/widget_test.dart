import 'package:flutter_test/flutter_test.dart';

import 'package:fittrack/app/app_controller.dart';
import 'package:fittrack/app/fitness_app.dart';

void main() {
  testWidgets('FitnessApp shows home greeting', (WidgetTester tester) async {
    AppController().initialize();
    await tester.pumpWidget(const FitnessApp());
    await tester.pumpAndSettle();

    expect(find.textContaining('Hey'), findsOneWidget);
  });
}
