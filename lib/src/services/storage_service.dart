// Dart imports:
import 'dart:convert';

// Package imports:
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'package:farmtrack/src/constants/constants.dart';
import 'package:farmtrack/src/features/farms/models/animal_model.dart';
import 'package:farmtrack/src/features/farms/models/farm_animals_model.dart';
import 'package:farmtrack/src/features/farms/models/farm_model.dart';

class StorageService {
  // This function expects multiple futures simultaneously
  Future<void> initStorage() async {
    await Future.wait([
      _initHive(),
      _initTheme(),
      _initFarmAnimals(),
    ]);
  }

  // Initializes the hive and points it to the storage location
  Future<void> _initHive() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    await Hive.initFlutter(appDocumentDir.path);
  }

  Future<void> _initTheme() async {
    String? token = await _hasToken();

    await Hive.openBox(
      Constants.darkModeBox,
      encryptionCipher: HiveAesCipher(base64Url.decode(token!)),
    );
  }

  Future<void> _initFarmAnimals() async {
    String? token = await _hasToken();

    Hive.registerAdapter(FarmModelAdapter());
    Hive.registerAdapter(AnimalModelAdapter());
    Hive.registerAdapter(FarmAnimalsModelAdapter());

    await Hive.openBox(
      Constants.farmBox,
      encryptionCipher: HiveAesCipher(base64Url.decode(token!)),
    );
  }

  Future<String?> _hasToken() async {
    String? token = await _readSecureStorage(Constants.storageKeyBox);

    if (token == null || token.isEmpty) {
      String encodedKey = base64UrlEncode(
        Hive.generateSecureKey(),
      );
      await _writeSecureStorage(Constants.storageKeyBox, encodedKey);
    }

    String? newToken = await _readSecureStorage(Constants.storageKeyBox);

    return newToken;
  }

  // Reads the token into secure storage
  Future<String?> _readSecureStorage(String key) async {
    const secureStorage = FlutterSecureStorage();
    final String? encryptionKey = await secureStorage.read(key: key);

    return encryptionKey;
  }

  // Store the token in secure storage
  Future<void> _writeSecureStorage(String key, String value) async {
    const secureStorage = FlutterSecureStorage();
    await secureStorage.write(key: key, value: value);
  }
}
