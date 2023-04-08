import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class WidgetDrink extends StatefulWidget {
  final String name;
  final String thumb;
  const WidgetDrink({super.key, required this.name, required this.thumb});

  @override
  State<WidgetDrink> createState() => _WidgetDrinkState();
}

class _WidgetDrinkState extends State<WidgetDrink> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
          widget.thumb,
          width: 180,
        ),
        const SizedBox(width: 16.0),
        Text(
          widget.name,
          style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              // OVERFLOW UNTUK TEXT JADI ...
              overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
