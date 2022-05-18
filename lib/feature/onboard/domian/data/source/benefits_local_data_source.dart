import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class BenefitsLocalDataSource {
  Future<void> skip();

  bool isSkipped();
}

@Singleton(as: BenefitsLocalDataSource)
class BenefitsLocalDataSourceImpl extends BenefitsLocalDataSource {
  static const _SKIPPED_KEY = "_SKIPPED_KEY";
  final SharedPreferences/*!*/ sharedPreferences;

  BenefitsLocalDataSourceImpl(this.sharedPreferences);

  @override
  Future<void> skip() async {
    await sharedPreferences.setBool(_SKIPPED_KEY, true);
  }

  @override
  bool isSkipped() {
    try {
      return sharedPreferences.getBool(_SKIPPED_KEY) ?? false;
    } catch (e) {
      return false;
    }
  }
}
