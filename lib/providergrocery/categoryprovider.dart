import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/baseurl/baseurlg.dart';
import 'package:grocery/beanmodel/category/categorymodel.dart';
import 'package:grocery/beanmodel/category/topcategory.dart';
import 'package:grocery/beanmodel/storefinder/storefinderbean.dart';
import 'package:grocery/providergrocery/benprovider/categorysearchbean.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryProvider extends Cubit<CategorySearchBean> {
  // BanerProvider(List<BannerDataModel> initialState) : super(initialState);

  List<CategoryDataModel> cateM = [];

  CategoryProvider() : super(CategorySearchBean(isSearching: false,data: [],storeFinderData: null)) {
    // hitBannerDetails();
  }

  List<CategoryDataModel> getCategoryList(){
    return cateM;
  }

  void hitBannerDetails(String soreid, StoreFinderData data) async {
    print(soreid);
    emit(CategorySearchBean(isSearching: true,data: [],storeFinderData: data));
    SharedPreferences.getInstance().then((prefs) {
      Client().post(categoryUri, body: {
        'store_id': '$soreid'
      }, headers: {
        'Authorization': 'Bearer ${prefs.getString('accesstoken')}'
      }).then((value) {
        print(value.body);
        CategoryModel cateData =
        CategoryModel.fromJson(jsonDecode(value.body));
        print(cateData.toString());
        emit(CategorySearchBean(isSearching: false,data: cateData.data, storeFinderData: data));
        cateM = List.from(cateData.data);
      }).catchError((e) {
        emit(CategorySearchBean(isSearching: false,data: [],storeFinderData: data));
      });
    }).catchError((e) {
      emit(CategorySearchBean(isSearching: false,data: [],storeFinderData: data));
    });
  }

  void emitCategoryList(List<CategoryDataModel> bannerL, StoreFinderData data) {
    emit(CategorySearchBean(isSearching: false,data: bannerL, storeFinderData: data));
  }
}
