import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/model/user/adminModel.dart';
import 'package:pinpoint/repository/admin/admin_services.dart';
import 'package:pinpoint/viewModel/storage/secure_storage_provider.dart';

final adminServiceProvider = Provider<AdminService>((ref) {
  final storage = ref.read(secureStorageProvider);
  return AdminService(storage);
});

final adminListProvider = FutureProvider.family.autoDispose<List<Admin>, String>((ref, instituteId) async {
  final service = ref.read(adminServiceProvider);
  return service.getAdminsByInstitute(instituteId);
});

final singleAdminProvider = FutureProvider.family.autoDispose<Admin, String>((ref, adminId) async {
  final service = ref.read(adminServiceProvider);
  return service.getAdminById(adminId);
});
