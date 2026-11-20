import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  
  const SettingsPage( {super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Center(
        child: Column(
          children: [
            Text("name", style: TextStyle(fontSize: 30)).tr(),
            Text("full_name", style: TextStyle(fontSize: 30)).tr(),
            Text("info", style: TextStyle(fontSize: 30)).tr(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(onPressed: () {
                  setState(() {
                    context.setLocale(Locale('en'));
                  });
                },child: Text("EN"),),
                FloatingActionButton(onPressed: () {
                  setState(() {
                    context.setLocale(Locale('uz'));
                  });
                },child: Text("UZ"),),
                FloatingActionButton(onPressed: () {
                  setState(() {
                    context.setLocale(Locale('ru'));
                  });
                },child: Text("RU"),),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
