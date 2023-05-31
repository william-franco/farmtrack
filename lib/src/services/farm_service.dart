// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:farmtrack/src/constants/constants.dart';

class FarmService {
  final _farmBox = Hive.box(Constants.farmBox);

  List<dynamic> getAllItems() {
    try {
      return _farmBox.values.toList();
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> addItem(dynamic item) async {
    try {
      await _farmBox.add(item);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> updateItemAt(int index, dynamic item) async {
    try {
      await _farmBox.putAt(index, item);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> deleteAt(int index) async {
    try {
      await _farmBox.deleteAt(index);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<void> deleteAll() async {
    try {
      await _farmBox.clear();
    } catch (error) {
      throw Exception(error);
    }
  }
}
