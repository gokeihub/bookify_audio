import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:startapp_sdk/startapp.dart';

class AppInformationPage extends StatefulWidget {
  const AppInformationPage({super.key});

  @override
  State<AppInformationPage> createState() => _AppInformationPageState();
}

class _AppInformationPageState extends State<AppInformationPage> {
  String version = "";
  String appName = "";
  String packageName = "";
  var startApp = StartAppSdk();
  StartAppBannerAd? bannerAds;

  loadBannerAds() {
    startApp.setTestAdsEnabled(true);
    startApp.loadBannerAd(StartAppBannerType.BANNER).then((value) {
      setState(() {
        bannerAds = value;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _getAppVersion();
    loadBannerAds();
  }

  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String versionNumber = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    setState(() {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = '$versionNumber+$buildNumber';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Information"),
      ),
      bottomNavigationBar: bannerAds != null
          ? SizedBox(height: 60, child: StartAppBanner(bannerAds!))
          : const SizedBox(),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: const Text('App Version'),
              trailing: Text(version.toString()),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('App Name'),
              trailing: Text(appName.toString()),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Package Name'),
              trailing: Text(packageName.toString()),
            ),
          ),
        ],
      ),
    );
  }
}
