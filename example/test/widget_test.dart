import 'package:flutter_test/flutter_test.dart';
import 'package:example/main.dart';

void main() {
  testWidgets('Indonesian Soundbox Demo App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const IndonesianSoundboxDemoApp());
    expect(find.text('Soundbox Indonesia (TTS)'), findsOneWidget);
    expect(find.text('Putar Suara (Speak)'), findsOneWidget);
  });
}
