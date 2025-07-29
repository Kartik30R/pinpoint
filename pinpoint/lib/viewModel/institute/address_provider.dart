
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/model/address.dart';
import 'package:pinpoint/repository/institute/address_service.dart';

final addressServiceProvider = Provider<AddressService>((ref) {
  return AddressService();
});

final addressProvider = FutureProvider.family<Address, String>((ref, instituteId) async {
  final service = ref.read(addressServiceProvider);
  return service.getAddress(instituteId);
});

