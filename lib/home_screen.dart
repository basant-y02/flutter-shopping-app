import 'package:flutter/material.dart';
import 'package:shop_easy/shopping_home.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool get isSmall => MediaQuery.of(context).size.width < 600;

  get width => MediaQuery.of(context).size.width;

  get height => MediaQuery.of(context).size.height;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShopEasy'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(115, 155, 39, 176),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 24,
          fontFamily: 'Suwannaphum',
          shadows: [
            Shadow(color: Colors.black, offset: Offset(1, 1), blurRadius: 2),
          ],
        ),
      ),
      
      
      body: Builder(
        builder: (context) {
          final screenWidth = MediaQuery.of(context).size.width;
          final imageWidth = (screenWidth - 60) / 2;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(isSmall ? 6 : 10),
                      child: Image.asset(
                        'assets/image.jpg',
                        width: imageWidth,
                        height: imageWidth,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(width: 20),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(isSmall ? 6 : 10),
                      child: Image.network(
                        'https://media.istockphoto.com/id/1177081971/photo/multicolored-paper-shopping-bags-christmas-shopping-banner.webp?a=1&b=1&s=612x612&w=0&k=20&c=8Bk38UqVXiv_rCPQyFSOYKitShfyNbHzVjgkU-2k_bc=',
                        width: imageWidth,
                        height: imageWidth,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),


                
                Padding(
                  padding: const EdgeInsets.only(top: 32.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        icon: const Icon(Icons.login),
                        label: const Text('Login'),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (ctx) => Padding(
                              padding: EdgeInsets.only(
                                left: 24,
                                right: 24,
                                top: 24,
                                bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
                              ),
                              child: AuthForms(
                                initialIsLogin: true, 
                                onSuccess: () {
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) =>
                                          const ShoppingHomeScreen(),
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        return FadeTransition(
                                          opacity: animation,
                                          child: child,
                                        );
                                      },
                                      transitionDuration: const Duration(milliseconds: 800), 
                                    ),
                                  );

                                },
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(width: 16),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.app_registration),
                        label: const Text('Register'),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            builder: (ctx) => Padding(
                              padding: EdgeInsets.only(
                                left: 24,
                                right: 24,
                                top: 24,
                                bottom: MediaQuery.of(ctx).viewInsets.bottom + 24,
                              ),
                              child: AuthForms(
                                initialIsLogin: false, 
                                onSuccess: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const MyHomePage(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),

                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

  }
}

class AuthForms extends StatefulWidget {
  final VoidCallback onSuccess;
  final bool initialIsLogin;

  const AuthForms({super.key, required this.onSuccess, this.initialIsLogin = true});

  @override
  State<AuthForms> createState() => _AuthFormsState();
}

class _AuthFormsState extends State<AuthForms> {
  late bool isLogin;

  @override
  void initState() {
    super.initState();
    isLogin = widget.initialIsLogin; 
  }
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  void _showSuccessDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop(); 
              widget.onSuccess();      
            },
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
              ),
            ],
          ),
            Text(
              isLogin ? 'Login' : 'Sign Up',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            if (!isLogin)
              TextFormField(
                controller: _fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your full name';
                  }
                  if (value[0] != value[0].toUpperCase()) {
                    return 'First letter must be uppercase';
                  }
                  return null;
                },
              ),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter your email';
                }
                if (!value.contains('@')) {
                  return 'Enter a valid email';
                }
                return null;
              },
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Enter your password';
                }
                if (value.length < 6) {
                  return 'Minimum 6 characters';
                }
                return null;
              },
            ),
            if (!isLogin)
              Column(
                children: [
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(labelText: 'Confirm Password'),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (isLogin) {
                    _showSuccessDialog("Account sign-in successfully");
                  } else {
                    _showSuccessDialog("Account created successfully");
                  }
                }
              },
              child: Text(isLogin ? 'Login' : 'Sign Up'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                });
              },
              child: Text(isLogin
                  ? "Don't have an account? Sign Up"
                  : "Already have an account? Login"),
            ),
          ],
        ),
      ),
    );
  }
}
