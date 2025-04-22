// import 'package:flutter/material.dart';
// import '../modules/welcome_screen/login_screen/login.dart';
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   bool _animationStarted = false;
//   double _logoSize = 150.0;
//
//   @override
//   void initState() {
//     super.initState();
//     Future.delayed(Duration(seconds: 1), () {
//       setState(() {
//         _animationStarted = true;
//         //_logoSize = 100.0; // تصغير حجم اللوجو أثناء الحركة
//       });
//
//       Future.delayed(Duration(seconds: 1), () {
//         Navigator.pushReplacement(
//           context,
//           PageRouteBuilder(
//             transitionDuration: Duration(milliseconds: 800),
//             pageBuilder: (_, __, ___) => LoginScreen(showLogo: true),
//             transitionsBuilder: (_, animation, __, child) {
//               return FadeTransition(
//                 opacity: animation,
//                 child: child,
//               );
//             },
//           ),
//         );
//       });
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Stack(
//         children: [
//           AnimatedPositioned(
//             duration: Duration(seconds: 1),
//             curve: Curves.easeInOut,
//             top: _animationStarted
//                 ? 50.0 // الانتقال لأعلى
//                 : MediaQuery.of(context).size.height / 2 - _logoSize/2,
//             left: _animationStarted
//                 ? MediaQuery.of(context).size.width - _logoSize - 30.0 // الانتقال لليمين
//                 : MediaQuery.of(context).size.width / 2 - _logoSize/2,
//             child: AnimatedContainer(
//               duration: Duration(seconds: 1),
//               width: _logoSize,
//               height: _logoSize,
//               child: Image.asset(
//                 "Assets/logo_login_screen.png",
//                 fit: BoxFit.contain,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }