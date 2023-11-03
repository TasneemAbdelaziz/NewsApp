import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news/Provider/app_config_provider.dart';
import 'package:news/Theming/my-theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Settings extends StatefulWidget {
  @override
  State<Settings> createState() => _settingsTabState();
}

class _settingsTabState extends State<Settings> {

    @override
  Widget build(BuildContext context) {
      var provider = Provider.of<appConfigProvider>(context);
      String language = provider.appLanguage=='en'?"English":"Arabic";

      return Stack(
      children: [
        Image.asset(
          'assets/images/pattern.png',
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                  AppLocalizations.of(context)!.language,
              ),
              SingleChildScrollView(
                child: Container(
                  margin: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: myTheme.primaryLight,
                      width: 2,
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: language,
                      icon: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.arrow_drop_down_outlined,
                          color: myTheme.primaryLight,
                        ),
                      ),
                      onChanged: (String? newValue) {
                        setState(() {
                          language = newValue!;
                        });
                      },
                      items: [
                        DropdownMenuItem<String>(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                            AppLocalizations.of(context)!.english,
                                style: Theme.of(context).textTheme.bodyMedium,
                              )),
                          value: "English",
                          onTap: (){
                            provider.changeAppLanguage("en");
                          },
                        ),
                        DropdownMenuItem<String>(
                          child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                AppLocalizations.of(context)!.arabic,
                                style: Theme.of(context).textTheme.bodyMedium,
                              )),
                          value: "Arabic",
                          onTap: (){
                            provider.changeAppLanguage("ar");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
