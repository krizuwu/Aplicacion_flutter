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
          useMaterial3: true,
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = "Hello World";

  void updateText() {
    if (current == "Hello World") {
      current = "Flutter Es Genial!";
    } else {
      current = "Hello World";
    }
    notifyListeners();
  }
}


class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   
    final theme = Theme.of(context);

    return Scaffold(
      
      appBar: AppBar(
        title: Text('LDSW - Tarea de Layout'),
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      
      
      body: Stack(
        
        fit: StackFit.expand, 
        children: [
    
          Image.asset(
           
            'assets/Fondo.jpg', 
            fit: BoxFit.cover,
          ),

         
          Container(
            color: Colors.black.withOpacity(0.5),
          ),

          Center(
            
            child: Column(
              
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                Text(
                  'Mi App de Flutter',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.displaySmall!.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16),

                
                Text(
                  '¡Te damos la bienvenida!',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium!.copyWith(
                    color: Colors.white70, 
                  ),
                ),
              ],
            ),
          ),
        ],
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
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0),
            child: Text(
              pair.toLowerCase(),
              style: style,
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Icon(
              Icons.star_border,
              color: Colors.yellow,
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}