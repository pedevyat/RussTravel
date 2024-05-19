
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class Kaliningrad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: loadDescription(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Image.network(
                    'https://cdn.tripster.ru/thumbs2/f33768f6-49fa-11ee-a338-4a562d065b03.1220x600.jpeg',
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: buildDescriptionWidget(snapshot.data ?? ''),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget buildDescriptionWidget(String description) {
    final RegExp urlRegExp = RegExp(r'http(s)?://\S+');
    final Iterable<Match> matches = urlRegExp.allMatches(description);

    List<TextSpan> textSpans = [];

    int start = 0;
    for (Match match in matches) {
      if (match.start > start) {
        textSpans.add(TextSpan(text: description.substring(start, match.start)));
      }

      String url = description.substring(match.start, match.end);
      textSpans.add(TextSpan(
        text: url,
        style: TextStyle(color: Colors.blue),
        recognizer: TapGestureRecognizer()
          ..onTap = () {
            launch(url);
          },
      ));

      start = match.end;
    }

    if (start < description.length) {
      textSpans.add(TextSpan(text: description.substring(start)));
    }

    return Text.rich(TextSpan(children: textSpans));
  }

  Future<String> loadDescription() async {
    return await rootBundle.loadString('assets/SZFO/Kaliningrad.txt');
  }
}
