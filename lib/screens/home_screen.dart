import 'package:flutter/material.dart';

import '../app.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
    required this.locale,
    required this.onLocaleChanged,
  });

  final Locale locale;
  final void Function(Locale) onLocaleChanged;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabicLocale = isArabic(widget.locale);

    return Scaffold(
      appBar: AppBar(title: Text(isArabicLocale ? 'تسجيل الدخول' : 'Connexion')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.account_circle_rounded, size: 90, color: Color(0xFFD71920)),
              const SizedBox(height: 20),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return isArabicLocale ? 'أدخل بريدك الإلكتروني' : 'Entrez votre email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: isArabicLocale ? 'البريد الإلكتروني' : 'Email',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return isArabicLocale ? 'الحد الأدنى 6 أحرف' : 'Minimum 6 caractères';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: isArabicLocale ? 'كلمة المرور' : 'Mot de passe',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDemoOnlySnackBar(
                        context,
                        isArabicLocale
                            ? 'وضع تجريبي: تسجيل الدخول غير متصل بالخادم.'
                            : 'Mode démo : connexion non connectée au backend.',
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD71920),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    isArabicLocale ? 'دخول' : 'Se connecter',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 18),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (_) => RegisterScreen(
                        locale: widget.locale,
                        onLocaleChanged: widget.onLocaleChanged,
                      ),
                    ),
                  );
                },
                child: Text(
                  isArabicLocale ? 'ليس لديك حساب؟ إنشاء حساب' : 'Pas de compte ? Créer un compte',
                  style: const TextStyle(
                    color: Color(0xFFD71920),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({
    super.key,
    required this.locale,
    required this.onLocaleChanged,
  });

  final Locale locale;
  final void Function(Locale) onLocaleChanged;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabicLocale = isArabic(widget.locale);

    return Scaffold(
      appBar: AppBar(title: Text(isArabicLocale ? 'إنشاء حساب' : 'Créer un compte')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person_add_alt_1_rounded, size: 90, color: Color(0xFFD71920)),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return isArabicLocale ? 'أدخل اسمك' : 'Entrez votre nom';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: isArabicLocale ? 'الاسم الكامل' : 'Nom complet',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return isArabicLocale ? 'أدخل بريدك الإلكتروني' : 'Entrez votre email';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: isArabicLocale ? 'البريد الإلكتروني' : 'Email',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                validator: (value) {
                  if (value == null || value.length < 6) {
                    return isArabicLocale ? 'كلمة المرور قصيرة' : 'Mot de passe trop court';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  hintText: isArabicLocale ? 'كلمة المرور' : 'Mot de passe',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      showDemoOnlySnackBar(
                        context,
                        isArabicLocale
                            ? 'وضع تجريبي: إنشاء الحساب غير متصل بالخادم.'
                            : 'Mode démo : inscription non connectée au backend.',
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD71920),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: Text(
                    isArabicLocale ? 'إنشاء الحساب' : 'Créer le compte',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
