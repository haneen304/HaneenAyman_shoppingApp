import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:aesthetic_shop/main.dart';
import 'package:aesthetic_shop/models/product.dart';
import 'package:aesthetic_shop/localization/app_localizations.dart';

void main() {
  testWidgets('Full app widget test: Welcome -> HomeScreen -> Add to Cart', (
    WidgetTester tester,
  ) async {
    // Launch the app
    await tester.pumpWidget(const MyApp());
    await tester.pumpAndSettle();

    // Get localization instance
    final BuildContext context = tester.element(find.byType(MaterialApp));
    final loc = AppLocalizations.of(context)!;

    // Verify WelcomeScreen loads
    expect(find.text(loc.welcomeIntro), findsOneWidget);

    // Verify Sign In button exists
    final signInButton = find.widgetWithText(ElevatedButton, loc.signIn);
    expect(signInButton, findsOneWidget);

    // Verify Sign Up button exists
    final signUpButton = find.widgetWithText(OutlinedButton, loc.signUp);
    expect(signUpButton, findsOneWidget);

    // Tap Sign In (navigates to HomeScreen)
    await tester.tap(signInButton);
    await tester.pumpAndSettle();

    // Verify HomeScreen loads (by checking featured product titles)
    for (var product in featured) {
      expect(find.text(loc.translate(product.id)), findsWidgets);
    }

    // Grid products: check display and add-to-cart
    for (var product in products) {
      expect(find.text(loc.translate(product.id)), findsWidgets);

      final gridButton = find.descendant(
        of: find.widgetWithText(Card, loc.translate(product.id)),
        matching: find.byIcon(Icons.add_shopping_cart),
      );
      expect(gridButton, findsOneWidget);

      await tester.tap(gridButton);
      await tester.pump();

      expect(find.text(loc.addedToCart), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 1));
    }

    // Hot offers: check display and add-to-cart
    for (var offer in offers) {
      expect(find.text(loc.translate(offer.id)), findsWidgets);

      final offerCard = find.byWidgetPredicate(
        (widget) =>
            widget is Card &&
            widget.child != null &&
            widget.child.toString().contains(loc.translate(offer.id)),
      );
      final offerButton = find.descendant(
        of: offerCard,
        matching: find.byIcon(Icons.add_shopping_cart),
      );
      expect(offerButton, findsOneWidget);

      await tester.tap(offerButton);
      await tester.pump();

      expect(find.text(loc.addedToCart), findsOneWidget);
      await tester.pumpAndSettle(const Duration(seconds: 1));
    }

    // Navigate back to WelcomeScreen
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Verify we are back on WelcomeScreen
    expect(find.text(loc.welcomeIntro), findsOneWidget);
  });
}
