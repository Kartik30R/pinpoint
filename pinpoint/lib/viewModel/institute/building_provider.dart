import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinpoint/model/building.dart';
import 'package:pinpoint/repository/institute/building_service.dart';

final buildingServiceProvider = Provider((ref) => BuildingService());

final buildingListProvider = FutureProvider.family<List<Building>, String>((ref, instituteId) {
  final service = ref.read(buildingServiceProvider);
  return service.getBuildingsByInstitute(instituteId);
});
