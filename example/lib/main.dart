import 'package:flutter/material.dart';
import 'package:flutter_mentions/flutter_mentions.dart';

void main() {
  runApp(const MyApp());
}

@immutable
class CustomMentionData extends MentionData {
  const CustomMentionData({
    required super.id,
    required super.display,
    super.style,
    required this.fullName,
    required this.photo,
  });

  final String fullName;
  final String photo;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Portal(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, this.title}) : super(key: key);

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
        title: Text(widget.title!),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          ElevatedButton(
            child: const Text('Get Text'),
            onPressed: () {
              print(key.currentState!.controller!.markupText);
            },
          ),
          Flexible(
            child: FlutterMentions(
              key: key,
              suggestionPosition: SuggestionPosition.Top,
              maxLines: 5,
              minLines: 1,
              decoration: const InputDecoration(hintText: 'hello'),
              mentions: [
                Mention<CustomMentionData>(
                  trigger: '@',
                  style: const TextStyle(
                    color: Colors.amber,
                  ),
                  data: const [
                    CustomMentionData(
                      id: '61as61fsa',
                      display: 'fayeedP',
                      fullName: 'Fayeed Pawaskar',
                      photo:
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                    ),
                    CustomMentionData(
                      id: '61asasgasgsag6a',
                      display: 'khaled',
                      fullName: 'DJ Khaled',
                      style: TextStyle(color: Colors.purple),
                      photo:
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                    ),
                    CustomMentionData(
                      id: 'asfgasga41',
                      display: 'markT',
                      fullName: 'Mark Twain',
                      photo:
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                    ),
                    CustomMentionData(
                      id: 'asfsaf451a',
                      display: 'JhonL',
                      fullName: 'Jhon Legend',
                      photo:
                          'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=2&h=650&w=940',
                    ),
                  ],
                  matchAll: false,
                  suggestionBuilder: (CustomMentionData data) {
                    return Container(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: NetworkImage(data.photo),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          Column(
                            children: <Widget>[
                              Text(data.fullName),
                              Text('@${data.display}'),
                            ],
                          )
                        ],
                      ),
                    );
                  },
                ),
                const Mention(
                  trigger: '#',
                  disableMarkup: true,
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                  data: [
                    MentionData(id: 'reactjs', display: 'reactjs'),
                    MentionData(id: 'javascript', display: 'javascript'),
                  ],
                  matchAll: true,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
