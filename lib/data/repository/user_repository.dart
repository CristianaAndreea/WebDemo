import '../model/model.dart';
import '../service/service.dart';
import '../storage/storage.dart';

class UserRepository {
  //region Singleton
  static final UserRepository _singleton = UserRepository._internal();

  factory UserRepository() {
    return _singleton;
  }

  UserRepository._internal();

  //endregion

  String? _token;
  DateTime? _tokenExpiration;

  String? get token => _token;

  DateTime? get tokenExpiration => _tokenExpiration;

  User? _user;

  User? get user => _user;

  Future<WebResponse> login({
    required String email,
    required String password,
  }) async {
    final response = await UserService().login(
      email: email,
      password: password,
    );

    if (response.isSuccess) {
      _user = User.fromMap(response.responseData);
      _token = response.responseData['token'];

      // Save login state and token
      await UserDataStorage().saveLoginState(isLoggedIn: true, token: _token);
    }

    return response;
  }

  Future<WebResponse> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await UserService().register(
      name: name,
      email: email,
      password: password,
    );

    if (response.isSuccess) {
      _user = User.fromMap(response.responseData);
      _token = response.responseData['token'];

      await UserDataStorage().saveLoginState(isLoggedIn: true, token: _token);
    }

    return response;
  }

  Future<WebResponse?> getUserProfile() async {
    try {
      if (_user == null || _user!.id == null) return null;

      final response = await UserService().getUserProfile(id: _user!.id!);

      if (response.isSuccess) {
        _user = _user?.copyWith(
          id: response.responseData['id'],
          email: response.responseData['email'],
          name: response.responseData['name'],
          password: response.responseData['password'],
        );
      }

      return response;
    } catch (exception, stack) {
      print(exception);
      print(stack);
      return null;
    }
  }

  Future<WebResponse?> updateUserProfile({
    required String userName,
    required String email,
  }) async {
    try {
      final response = await UserService().saveUserProfile(
        id: _user!.id!,
        userName: userName,
        email: email,
        password: _user!.password,
      );
      _user = _user?.copyWith(
        email: response.responseData['email'],
        name: response.responseData['name'],
      );
      return response;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<WebResponse?> deleteUserProfile() async {
    try {
      final response = await UserService().deleteUserProfile(id: _user!.id!);
      _user = null;
      await UserDataStorage().clearLoginState();
      return response;
    } catch (exception) {
      print(exception);
      return null;
    }
  }

  Future<bool> logout() async {
    await UserDataStorage().clearLoginState();
    return true;
  }
}
