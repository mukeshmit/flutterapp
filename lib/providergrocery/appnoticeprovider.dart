import 'package:flutter_bloc/flutter_bloc.dart';

import 'benprovider/appnoticebean.dart';
class AppNoitceProvider extends Cubit<AppNoticeBean>{
  AppNoitceProvider() : super(AppNoticeBean(status: 0,notice: '--------------------------------------------------------------'));

  void hitNotice(int status, String notice){
    emit(AppNoticeBean(status: status,notice: notice));
  }

}