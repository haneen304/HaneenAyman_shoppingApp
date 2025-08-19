import 'package:flutter/material.dart';
import 'signin_screen.dart';
import 'home_screen.dart'; 

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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

    final titleText = isArabic ? 'إنشاء حساب' : 'Sign Up';
    final switchText =
        isArabic ? 'لديك حساب؟ تسجيل الدخول' : 'Already have an account? Sign In';

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
              decoration:
                  InputDecoration(labelText: isArabic ? 'الاسم' : 'Name'),
            ),
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                  labelText: isArabic ? 'البريد الإلكتروني' : 'Email'),
            ),
            const SizedBox(height: 15),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                  labelText: isArabic ? 'كلمة المرور' : 'Password'),
            ),
            const SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                // ✅ Go to Home after Sign Up
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50)),
              child: Text(titleText),
            ),
            const SizedBox(height: 15),
            TextButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const SignInScreen()),
                );
              },
              child:
                  Text(switchText, style: const TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}