import 'package:grocery/beanmodel/category/categorymodel.dart';
import 'package:grocery/beanmodel/category/topcategory.dart';
import 'package:grocery/beanmodel/storefinder/storefinderbean.dart';

class CategorySearchBean{
  bool isSearching;
  StoreFinderData storeFinderData;
  List<CategoryDataModel> data;

  CategorySearchBean({this.isSearching, this.data, this.storeFinderData});

}