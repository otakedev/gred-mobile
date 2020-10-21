import 'package:gred_mobile/core/storage.dart';

Future<String> checkUserSkill() async {
  return await readStorage("user_skill");
}

Future<bool> chooseNovice() async {
  return await writeStorage("user_skill", "NOVICE");
}

Future<bool> chooseExpert() async {
  return await writeStorage("user_skill", "EXPERT");
}
