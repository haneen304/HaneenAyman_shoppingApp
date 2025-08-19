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

  void _switchLanguage(String? lang) {
    if (lang != null) {
      setState(() {
        _language = lang;
      });
    }
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: isArabic ? 'البريد الإلكتروني' : 'Email',
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: isArabic ? 'كلمة المرور' : 'Password',
              ),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                // ✅ Go to Home after Sign In
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
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
    );
  }
}
