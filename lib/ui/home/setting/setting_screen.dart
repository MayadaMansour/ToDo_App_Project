import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/app_config_provider.dart';
import '../../../utils/color_resource/color_resources.dart';
import 'language_buttom_sheet.dart';
import 'mode_buttom_sheet.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Container(
      margin: const EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.language,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: provider.isDark()
                      ? ColorResources.white
                      : ColorResources.blackText,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              showLanguageButtonSheet();
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: ColorResources.primaryLightColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.appLanguage == "en"
                        ? AppLocalizations.of(context)!.english
                        : AppLocalizations.of(context)!.arabic,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Icon(
                    Icons.arrow_drop_down_sharp,
                    size: 30,
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            AppLocalizations.of(context)!.mode,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: provider.isDark()
                      ? ColorResources.white
                      : ColorResources.blackText,
                ),
          ),
          const SizedBox(
            height: 10,
          ),
          InkWell(
            onTap: () {
              showModeButtomSheet();
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                  color: ColorResources.primaryLightColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    provider.isDark()
                        ? AppLocalizations.of(context)!.darkMode
                        : AppLocalizations.of(context)!.lightMode,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const Icon(
                    Icons.arrow_drop_down_sharp,
                    size: 30,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void showLanguageButtonSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => const LanguageButtomSheet());
  }

  void showModeButtomSheet() {
    showModalBottomSheet(
        context: context, builder: (context) => const ModeButtomSheet());
  }
}
