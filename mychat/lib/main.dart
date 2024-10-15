import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychat/features/chat/data/models/chat_model.dart';
import 'package:mychat/features/chat/presentation/pages/country_page.dart';
import 'package:mychat/features/chat/presentation/pages/home_screen.dart';
import 'package:mychat/features/chat/presentation/pages/login_screen.dart';
import 'package:mychat/features/chat/presentation/pages/new_group_screen.dart';
import 'package:mychat/features/chat/presentation/pages/select_contact_screen.dart';
import 'package:mychat/features/chat/presentation/pages/signin_screen.dart';
import 'package:mychat/features/chat/presentation/pages/wellcome_screen.dart';
import 'package:mychat/features/chat/presentation/widget/camera_plugin.dart';

Future<void>  main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: (settings) {
        switch (settings.name) {

          case '/wellcome':
            return _createRoute( WellcomeScreen());
          // case '/login':
          //   return _createRoute(const LoginScreen());
          case '/login':
            return _createRoute(const SigninScreen());
          
          case '/home':
          final args = settings.arguments as ChatModel;
          final chatModels = settings.arguments as List<ChatModel>;
            return _createRoute(HomeScreen(sourceChat: args , chatModels: chatModels));
          case '/selectcontact':
            return _createRoute(const SelectContactScreen());
          case '/newgroup':
            return _createRoute(const NewGroupScreen()); 
          case '/camera':
            return _createRoute(const CameraPlugin());
          
          default:
            return null;
        }
      },
      initialRoute: '/wellcome',
      title: 'My Chat app',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryColor: const Color(0xFF16325B),
        scaffoldBackgroundColor:
            Color(0xff78b7d0), // For white background across the app
        secondaryHeaderColor: Color(0xFFFFF0D1), // Secondary color as white
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF16325B),
          foregroundColor: Color(0xff78b7d0), // App Bar icons color
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all<Color>(const Color(0xFF16325B)), // Button color
            foregroundColor: WidgetStateProperty.all<Color>(Color(0xff78b7d0)),
            // Button text color
          ),
        ),
        popupMenuTheme: const PopupMenuThemeData(
          color: Colors.white, // Popup menu color
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF16325B),
          foregroundColor: Color(0xff78b7d0),
          // Floating action button color
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Color(0xff78b7d0), // Selected tab color
          unselectedLabelColor:
              Colors.grey, // Unselected tabs color (Status, Calls)
        ),
        // Using Material 3's color scheme with a custom seed color
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF16325B), // Primary green color as seed
          primary: Colors.black,
          // Text color on primary
          // Secondary (for contrasts and accents)
          secondary: const Color(0xFF16325B), // Ensure primary is consistent
        ),

        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

PageRouteBuilder _createRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeIn;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
