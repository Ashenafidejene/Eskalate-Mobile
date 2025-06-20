import 'package:flutter/material.dart';

class DetailView extends StatelessWidget {
  final String title;
  final String value;

  const DetailView({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          Expanded(
            child: Text(value, style: Theme.of(context).textTheme.bodyLarge),
          ),
        ],
      ),
    );
  }
}
