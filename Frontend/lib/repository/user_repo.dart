import 'dart:io';
import 'package:KinBech/app/network_connectivity.dart';
import 'package:KinBech/data_source/remote_data_source/user_remote_data_source.dart';
import '../model/user.dart';
import '../data_source/local_data_source/user_data_source.dart';

abstract class UserRepository {
  Future<List<User>> getUsers();
  Future<int> addUser(File? file, User user);
  Future<bool> loginUser(String username, String password);
}

class UserRepositoryImpl extends UserRepository {
  @override
  Future<int> addUser(File? file, User user) async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      return UserRemoteDataSource().addUser(file, user);
    } else {
      return UserDataSource().addUser(file, user);
    }
  }

  @override
  Future<List<User>> getUsers() {
    return UserDataSource().getUsers();
  }

  @override
  Future<bool> loginUser(String username, String password) async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      return UserRemoteDataSource().loginUser(username, password);
    } else {
      return UserDataSource().loginUser(username, password);
    }
  }
}
