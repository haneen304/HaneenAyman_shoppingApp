import 'package:flutter/material.dart';
import 'signup_screen.dart';
import 'home_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  String _language = 'EN';
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  void _switchLanguage(String? lang) {
    if (lang != null) setState(() => _language = lang);
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = _language == 'AR';
    final titleText = isArabic ? 'تسجيل الدخول' : 'Sign In';
    final switchText = isArabic
        ? 'لا تملك حساب؟ إنشاء حساب'
        : 'Don’t have an account? Sign Up';

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(titleText, style: const TextStyle(color: Colors.white)),
        actions: [
          DropdownButton<String>(
            value: _language,
            dropdownColor: Colors.white,
            underline: const SizedBox(),
            icon: const Icon(Icons.language, color: Colors.white),
            items: ['EN', 'AR'].map((lang) {
              return DropdownMenuItem(
                value: lang,
                child: Text(lang, style: const TextStyle(color: Colors.black)),
              );
            }).toList(),
            onChanged: _switchLanguage,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: isArabic ? 'البريد الإلكتروني' : 'Email',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return isArabic
                        ? 'الرجاء إدخال البريد الإلكتروني'
                        : 'Enter email';
                  }
                  if (!value.contains('@')) {
                    return isArabic
                        ? 'البريد الإلكتروني غير صالح'
                        : 'Invalid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: isArabic ? 'كلمة المرور' : 'Password',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return isArabic
                        ? 'الرجاء إدخال كلمة المرور'
                        : 'Enter password';
                  }
                  if (value.length < 6) {
                    return isArabic
                        ? 'كلمة المرور قصيرة جداً'
                        : 'Password too short';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const HomeScreen()),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(titleText),
              ),
              const SizedBox(height: 15),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const SignUpScreen()),
                  );
                },
                child: Text(
                  switchText,
                  style: const TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
