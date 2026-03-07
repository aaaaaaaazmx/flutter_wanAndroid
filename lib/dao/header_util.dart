import 'package:fluttet_demo/dao/login_dao.dart';
import 'package:hi_cache/hi_cache.dart';

Map<String, String> hiHeader() {
  final userName = HiCache.shared().get(LoginDao.userName) ?? '';
  final passWord = HiCache.shared().get(LoginDao.passWord) ?? '';

  return {
    'token': 'token',
    if (userName.isNotEmpty && passWord.isNotEmpty)
      'Cookie': 'loginUserName=$userName; loginUserPassword=$passWord',
  };
}
