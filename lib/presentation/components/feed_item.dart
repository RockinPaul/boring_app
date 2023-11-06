import 'package:flutter/material.dart';

class FeedItem extends StatelessWidget {
  final String image;
  final String title;
  final String subtitle;
  final String description;
  final double price;

  const FeedItem({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(child: Text(title, style: const TextStyle(fontSize: 20))),
          const SizedBox(height: 8),
          Flexible(child: Text(subtitle, style: const TextStyle(color: Colors.grey))),
          const Spacer(),
          const Flexible(
            child: Row(
              children: <Widget>[
                Text(
                  '0.00 \$',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 16),
              ],
            ),
          )
        ],
      ),
    );
  }
}
