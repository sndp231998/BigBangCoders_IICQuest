import 'dart:convert';
import 'package:hackathon/core/constants.dart';
import 'package:hackathon/features/home/pages/home.dart';
import 'package:hackathon/providers/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:hackathon/features/auth/pages/register_page.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (_formKey.currentState!.validate()) {
      // Get the username and password
      final username = _usernameController.text;
      final password = _passwordController.text;

      final url = Uri.parse('${Constants.API_BASE}api/v1/users/login');
      final response = await http.post(
        url,
        body: jsonEncode({'email': username, 'password': password}),
        headers: {'Content-Type': 'application/json'},
      );

      // Perform the login API call

      // Check if the response is successful
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        print(result);

        authProvider.setId = result['id'];

        // check for 501 (consultant)

        // Login successful, do something (e.g., navigate to home page)
        // if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login successful')),
        );
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => const Home()));
        // Navigate to the home page or any other destination
        // Navigator.pushReplacementNamed(context, '/home');
      } else {
        setState(() {
          _passwordController.text = "";
        });
        // Login failed, show error message
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Login failed: ${response.body}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // Logo or Header
                  Image.asset(
                    'assets/images/logo.png', // Your logo image path
                    width: 250,
                    height: 150,
                    fit: BoxFit.cover,
                    // You can adjust width and height as needed
                  ),
                  const SizedBox(height: 30),
                  // Username Field
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Password Field
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  // Login Button
                  ElevatedButton.icon(
                    onPressed: () => _login(context),
                    icon: const Icon(Icons.login),
                    label: const Text('Login'),
                  ),
                  const SizedBox(height: 10), // Add some spacing
                  TextButton(
                    onPressed: () {
                      // Navigate to the register page
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const RegisterPage()));
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
