import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grocery/Locale/locales.dart';
import 'package:grocery/language_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Components/custom_button.dart';
import '../../Theme/colors.dart';

class ChooseLanguageNew extends StatefulWidget {
  @override
  _ChooseLanguageNewState createState() => _ChooseLanguageNewState();
}

class _ChooseLanguageNewState extends State<ChooseLanguageNew> {
  LanguageCubit _languageCubit;
  List<int> radioButtons = [0, -1, -1, -1, -1];
  String selectedLanguage;
  List<String> languages = [];
  int selectedIndex = -1;
  bool enteredFirst = false;

  @override
  void initState() {
    super.initState();
    _languageCubit = BlocProvider.of<LanguageCubit>(context);
  }

  getAsyncValue(List<String> languagesd, AppLocalizations locale) async {
    SharedPreferences.getInstance().then((prefs) {
      if (prefs.containsKey('language') &&
          prefs.getString('language').length > 0) {
        String langCode = prefs.getString('language');
        if (langCode == 'en') {
          selectedLanguage = locale.englishh;
        }
        // else if (langCode == 'bg') {
        //   selectedLanguage = locale.bulgarian;
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
      languages = [
        locale.englishh
      ];
      getAsyncValue(languages, locale);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          locale.languages,
          style: TextStyle(
            color: Theme.of(context).backgroundColor,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                top: 20.0, left: 16, right: 16, bottom: 16),
            child: Text(
              locale.selectPreferredLanguage,
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
              child: SingleChildScrollView(
                primary: true,
                child: ListView.builder(
                  itemCount: languages.length,
                  shrinkWrap: true,
                  primary: false,
                  itemBuilder: (context, index) {
                    return Container(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                            print(selectedIndex);
                          });
                        },
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          children: [
                            Radio(
                              activeColor: kMainColor,
                              value: index,
                              groupValue: selectedIndex,
                              toggleable: false,
                              onChanged: (valse) {
                                setState(() {
                                  selectedIndex = index;
                                  print(selectedIndex);
                                });
                              },
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text('${languages[index]}',style: TextStyle(
                                fontSize: 16
                            ))
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )),
          CustomButton(
            label: locale.save,
            onTap: () {
              if (selectedIndex >= 0) {
                setState(() {
                  selectedLanguage = languages[selectedIndex];
                });
                if (selectedLanguage == locale.englishh) {
                  _languageCubit.selectEngLanguage();
                }
              }
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

