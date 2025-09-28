import 'package:flutter/material.dart';

class StatBarChart extends StatelessWidget {
  final Map<String, int> baseStats;

  const StatBarChart({super.key, required this.baseStats});

  static const int maxStatValue = 255;

  String _getDisplayName(String key) {
    const Map<String, String> statNames = {
      'hp': 'HP',
      'attack': 'Attack',
      'defense': 'Def',
      'special-attack': 'Sp. Atk',
      'special-defense': 'Sp. Def',
      'speed': 'Speed',
    };
    return statNames[key] ?? key.toUpperCase();
  }

  Color _getStatColor(String key) {
    switch (key) {
      case 'hp':
        return Colors.green.shade600;
      case 'attack':
        return Colors.red.shade600;
      case 'defense':
        return Colors.blue.shade600;
      case 'special-attack':
        return Colors.purple.shade600;
      case 'special-defense':
        return Colors.lightBlue.shade600;
      case 'speed':
        return Colors.amber.shade700;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> statWidgets = baseStats.entries.map((entry) {
      final String statKey = entry.key;
      final int statValue = entry.value;

      final double progress = statValue / maxStatValue;
      final Color statColor = _getStatColor(statKey);

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: <Widget>[
            // 1. Stat Name
            SizedBox(
              width: 70,
              child: Text(_getDisplayName(statKey), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
            ),

            // 2. Stat Value
            SizedBox(
              width: 40,
              child: Text(
                statValue.toString(),
                textAlign: TextAlign.right,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            ),

            const SizedBox(width: 8),

            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: statColor.withAlpha(50),
                  valueColor: AlwaysStoppedAnimation<Color>(statColor),
                  minHeight: 8,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: statWidgets);
  }
}
