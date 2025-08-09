// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:pinpoint/model/user/adminModel.dart';
// import 'package:pinpoint/viewModel/admin/admin_provider.dart';

// class AdminFormScreen extends ConsumerStatefulWidget {
//   final bool isEdit;
//   final Admin? admin;

//   const AdminFormScreen({super.key, this.isEdit = false, this.admin});

//   @override
//   ConsumerState<AdminFormScreen> createState() => _AdminFormScreenState();
// }

// class _AdminFormScreenState extends ConsumerState<AdminFormScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final emailCtrl = TextEditingController();
//   final phoneCtrl = TextEditingController();
//   final passwordCtrl = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     if (widget.isEdit && widget.admin != null) {
//       emailCtrl.text = widget.admin!.email;
//       phoneCtrl.text = widget.admin!.phone;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final service = ref.read(adminServiceProvider);

//     return Scaffold(
//       appBar: AppBar(title: Text(widget.isEdit ? 'Edit Admin' : 'Create Admin')),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Form(
//           key: _formKey,
//           child: Column(children: [
//             TextFormField(
//               controller: emailCtrl,
//               decoration: const InputDecoration(labelText: 'Email'),
//             ),
//             TextFormField(
//               controller: phoneCtrl,
//               decoration: const InputDecoration(labelText: 'Phone'),
//             ),
//             if (!widget.isEdit)
//               TextFormField(
//                 controller: passwordCtrl,
//                 decoration: const InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//               ),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () async {
//                 if (!_formKey.currentState!.validate()) return;

//                 if (widget.isEdit && widget.admin != null) {
//                   await service.updateAdmin(widget.admin!.id, {
//                     "phone": phoneCtrl.text,
//                     "name": widget.admin?.name,
//                   });
//                 } else {
//                   await service.createAdmin(
//                     email: emailCtrl.text,
//                     phone: phoneCtrl.text,
//                     password: passwordCtrl.text,
//                   );
//                 }

//                 if (context.mounted) Navigator.pop(context);
//               },
//               child: Text(widget.isEdit ? 'Update' : 'Create'),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
