import '../helpers/user_info.dart';

class LoginService {
  Future<bool> login(String username, String password) async {
    bool isLogin = false;
    if (username == 'ganang@gmail.com' && password == 'admin') {
      await UserInfo().setToken("ganang@gmail.com");
      await UserInfo().setUserID("1");
      await UserInfo().setUsername("Ganang Aji");
      await UserInfo().setProfileImage("1.jpg");
      isLogin = true;
    }
    if (username == 'kharisma@gmail.com' && password == 'admin') {
      await UserInfo().setToken("kharisma@gmail.com");
      await UserInfo().setUserID("2");
      await UserInfo().setUsername("Kharisma");
      await UserInfo().setProfileImage("2.jpg");
      isLogin = true;
    }
    if (username == 'alfi@gmail.com' && password == '12345678') {
      await UserInfo().setToken("alfi@gmail.com");
      await UserInfo().setUserID("3");
      await UserInfo().setUsername("Alfimonth");
      await UserInfo().setProfileImage("3.gif");
      isLogin = true;
    }
    if (username == 'vila@gmail.com' && password == '12345678') {
      await UserInfo().setToken("vila@gmail.com");
      await UserInfo().setUserID("4");
      await UserInfo().setUsername("Villa Yudah");
      await UserInfo().setProfileImage("x.jpg");
      isLogin = true;
    }
    return isLogin;
  }
}
