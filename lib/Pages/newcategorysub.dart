import 'dart:convert';

import 'package:async/async.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Locale/locales.dart';
import 'package:grocery/Routes/routes.dart';
import 'package:grocery/Theme/colors.dart';
import 'package:grocery/baseurl/baseurlg.dart';
import 'package:grocery/beanmodel/category/categorymodel.dart';
import 'package:grocery/beanmodel/category/topcategory.dart';
import 'package:grocery/beanmodel/storefinder/storefinderbean.dart';
import 'package:grocery/providergrocery/benprovider/categorysearchbean.dart';
import 'package:grocery/providergrocery/categoryprovider.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class NewCategorySubScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return NewCategorySubScreenState();
  }
}

class NewCategorySubScreenState extends State<NewCategorySubScreen> {
  var http = Client();
  bool enteredFirst = false;
  List<SuBCategoryModel> subcategory = [];
  List<SuBCategoryModel> subCategorySearch = [];
  dynamic store_id;
  dynamic title = '--';
  dynamic topCatID;
  StoreFinderData storedetail;

  @override
  void initState() {
    super.initState();
  }

  void scanProductCode(BuildContext context) async {
    await FlutterBarcodeScanner.scanBarcode(
        "#ff6666", "Cancel", true, ScanMode.DEFAULT)
        .then((value) {
      if (value != null && value.length > 0 && '$value' != '-1') {
        if (storedetail != null) {
          Navigator.pushNamed(context, PageRoutes.search, arguments: {
            'ean_code': value,
            'storedetails': storedetail,
          });
        }
        // print('scancode - ${_scanBarcode}');
      }
    }).catchError((e) {});
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    if(!enteredFirst){
      enteredFirst = true;
      Map<String,dynamic> cateData = ModalRoute.of(context).settings.arguments;
      subcategory = List.from(cateData['catsub']);
      subCategorySearch = List.from(cateData['catsub']);
      store_id = cateData['storeid'];
      storedetail = cateData['storedetail'];
      title = cateData['title'];
      topCatID = cateData['cat_id'];
      print(subcategory.toString());
      print(topCatID);
    }


    
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 120),
        child: Container(
          color: kWhiteColor,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                backgroundColor: kWhiteColor,
                title: Text(
                  title,
                  style: TextStyle(
                      color: kMainTextColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                automaticallyImplyLeading: true,
                centerTitle: true,
                leading: GestureDetector(
                  onTap: (){
                    Navigator.of(context).pop();
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Icon(Icons.arrow_back_ios_sharp),
                ),
                actions: [
                  Visibility(
                    // visible: (storeFinderData != null &&
                    //     storeFinderData.store_id != null),
                    visible: true,
                    child: IconButton(
                      icon: ImageIcon(AssetImage(
                        'assets/scanner_logo.png',
                      )),
                      onPressed: () async {
                        scanProductCode(context);
                      },
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                        color: Color(0xfff8f8f8), width: 1),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xfff8f8f8),
                          offset: Offset(-1, -1),
                          blurRadius: 5),
                      BoxShadow(
                          color: Color(0xfff8f8f8),
                          offset: Offset(1, 1),
                          blurRadius: 5)
                    ]),
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      List<SuBCategoryModel> chList = subCategorySearch
                          .where((element) => element.title
                          .toString()
                          .toLowerCase()
                          .contains(value.toLowerCase()))
                          .toList();
                      subcategory = List.from(chList);
                    });
                  },
                  autofocus: false,
                  style: Theme.of(context)
                      .textTheme
                      .headline6
                      .copyWith(
                      color: kMainTextColor, fontSize: 18),
                  decoration: InputDecoration(
                      hintText: "what are you looking for (e.g. mango, onion)",
                      hintStyle:
                      Theme.of(context).textTheme.subtitle2,
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 10),
                      prefixIcon: Icon(
                        Icons.search,
                        color: kIconColor,
                      ),
                      focusColor: kMainTextColor,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none)),
                ),
              )
            ],
          ),
        ),
      ),
      body: Container(
          color: kWhiteColor,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: (subcategory!=null && subcategory.length>0)?
          GridView.builder(
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 10,
                crossAxisCount: 3,
                crossAxisSpacing: 20,
                childAspectRatio: 0.65,
              ),
              itemCount: subcategory.length,
              shrinkWrap: true,
              primary: false,
              // physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, PageRoutes.cat_product, arguments: {
                      'title': subcategory[index].title,
                      'storeid': store_id,
                      'cat_id': subcategory[index].cat_id,
                      'storedetail': storedetail,
                    });
                  },
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    children: [
                      Container(
                        height: 100,
                        padding: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: kWhiteColor,
                            borderRadius:
                            BorderRadius.circular(
                                10)),
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl:
                            '${subcategory[index].image}',
                            placeholder: (context, url) =>
                                Align(
                                  widthFactor: 50,
                                  heightFactor: 50,
                                  alignment: Alignment.center,
                                  child: Container(
                                    padding:
                                    const EdgeInsets.all(
                                        5.0),
                                    width: 50,
                                    height: 50,
                                    child:
                                    CircularProgressIndicator(),
                                  ),
                                ),
                            errorWidget: (context, url,
                                error) =>
                                Image.asset(
                                    'assets/icon.png'),
                            fit: BoxFit.fill,
                          ),
                        ),
                        // child:Image.asset('assets/icon.png'),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        '${subcategory[index].title}',
                        textAlign: TextAlign.center,
                        maxLines: 2,
                      )
                    ],
                  ),
                );
              }):
          Align(
            alignment: Alignment.center,
            child: Text(locale.nocatfount1),
          )
      ),
    );
  }
}
