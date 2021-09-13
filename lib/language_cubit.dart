
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageCubit extends Cubit<Locale> {

  LanguageCubit():super(Locale('en')){
    setLanguage();
  }

  void setLanguage() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.containsKey('language') && preferences.getString('language').length>0){
      emit(Locale(preferences.getString('language')));
    }
  }

  void selectEngLanguage() async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('language', 'en');
    emit(Locale('en'));
  }

  // void selectHindiLanguage() async{
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   preferences.setString('language', 'hi');
  //   emit(Locale('hi'));
  // }
}
