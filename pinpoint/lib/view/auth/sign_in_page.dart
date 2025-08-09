import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinpoint/resources/routes/app_routes.dart';
import 'package:pinpoint/view/auth/sign_up_page.dart';
import '../../viewModel/auth/auth_provider.dart';

class LoginPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoading = ValueNotifier(false);
    
Future<void> _submitLogin() async {
  if (!_formKey.currentState!.validate()) return;

  isLoading.value = true;

  try {
    final error = await ref.read(authProvider).login(
      _emailCtrl.text.trim(),
      _passwordCtrl.text.trim(),
    );

    if (error == null) {
      context.go('/');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error)),
      );
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login error: $e")),
    );
  } finally {
    isLoading.value = false;
  }
}



    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (val) => val!.isEmpty ? 'Enter email' : null,
              ),
              TextFormField(
                controller: _passwordCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (val) => val!.length < 6 ? 'Min 6 chars' : null,
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder(
                valueListenable: isLoading,
                builder: (_, bool value, __) => ElevatedButton(
                  onPressed: value ? null : _submitLogin,
                  child: value
                      ? const CircularProgressIndicator()
                      : const Text('Login'),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
              onPressed: () {
  debugPrint('Sign up pressed');
  debugPrint('Current location: ${GoRouter.of(context).routerDelegate}');
// Navigator.push(context,MaterialPageRoute(builder: (context) => SignUpPage(),));
context.go(AppRoutes.signUp);
  debugPrint('Tried to go to: ${AppRoutes.signUp}');
}

                ,
                child: const Text("Don't have an account? Sign up here"),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
