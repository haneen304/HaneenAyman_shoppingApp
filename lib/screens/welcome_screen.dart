import 'package:flutter/material.dart';
import 'signin_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
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

    final welcomeText = isArabic ? 'مرحبا بكم في ' : 'Welcome to ';
    final projectName = isArabic ? 'المتجر الجمالي' : 'Aesthetic Shop';
    final subtitleText = isArabic
        ? 'أفضل مكان لتجربة تسوق سهلة وسريعة'
        : 'Your best place for an easy shopping experience';
    final signInText = isArabic ? 'تسجيل الدخول' : 'Sign In';
    final signUpText = isArabic ? 'إنشاء حساب' : 'Sign Up';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: const SizedBox(), // remove top bar text
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Side-by-side images
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Image.asset(
                    'assets/images/cart.png',
                    height: 130,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Image.network(
                    'https://img.freepik.com/free-vector/vector-icon-set-white-shopping-paper-bags-isolated-white-background_134830-1248.jpg',
                    height: 130,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Welcome + Project name, same font size
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                children: [
                  TextSpan(
                    text: welcomeText,
                    style: const TextStyle(
                      fontSize: 24, // same size
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                  TextSpan(
                    text: projectName,
                    style: const TextStyle(
                      fontSize: 24, // same size
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Subtitle smaller, readable, soft shadow
            Text(
              subtitleText,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.blueGrey, // soft color for easy reading
                fontWeight: FontWeight.w500,
                shadows: [
                  Shadow(
                    offset: Offset(0.5, 0.5),
                    blurRadius: 1.5,
                    color: Colors.black12,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40), // move buttons slightly down
            // Buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignInScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(signInText),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SignUpScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blue,
                side: const BorderSide(color: Colors.blue),
                minimumSize: const Size(double.infinity, 50),
              ),
              child: Text(signUpText),
            ),
          ],
        ),
      ),
    );
  }
}
