import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';

import '../../../core/provider/app_config_provider.dart';
import '../../../utils/color_resource/color_resources.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppConfigProvider>(context);

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: ColorResources.primaryLightColor,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.25,
            child: Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.arrow_back_ios_sharp,
                        color: provider.isDark()
                            ? ColorResources.blackText
                            : ColorResources.white)),
                Padding(
                  padding: const EdgeInsets.all(50),
                  child: Text(
                    AppLocalizations.of(context)!.appTitle,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: provider.isDark()
                            ? ColorResources.blackText
                            : ColorResources.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
