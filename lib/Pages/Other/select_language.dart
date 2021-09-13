import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Locale/locales.dart';
import 'package:grocery/Theme/colors.dart';
import 'package:grocery/language_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChooseLanguage extends StatefulWidget {
  @override
  _ChooseLanguageState createState() => _ChooseLanguageState();
}

class _ChooseLanguageState extends State<ChooseLanguage> {
  LanguageCubit _languageCubit;
  bool islogin = false;
  List<int> radioButtons = [0, -1, -1, -1, -1];
  String selectedLanguage;
  int selectedIndex = -1;
  bool enteredFirst = false;
  var userName;
  List<String> languages = [];

  @override
  void initState() {
    super.initState();
    getSharedValue();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
  }

  void getSharedValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('user_name');
      islogin = prefs.getBool('islogin');
    });
  }

  getAsyncValue(List<String> languagesd, AppLocalizations locale) async {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey('language') &&
          prefs.getString('language').length > 0) {
        String langCode = prefs.getString('language');
        if (langCode == 'en') {
          selectedLanguage = locale.englishh;
        }
        // else if(langCode == 'en'){
        //   selectedLanguage = locale.englishh;
        // }
        setState(() {
          selectedIndex = languages.indexOf(selectedLanguage);
        });
      } else {
        selectedIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    if (!enteredFirst) {
      setState(() {
        enteredFirst = true;
      });
      languages = [locale.englishh];
      getAsyncValue(languages, locale);
    }
    return Scaffold(
      backgroundColor: kMainPageBGColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        title: Text(
          locale.languages,
          style: TextStyle(color: kMainTextColor),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Expanded(
          //     child:
          //
          // ),
          Image.asset(
            'assets/langugae.png',
            fit: BoxFit.fill,
            height: 200,
          ),
          Expanded(
              child: Container(
            color: kWhiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Choose a language',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 25,
                      color: kMainTextColor),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Text(
                    'Select your preferred language while using this app',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 18,
                        color: kLightTextColor),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: kWhiteColor,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.only(bottom: 15),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: GridView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            mainAxisSpacing: 0,
                            crossAxisCount: 3,
                            crossAxisSpacing: 0,
                            childAspectRatio: (2.5 / 1),
                          ),
                          itemCount: languages.length,
                          shrinkWrap: true,
                          primary: false,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                  print(selectedIndex);
                                });
                              },
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                color: kButtonTextColor,
                                padding: const EdgeInsets.all(3),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: (selectedIndex == index)
                                          ? kWhiteColor
                                          : kButtonTextColor,
                                      borderRadius: (selectedIndex == index)
                                          ? BorderRadius.circular(3)
                                          : BorderRadius.circular(0)),
                                  child: Text(
                                    '${languages[index]}',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
                  child: MaterialButton(
                    onPressed: () {
                      if (selectedIndex >= 0) {
                        setState(() {
                          selectedLanguage = languages[selectedIndex];
                        });
                        if (selectedLanguage == locale.englishh) {
                          _languageCubit.selectEngLanguage();
                        }
                      }

                      // else if (selectedLanguage == 'Indonesian') {
                      //   _languageCubit.selectIndonesianLanguage();
                      // }
                      Navigator.pop(context);
                    },
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    color: kMainColor,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    child: Text(
                      'Continue',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17,
                          color: kWhiteColor),
                    ),
                  ),
                )
              ],
            ),
          )),
        ],
      ),
    );
  }
}
