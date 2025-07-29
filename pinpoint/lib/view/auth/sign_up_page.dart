import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:pinpoint/resources/routes/app_routes.dart';
import '../../viewModel/auth/auth_provider.dart';
import '../../DTO/auth.dart';

class SignUpPage extends ConsumerWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final ValueNotifier<String?> _selectedRole = ValueNotifier(null);
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Future<void> _submitRegister() async {
      if (!_formKey.currentState!.validate() || _selectedRole.value == null)
        return;

      _isLoading.value = true;

      final req = AuthRequest.forRegister(
        email: _emailCtrl.text.trim(),
        phone: _phoneCtrl.text.trim(),
        password: _passwordCtrl.text.trim(),
        role: _selectedRole.value,
      );

      final response =
          await ref.read(authProvider).authServices.register(req);
      _isLoading.value = false;

      if (response.statusCode == "200") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registered successfully")),
        );
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response.message ?? "Signup failed")),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
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
                controller: _phoneCtrl,
                decoration: const InputDecoration(labelText: 'Phone'),
                validator: (val) => val!.isEmpty ? 'Enter phone' : null,
              ),
              TextFormField(
                controller: _passwordCtrl,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                validator: (val) => val!.length < 6 ? 'Min 6 chars' : null,
              ),
              ValueListenableBuilder<String?>(
                valueListenable: _selectedRole,
                builder: (_, value, __) => DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Role'),
                  value: value,
                  onChanged: (val) => _selectedRole.value = val,
                  items: const [
                    DropdownMenuItem(value: 'USER', child: Text('User')),
                    DropdownMenuItem(value: 'ADMIN', child: Text('Admin')),
                    DropdownMenuItem(
                        value: 'INSTITUTE', child: Text('Institute')),
                  ],
                  validator: (val) => val == null ? 'Select role' : null,
                ),
              ),
              const SizedBox(height: 20),
              ValueListenableBuilder<bool>(
                valueListenable: _isLoading,
                builder: (_, value, __) => ElevatedButton(
                  onPressed: value ? null : _submitRegister,
                  child: value
                      ? const CircularProgressIndicator()
                      : const Text('Sign Up'),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  context.go(AppRoutes.logIn);
                },
                child: const Text("Already have an account? Login here"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
