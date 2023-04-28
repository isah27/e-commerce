import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:e_commerce/repo/auth_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepository authRepo;
  AuthCubit(this.authRepo) : super(AuthInitialState());
  String token = "";
  String error = "";
  UserModel user = UserModel();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();

  Future<void> register() async {
    error = "";
    emit(AuthLoadingState());
    try {
      final code = await authRepo.register(
          name: usernameController.text.trim(),
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      if (code.statusCode == 200) {
        token = json.decode(code.body)['token'];
        emailController.clear();
        passwordController.clear();
        usernameController.clear();
        emit(AuthLoadedState());
      } else {
        error = code.body;
      }
    } catch (e) {
      error = e.toString();
      emit(AuthErrorState());
    }
  }

  Future<void> login() async {
    error = "";
    emit(AuthLoadingState());
    try {
      final code = await authRepo.login(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      if (code.statusCode == 200) {
        token = json.decode(code.body)['token'];
        log(token);
        emailController.clear();
        passwordController.clear();
        emit(AuthLoadedState());
      } else {
        error = code.body;
      }
    } catch (e) {
      error = e.toString();
      emit(AuthErrorState());
    }
  }

  Future<void> getUser() async {
    error = "";
    emit(AuthLoadingState());
    try {
      final code = await authRepo.getUser(token: token);
      if (code.statusCode == 200) {
        user = UserModel.fromJson(json.decode(code.body));
        emit(AuthUpdateState());
      } else {
        error = code.body;
      }
    } catch (e) {
      error = e.toString();
      emit(AuthErrorState());
    }
  }

  Future<void> updateUser() async {
    error = "";
    emit(AuthLoadingState());
    try {
      user.name = usernameController.text.trim();
      user.email = emailController.text.trim();
      final code = await authRepo.updateUser(token: token, user: user);
      if (code.statusCode == 200) {
        emailController.clear();
        passwordController.clear();
        emit(AuthUpdateState());
      } else {
        // error = code.body;
      }
    } catch (e) {
      // error = e.toString();
      emit(AuthErrorState());
    }
  }

  goToDetails() {
    emit(AuthLoadingState());
    usernameController.text = user.name ?? "";
    emailController.text = user.email ?? "";
    emit(AuthUpdateState());
  }
}
