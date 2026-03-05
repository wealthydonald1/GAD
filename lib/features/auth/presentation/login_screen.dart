import 'package:flutter/material.dart';
import 'package:gad/core/router/app_router.dart';
import 'package:gad/shared/widgets/custom_button.dart';
import 'package:gad/shared/widgets/app_text_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // App name / logo
                const Text(
                  'GAD',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // Welcome message
                const Text(
                  'Welcome Back!',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 8),
                const Text(
                  'We missed you! Please enter your details.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.left,
                ),
                const SizedBox(height: 32),
                // Email field
                AppTextField(
                  label: 'Email',
                  hint: 'Enter your Email',
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 16),
                // Password field
                AppTextField(
                  label: 'Password',
                  hint: 'Enter Password',
                  obscureText: true,
                ),
                const SizedBox(height: 8),
                // Remember me & Forgot password row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: false, onChanged: (value) {}),
                        const Text('Remember me'),
                      ],
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, AppRouter.forgotPassword);
                      },
                      child: const Text('Forgot password?'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Sign in button
                CustomButton(
                  text: 'Sign in',
                  onPressed: () {
                    // TODO: Add authentication logic
                    Navigator.pushReplacementNamed(context, AppRouter.staffDashboard);
                  },
                ),
                const SizedBox(height: 16),
                // Divider or "or" text
                Row(
                  children: const [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('or', style: TextStyle(color: Colors.grey)),
                    ),
                    Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 16),
                // Sign in with Google button (outlined)
                OutlinedButton.icon(
                  onPressed: () {
                    // TODO: Google sign-in
                  },
                  icon: Image.network(
                    'https://upload.wikimedia.org/wikipedia/commons/5/53/Google_%22G%22_Logo.svg',
                    height: 20,
                    width: 20,
                  ),
                  label: const Text('Sign in with Google'),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 48),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 24),
                // Sign up link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                      onPressed: () {
                        // Navigate to sign up
                      },
                      child: const Text('Sign up'),
                    ),
                  ],
                ),
                // Optional: Skip login for development (you can remove later)
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () => Navigator.pushReplacementNamed(
                    context,
                    AppRouter.staffDashboard,
                  ),
                  child: const Text('Skip Login (Dev Mode)'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}