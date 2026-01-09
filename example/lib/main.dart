import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (_, child) => Portal(child: child!),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title});

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? ''),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          ElevatedButton(
            onPressed: () {
              print(key.currentState!.controller!.markupText);
            },
            child: const Text('Get Text'),
          ),
          FlutterMentions(
            key: key,
            suggestionPosition: SuggestionPosition.top,
            maxLines: 5,
            minLines: 1,
            decoration: const InputDecoration(hintText: 'hello'),
            mentions: [
              Mention(
                trigger: '@',
                style: const TextStyle(
                  color: Colors.amber,
                ),
                data: [
                  {
                    'id': '61as61fsa',
                    'display': 'fayeedP',
                    'full_name': 'Fayeed Pawaskar',
                    'photo':
                        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
                  },
                  {
                    'id': '61asasgasgsag6a',
                    'display': 'khaled',
                    'full_name': 'DJ Khaled',
                    'style': const TextStyle(color: Colors.purple),
                    'photo':
                        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
                  },
                  {
                    'id': 'asfgasga41',
                    'display': 'markT',
                    'full_name': 'Mark Twain',
                    'photo':
                        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
                  },
                  {
                    'id': 'asfsaf451a',
                    'display': 'JhonL',
                    'full_name': 'Jhon Legend',
                    'photo':
                        'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940'
                  },
                ],
                matchAll: false,
                suggestionBuilder: (data) {
                  return Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage: NetworkImage(
                            data['photo'],
                          ),
                        ),
                        const SizedBox(
                          width: 20.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(data['full_name']),
                            Text('@${data['display']}'),
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
              Mention(
                trigger: '#',
                disableMarkup: true,
                style: const TextStyle(
                  color: Colors.blue,
                ),
                data: [
                  {'id': 'reactjs', 'display': 'reactjs'},
                  {'id': 'javascript', 'display': 'javascript'},
                ],
                matchAll: true,
              )
            ],
          ),
        ],
      ),
    );
  }
}
