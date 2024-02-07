import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'owo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair("Welcome, ", "Choose your path");

  void getNext() {
    current = WordPair("Welcome to ST, ", "Choose your path");
    notifyListeners();
  }

  void choice1() {
    current = WordPair("You died: ", "You got bullied so much in #lobby that you unalived yourself");
    notifyListeners();
  }
  void choice2() {
    current = WordPair("You died: ", "You got takfired so much in #discussion that you unalived yourself");
    notifyListeners();
  }
  void choice3() {
    current = WordPair("You survived: ", "You instead asked a question over at #islam-questions and therefore survived");
    notifyListeners();
  }

}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isShown = true;
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
    //case 1:
    //page = FavoritesPage();
      default:
        throw UnimplementedError('no widget for $selectedIndex');
    }

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        body: Row(
          children: [
            Expanded(
              child: Container(
                color: Theme.of(context).colorScheme.primaryContainer,
                child: page,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class GeneratorPage extends StatefulWidget {
  @override
  _GeneratorPageState createState() => _GeneratorPageState();
}

class _GeneratorPageState extends State<GeneratorPage> {
  bool buttonsVisible = true;

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          BigCard(pair: pair),
          SizedBox(height: 10),
          if (buttonsVisible)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      buttonsVisible = false;
                    });
                    appState.choice1();
                  },
                  child: Text('Secret'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      buttonsVisible = false;
                    });
                    appState.choice2();
                  },
                  child: Text('Possibly better?'),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      buttonsVisible = false;
                    });
                    appState.choice3();
                  },
                  child: Text('DO NOT PICK!!!'),
                ),
              ],
            ),
          if (!buttonsVisible)
            ElevatedButton(
              onPressed: () {
                setState(() {
                  buttonsVisible = true;
                });
                appState.getNext();
              },
              child: Text('Return'),
            ),
        ],
      ),
    );
  }
}

class BigCard extends StatefulWidget {
  final WordPair pair;

  const BigCard({Key? key, required this.pair}) : super(key: key);

  @override
  _BigCardState createState() => _BigCardState();
}

class _BigCardState extends State<BigCard> {
  bool textClicked = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return GestureDetector(
      onTap: () {
        setState(() {
          textClicked = !textClicked;
        });
      },
      child: Card(
        color: theme.colorScheme.primary,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.pair.first,
                style: style,
              ),
              SizedBox(height: 8),
              Text(
                widget.pair.second,
                style: style,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
