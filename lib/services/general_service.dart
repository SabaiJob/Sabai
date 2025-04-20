import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GeneralService {
  static const generalStorage = FlutterSecureStorage();
  static const String generalKey = 'general';

  static Future<void> saveForApplyButton(bool accepted) async {
    await generalStorage.write(key: generalKey, value: accepted.toString());
  }

  static Future<bool> getForApplyButton() async {
    String? value = await generalStorage.read(key: generalKey);
    return value == 'true';
  }
}
