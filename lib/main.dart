//import 'package:english_words/english_words.dart';
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
        title: 'Mi app de Flutter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = "Hello World";
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {           // ← 1
    var appState = context.watch<MyAppState>();  // ← 2
    var pair = appState.current;
    final theme = Theme.of(context);
    return Scaffold(                             // ← 3
      body: Center(

        child: Column(    
          mainAxisAlignment: MainAxisAlignment.center,                          // ← 4
          children: [

            Text(
              'Welcome to Flutter!',
              style: theme.textTheme.headlineLarge,
            ),
            SizedBox(height: 20),
            
           BigCard(pair: pair),  
            // ElevatedButton(
            //   onPressed: () {
            //     appState.getNext();
            //   },
            //   child: Text('Next'),
            // ),
          ],                                       // ← 7
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final String pair;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
          child: Text(
          pair.toLowerCase(),
          style: style,
          //semanticsLabel: "${pair.first} ${pair.second}",
        ),

      ),
    );
  }
}



