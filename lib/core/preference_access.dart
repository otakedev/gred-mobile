import 'package:gred_mobile/core/storage.dart';

Future<String> checkUserSkill() async {
  return await readStorage("user_skill");
}
