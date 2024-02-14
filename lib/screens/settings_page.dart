import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:music_player/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("S E T T I N G S"),
          centerTitle: true,
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          color: theme.colorScheme.secondary,
          ),
        
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("Dark Mode"),
              Switch(
                value: context.watch<ThemeProvider>().isDarkMode,
                onChanged: (value) =>
                    Provider.of<ThemeProvider>(context, listen: false)
                        .toggleTheme(),
              ),
            ],
          ),
        ));
  }
}
