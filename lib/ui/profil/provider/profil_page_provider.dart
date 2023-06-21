import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisisel_butce_yonetimi/core/repositories/user_repository_provider.dart';

import '../../../core/models/user.dart';

final updateUserViewModelProvider =ChangeNotifierProvider((ref) => UpdateUserViewModel(ref));
class UpdateUserViewModel extends ChangeNotifier{
  final Ref _ref;
  UpdateUserViewModel(this._ref);

  UserModel? _initial;
  UserModel get initial =>
      _initial ??
          UserModel.empty().copyWith(
            createdAt: DateTime.now(),
          );
  set initial(UserModel initial) {
    _initial = initial;
  }
  bool get edit => initial.id.isNotEmpty;

  String? get image => initial.image.isEmpty?null:initial.image;

  String? _name;
  String get name => _name ?? initial.name;
  set name(String name) {
    _name = name;
    notifyListeners();
  }

  String? _surname;
  String get surname => _surname ?? initial.surname;
  set surname(String surname) {
    _surname = surname;
    notifyListeners();
  }


  File? _file;
  File? get file => _file;
  set file(File? file) {
    _file = file;
    notifyListeners();
  }
  bool get enabled => name.isNotEmpty&&surname.isNotEmpty&&(image!=null||file!=null);

  UserRepository get _repository=>_ref.read(userRepositoryProvider);

  Future<void> write() async {
    final updated = initial.copyWith(
      name: name,
      surname: surname,
    );
    try {
      await _repository.writeItem(updated,file:file);
    }  catch(e){
      return Future.error("Bişeyler yanlış gitti mlsf");
    }
  }


  void clear(){
    _surname=null;
    _name=null;
    _file=null;
    _initial=null;
  }




}