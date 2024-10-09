import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mychat/features/chat/data/models/chat_model.dart';
import 'package:mychat/features/chat/presentation/pages/home_screen.dart';
import 'package:mychat/features/chat/presentation/pages/login_screen.dart';
import 'package:mychat/features/chat/presentation/pages/new_group_screen.dart';
import 'package:mychat/features/chat/presentation/pages/select_contact_screen.dart';
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
          case '/login':
            return _createRoute(const LoginScreen());
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
      initialRoute: '/login',
      title: 'My Chat app',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(),
        primaryColor: const Color(0xFF075E54),
        scaffoldBackgroundColor:
            Colors.white, // For white background across the app
        secondaryHeaderColor: Colors.white, // Secondary color as white
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF075E54),
          foregroundColor: Colors.white, // App Bar icons color
        ),
        popupMenuTheme: const PopupMenuThemeData(
          color: Colors.white, // Popup menu color
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF075E54),
          foregroundColor: Colors.white,
          // Floating action button color
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white, // Selected tab color
          unselectedLabelColor:
              Colors.grey, // Unselected tabs color (Status, Calls)
        ),
        // Using Material 3's color scheme with a custom seed color
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF075E54), // Primary green color as seed
          primary: Colors.white,
          // Text color on primary
          // Secondary (for contrasts and accents)
          secondary: const Color(0xFF075E54), // Ensure primary is consistent
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
