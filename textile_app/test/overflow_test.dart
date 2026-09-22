import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:textile_app/app/theme/app_theme.dart';
import 'package:textile_app/views/buyer/buyer_home_screen.dart';

void main() {
  testWidgets('Check for overflow in BuyerHomeScreen and Tabs', (WidgetTester tester) async {
    // Set screen size to a standard small mobile device (360x640)
    // This is small enough to aggressively trigger any potential layout overflows.
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1.0;
    
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // Pump the BuyerHomeScreen wrapped in GetMaterialApp to provide routing and theme
    await tester.pumpWidget(
      GetMaterialApp(
        theme: AppTheme.lightTheme,
        home: const BuyerHomeScreen(),
      ),
    );
    
    // Wait for animations and layout to finish
    await tester.pumpAndSettle();
    
    // If there is any RenderFlex overflow in the HomeTab, the test will automatically fail here!

    // Now let's switch to the Categories tab to check for overflows in the grid view
    // There are two "Categories" texts (one in tab bar, one in the section header)
    // The bottom navigation bar uses icons and labels, we can tap by finding the icon
    await tester.tap(find.byIcon(Icons.category_outlined));
    await tester.pumpAndSettle();

    // If there is any RenderFlex overflow in the CategoriesTab, the test will automatically fail here!
    
    // Test passes if we reach here with no layout exceptions!
  });
}
