import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/welcome_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/home_screen.dart';
import 'screens/upload_screen.dart';
import 'screens/resource_details_screen.dart';
import 'screens/store_screen.dart';
import 'screens/profile_screen.dart';
import 'models/resource.dart';
import 'data/demo_data.dart';

class ExamShareApp extends StatefulWidget {
  const ExamShareApp({super.key});

  @override
  State<ExamShareApp> createState() => _ExamShareAppState();
}

class _ExamShareAppState extends State<ExamShareApp> {
  Locale _locale = const Locale('ar');

  void _updateLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ExamShare TN',
      debugShowCheckedModeBanner: false,
      locale: _locale,
      supportedLocales: const [Locale('ar'), Locale('fr')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F6F6),
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD71920),
          primary: const Color(0xFFD71920),
          secondary: const Color(0xFFC8A25C),
          brightness: Brightness.light,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFD71920),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
      ),
      builder: (context, child) {
        final direction = _locale.languageCode == 'ar'
            ? TextDirection.rtl
            : TextDirection.ltr;

        return Directionality(
          textDirection: direction,
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: WelcomeScreen(onLocaleChanged: _updateLocale, locale: _locale),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key, required this.locale, required this.onLocaleChanged});

  final Locale locale;
  final void Function(Locale) onLocaleChanged;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(locale: widget.locale, onLocaleChanged: widget.onLocaleChanged),
      UploadScreen(locale: widget.locale),
      StoreScreen(locale: widget.locale),
      ProfileScreen(locale: widget.locale),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: const Color(0xFFD71920),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.upload_file_rounded), label: 'رفع'),
          BottomNavigationBarItem(icon: Icon(Icons.store_rounded), label: 'المتجر'),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: 'حسابي'),
        ],
      ),
    );
  }
}

void showDemoOnlySnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

bool isArabic(Locale locale) => locale.languageCode == 'ar';

String getLocalizedString(Locale locale, String arabic, String french) {
  return locale.languageCode == 'fr' ? french : arabic;
}

final List<Resource> demoResources = demoResourceList;
