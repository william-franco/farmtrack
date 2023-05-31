// Dart imports:
import 'dart:io';

// Package imports:
import 'package:flutter_test/flutter_test.dart';

// Test Directories using 'dart:io' instead path_provider because its not suported in this test
void main() {
  group('Directories', () {
    // Directory used for store temporary the boxes
    const directoryPath = '/build/';

    test('Test create directory', () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      final appDir = await Directory.current.create();

      expect(appDir.path, isNotNull);
      expect(appDir.path, isNotEmpty);
      expect(appDir.existsSync(), equals(true));
    });

    test('Test create temporary directory', () async {
      TestWidgetsFlutterBinding.ensureInitialized();
      final tempDir = await Directory.current.createTemp(directoryPath);

      expect(tempDir.path, isNotNull);
      expect(tempDir.path, isNotEmpty);
      expect(tempDir.existsSync(), equals(true));
    });

    test('Test create temporary directory synchronously', () {
      TestWidgetsFlutterBinding.ensureInitialized();
      final tempDir = Directory.current.createTempSync(directoryPath);

      expect(tempDir.path, isNotNull);
      expect(tempDir.path, isNotEmpty);
      expect(tempDir.existsSync(), equals(true));
    });
  });
}
