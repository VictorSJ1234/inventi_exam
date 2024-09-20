import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:inventi_flutter_exam/login/login_provider.dart';
import 'package:provider/provider.dart';

class LoginPageUi extends StatefulWidget {
  const LoginPageUi({super.key});

  @override
  _LoginPageUiState createState() => _LoginPageUiState();
}

class _LoginPageUiState extends State<LoginPageUi> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _validateAndSubmit() {
    if (_formKey.currentState?.validate() == true) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      authProvider.login(_emailController.text, _passwordController.text);
      if (authProvider.isAuthenticated) {
        context.pushNamed('home');
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              elevation: 4,
              shadowColor: Colors.black,
              content: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icons/alert.png',
                        width: 70,
                        height: 70,
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Invalid email or password. Please try again.',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              actions: [
                Center(
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 10,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor: Colors.red,
                        ),
                        child: Text(
                          'BACK',
                          style: TextStyle(color: Colors.white, fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      }
    }
  }

  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background_image/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Container(
            color: Colors.black.withOpacity(0.7),
          ),

          Center(
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),

                        const SizedBox(height: 20),

                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.blueGrey),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                .hasMatch(value)) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 30),

                        TextFormField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: const TextStyle(color: Colors.blueGrey),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide.none,
                            ),
                            filled: true,
                            fillColor: Colors.white,
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: Colors.grey,
                              ),
                              onPressed: _togglePasswordVisibility,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 20),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              // not functional
                            },
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onPressed: _validateAndSubmit,
                            child: const Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account? ",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              onPressed: () {
                                // not functional
                              },
                              child: const Text(
                                'Sign Up here',
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 20),

                        Image.asset(
                          'assets/inventi_logos/inventi_logo_1.png',
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
