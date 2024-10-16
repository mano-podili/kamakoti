import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;

  void getThemeMode() async {
    final savedThemeMode = await AdaptiveTheme.getThemeMode();
    if (savedThemeMode == AdaptiveThemeMode.dark) {
      setState(() {
        isDarkMode = true;
      });
    } else{
        setState(() {
        isDarkMode = false;
      });
    }
  }
  
  @override
  void initState() {
    getThemeMode();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Card(
          child: SwitchListTile(
            title: const Text('Change Theme'),
            value: isDarkMode,
            onChanged: (value){
              setState(() {
                isDarkMode = value;
              });
              if (value) {
                AdaptiveTheme.of(context).setDark();
              } else{
                AdaptiveTheme.of(context).setLight();
              }
            }
          ),
        )
      )
    );
  }
}
