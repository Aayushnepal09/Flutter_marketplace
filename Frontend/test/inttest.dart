


// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main()  {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();
//   testWidgets('login user', (WidgetTester tester) async {
//     await tester.pumpWidget(ProviderScope(
//       child: ScreenUtilInit(
//           designSize: const Size(360, 690),
//           minTextAdapt: true,
//           splitScreenMode: true,
//           builder: (context, child) {
//             return MaterialApp(
//               debugShowCheckedModeBanner: false,
//               title: 'Flutter for class',
//               initialRoute: LoginPage.route,
//               theme: getaApplicationTheme(),
//               routes: getAppRoutes,
//             );
//           }),
//     ));
//     await tester.pumpAndSettle(const Duration(seconds: 5));
//     Finder loginbtn = find.byType(ElevatedButton);
