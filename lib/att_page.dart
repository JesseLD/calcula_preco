import 'dart:async';
import 'package:calcula_preco/shortcut0.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class att extends StatefulWidget {
  final String storeUrl = "https://github.com/DevMonts/calcula_preco.git";
  final String latestVersion = "1.2.0";
  @override
  _attState createState() => _attState();
}

class _attState extends State<att> {
  bool _isCheckingVersion = true;
  bool _isOutdated = false;
  String _version = '';
  @override
  void initState() {
    super.initState();
    _checkVersion();
  }

  Future<void> _checkVersion() async {
    final info = await PackageInfo.fromPlatform();
    String currentVersion = info.version;
    bool outdated = _checkIfOutdated(currentVersion, widget.latestVersion);
    if (!outdated) {
      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (context) => shortcut0()));
    } else {
      setState(() {
        _version = currentVersion;
        _isOutdated = outdated;
        _isCheckingVersion = false;
      });
    }
  }

  bool _checkIfOutdated(String currentVersion, String latestVersion) {
    List<int> current = currentVersion.split('.').map(int.parse).toList();
    List<int> latest = latestVersion.split('.').map(int.parse).toList();
    for (int i = 0; i < latest.length; i++) {
      if (i >= current.length || current[i] < latest[i]) {
        return true;
      } else if (current[i] > latest[i]) {
        return false;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    if (_isCheckingVersion) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.primary,
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Versão $_version"),
            Text("Atualização Necessária", style: TextStyle(color: Colors.red)),
            SizedBox(height: 5),
            ElevatedButton(
              onPressed: () async {
                final Uri url = Uri.parse(widget.storeUrl);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                } else {
                  debugPrint("Erro no Link");
                }
              },
              child: const Text("Atualizar"),
            ),
          ],
        ),
      ),
    );
  }
}
