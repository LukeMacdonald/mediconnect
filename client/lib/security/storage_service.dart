import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserSecureStorage {

  static const _storage = FlutterSecureStorage();

  static const _keyID = 'id';
  static const _keyEmail = 'email';
  static const _keyRole = 'role';
  static const _keyJWTToken = 'access';
  static const _keyPassword = 'password';
  static const _keyFirstName = 'firstName';
  static const _keyLastName = 'lastName';
  static const _keyPhoneNumber = 'phone';
  static const _keyDOB = 'dob';
  static const _keyConfirmPassword = 'confirmPassword';
  static const _keyJWTRefreshToken = 'refresh';

  static Future setID(String id) async =>
      await _storage.write(key: _keyID, value: id);

  static Future<String?> getID() async =>
      await _storage.read(key: _keyID);

  static Future setEmail(String email) async =>
      await _storage.write(key: _keyEmail, value: email);

  static Future<String?> getEmail() async =>
      await _storage.read(key: _keyEmail);

  static Future setRole(String role) async =>
      await _storage.write(key: _keyRole, value: role);

  static Future<String?> getRole() async =>
      await _storage.read(key: _keyRole);

  static Future setPassword(String password) async =>
      await _storage.write(key: _keyPassword, value: password);

  static Future<String?> getPassword() async =>
      await _storage.read(key: _keyPassword);

  static Future setConfirmPassword(String confirmPassword) async =>
      await _storage.write(key: _keyConfirmPassword, value: confirmPassword);

  static Future<String?> getConfirmPassword() async =>
      await _storage.read(key: _keyConfirmPassword);

  static Future setFirstName(String name) async =>
      await _storage.write(key: _keyFirstName, value: name);

  static Future<String?> getFirstName() async =>
      await _storage.read(key: _keyFirstName);

  static Future setLastName(String name) async =>
      await _storage.write(key: _keyLastName, value: name);

  static Future<String?> getLastName() async =>
      await _storage.read(key: _keyLastName);

  static Future setPhoneNumber(String phone) async =>
      await _storage.write(key: _keyPhoneNumber, value: phone);

  static Future<String?> getPhoneNumber() async =>
      await _storage.read(key: _keyPhoneNumber);

  static Future setDOB(String date) async =>
      await _storage.write(key: _keyDOB, value: date);

  static Future<String?> getDOB() async =>
      await _storage.read(key: _keyDOB);

  static Future setJWTToken(String jwtToken) async =>
      await _storage.write(key: _keyJWTToken, value: jwtToken);

  static Future<String?> getJWTToken() async =>
      await _storage.read(key: _keyJWTToken);

  static Future setJWTRefreshToken(String jwtToken) async =>
      await _storage.write(key: _keyJWTRefreshToken, value: jwtToken);

  static Future<String?> getJWTRefreshToken() async =>
      await _storage.read(key: _keyJWTRefreshToken);

  Future<Map<String, dynamic>> toJson() async => {
    'email': await UserSecureStorage.getEmail(),
    'password': await UserSecureStorage.getPassword(),
    'role':  await UserSecureStorage.getRole(),
    'confirmPassword': await UserSecureStorage.getConfirmPassword(),
  };

  Future<Map<String, dynamic>> toFullJson()async => {
    'email': await UserSecureStorage.getEmail(),
    'password': UserSecureStorage.getPassword(),
    'role': UserSecureStorage.getRole(),
    'firstName': UserSecureStorage.getFirstName(),
    'lastName': UserSecureStorage.getLastName(),
    'phoneNumber': UserSecureStorage.getPhoneNumber(),
    'dob': UserSecureStorage.getDOB(),


  };

  Future<Map<String, dynamic>> doctorToJson(int code) async  => {
    'email': UserSecureStorage.getEmail(),
    'password': UserSecureStorage.getPassword(),
    'role': UserSecureStorage.getRole(),
    'confirmPassword': UserSecureStorage.getConfirmPassword(),
    'code': code,
  };
  Future<void> setDetails(var responseData) async => {
     UserSecureStorage.setID(responseData['id'].toString()),
    UserSecureStorage.setEmail(responseData['email']),
    UserSecureStorage.setFirstName(responseData['firstName']),
    UserSecureStorage.setLastName(responseData['lastName']),
    UserSecureStorage.setRole(responseData['role']),
     UserSecureStorage.setDOB(responseData['dob']),
    UserSecureStorage.setPhoneNumber(responseData['phoneNumber']),
  };





}