import 'package:sqflite/sqflite.dart';

class AppStorage {
  late Database _database;

  ///  **Initialize Database**
 Future<void> initDatabase() async {
  _database = await openDatabase(
    'location.db',
    version: 2,  // Incremented version from 1 to 2
    onCreate: (db, version) {
      db.execute(
        'CREATE TABLE LocationData (id INTEGER PRIMARY KEY, latitude REAL, longitude REAL, altitude REAL, timestamp INTEGER)',
      );
    },
    onUpgrade: (db, oldVersion, newVersion) {
      if (oldVersion < 2) {
        db.execute('ALTER TABLE LocationData ADD COLUMN altitude REAL');
      }
    },
  );
}

  ///  **Insert Location Data**
  Future<void> insertLocation(double latitude, double longitude, double altitude) async {
  await _database.insert(
    'LocationData', // Change from 'locations' to 'LocationData'
    {'latitude': latitude, 'longitude': longitude, 'altitude': altitude, 'timestamp': DateTime.now().millisecondsSinceEpoch},
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}


  ///  **Query All Location Data**
  Future<List<Map<String, dynamic>>> getAllLocations() async {
    return await _database.query('LocationData', orderBy: 'timestamp ASC');
  }

  ///  **Clear All Location Data**
  Future<void> clearDatabase() async {
    await _database.delete('LocationData');
  }
}
