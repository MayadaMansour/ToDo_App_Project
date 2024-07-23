import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/app_config_provider.dart';
import '../../../utils/color_resource/color_resources.dart';

class ModeButtomSheet extends StatefulWidget {
  const ModeButtomSheet({super.key});

  @override
  State<ModeButtomSheet> createState() => _ModeButtomSheetState();
}

class _ModeButtomSheetState extends State<ModeButtomSheet> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);
    return Container(
      height: 150,
      color:
          provider.isDark() ? ColorResources.bgDarkColor : ColorResources.white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            InkWell(
                onTap: () {
                  provider.changeMode(ThemeMode.light);
                },
                child: !(provider.isDark())
                    ? getSelectedItemWidget(
                        AppLocalizations.of(context)!.lightMode)
                    : getUnSelectedItemWidget(
                        AppLocalizations.of(context)!.lightMode)),
            const SizedBox(
              height: 15,
            ),
            InkWell(
                onTap: () {
                  provider.changeMode(ThemeMode.dark);
                },
                child: provider.isDark()
                    ? getSelectedItemWidget(
                        AppLocalizations.of(context)!.darkMode)
                    : getUnSelectedItemWidget(
                        AppLocalizations.of(context)!.darkMode)),
          ],
        ),
      ),
    );
  }

  Widget getSelectedItemWidget(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: ColorResources.primaryLightColor)),
        Icon(
          Icons.check,
          size: 30,
          color: ColorResources.primaryLightColor,
        )
      ],
    );
  }

  Widget getUnSelectedItemWidget(String text) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .bodySmall
          ?.copyWith(color: ColorResources.blackText),
    );
  }
}
