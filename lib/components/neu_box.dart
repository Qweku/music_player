import 'package:flutter/material.dart';
import 'package:music_player/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class NeuBox extends StatelessWidget {
  final Widget? child;
  const NeuBox({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    // is dark mode
    bool isDarkMode =
        Provider.of<ThemeProvider>(context, listen: false).isDarkMode;
    return Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: theme.colorScheme.background,
            boxShadow: [
              BoxShadow(
                  color: isDarkMode ? Colors.black : Colors.grey.shade500,
                  blurRadius: 15,
                  offset: const Offset(4, 4)),
              BoxShadow(
                  color: isDarkMode ? Colors.grey.shade800 : Colors.white,
                  blurRadius: 15,
                  offset: const Offset(-4, -4)),
            ]),
        child: child);
  }
}
