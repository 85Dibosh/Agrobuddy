import 'package:flutter_test/flutter_test.dart';
import 'package:agrobuddy/main.dart';

void main() {
  testWidgets('AgroBuddy smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const AgroBuddyApp());

    // Verify splash screen renders title
    expect(find.text('AgroBuddy'), findsWidgets);

    // Pump past the 2-second splash timer to settle timers and transition
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    // Verify landing on the single Google Login screen
    expect(find.text('Continue with Google'), findsOneWidget);
  });
}
