import 'package:zero_app/providers/attendace_provider.dart';
import 'package:zero_app/providers/login_provider.dart';
import 'package:zero_app/screens/home_screen.dart';
import 'package:zero_app/screens/review_screen.dart';
import 'package:zero_app/screens/setting_screen.dart';
import 'package:zero_app/screens/sync_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:zero_app/services/attendance_services.dart';
import 'package:zero_app/utils/noti_handler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotiHandler.requestPermission();
  AttendanceService.configDio();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => AttendanceProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => LoginProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    NotiHandler.configNotificationSetting(context);
    super.initState();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //<FOR THE BREAKPOINTS IN EVERY DEVICES>//
      builder: (context, child) => ResponsiveWrapper.builder(
        BouncingScrollWrapper(child: child!),
        maxWidth: 1200,
        minWidth: 450,
        defaultScale: true,
        breakpoints: [
          const ResponsiveBreakpoint.resize(560, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.autoScale(1000, name: TABLET),
          const ResponsiveBreakpoint.resize(1200, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: "4K"),
        ],
      ),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Inter, Poppins',
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.white),
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          color: Color.fromARGB(255, 9, 50, 111),
        ),
      ),
      home: const HomePage(),
    );
  }
}

//Real Drawer
class RealDrawer extends StatelessWidget {
  //
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 9, 50, 111),
          ),
          child: Center(
              child: Text(
            'Sample',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.w800),
          )),
        ),
        ListTile(
          title: const Text('Home Page',
              style: TextStyle(
                  fontFamily: 'Poppins', fontWeight: FontWeight.w600)),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
        ),
        ListTile(
          title: const Text(
            'Sync Page',
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SyncPage()),
            );
          },
        ),
        ListTile(
          title: const Text(
            'Setting Page',
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingPage()),
            );
          },
        ),
        ListTile(
          title: const Text(
            'Review Page',
            style:
                TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w600),
          ),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ReviewPage()),
            );
          },
        ),
      ],
    ));
  }
}
