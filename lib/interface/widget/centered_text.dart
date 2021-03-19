import 'package:flutter/material.dart';

class CenteredText extends StatelessWidget {
  final String? label;

  const CenteredText({Key? key, @required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(this.label!, style: Theme.of(context).textTheme.bodyText1, textAlign: TextAlign.center),
      ),
    );
  }
}
