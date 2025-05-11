import 'package:flutter/material.dart';
import 'package:spender_tracker/core/theme/app_theme.dart';
import 'package:spender_tracker/features/profile/sub_features/about_us/domain/model/app_info_model.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateRequiredDialog extends StatelessWidget {
  final AppInfoModel appModel;

  const UpdateRequiredDialog({super.key, required this.appModel});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.getTheme(false),
      darkTheme: AppTheme.getTheme(true),
      themeMode:
          Theme.of(context).brightness == Brightness.dark
              ? ThemeMode.dark
              : ThemeMode.light,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.system_update, size: 80, color: Colors.blue),
                const SizedBox(height: 24),
                Text(
                  'Update Required',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 16),
                Text(
                  'A new version (${appModel.latestVersion}) is available. Please update to continue using the app.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    final url = 'https://play.google.com/store/apps/details?id=com.dts.freefiremax';

                    if (url != null) {
                      launchUrl(Uri.parse(url), mode: LaunchMode.externalNonBrowserApplication);
                    }
                  },
                  child: const Text('Update Now'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
