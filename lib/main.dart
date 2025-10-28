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
          useMaterial3: true, // Usar Material 3 para un look más moderno
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = "Hello World";

  // Agreguemos una función para que el botón que vamos a crear haga algo
  void updateText() {
    if (current == "Hello World") {
      current = "Flutter Es Genial!";
    } else {
      current = "Hello World";
    }
    notifyListeners(); // Notifica a los widgets que están escuchando
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('LDSW - Widgets Básicos'),
        backgroundColor: theme.colorScheme.primaryContainer,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Demostración de Widgets:',
              style: theme.textTheme.headlineMedium,
            ),
            SizedBox(height: 20),

            // WIDGET: Container
            // Un widget de conveniencia que combina pintado, posicionamiento
            // y tamaño. Aquí lo usamos para añadir un margen y una sombra.
            Container(
              margin: EdgeInsets.all(20.0), // Margen exterior
              decoration: BoxDecoration(
                // Decoración para la sombra
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
                borderRadius: BorderRadius.circular(12), // Redondeo de bordes
              ),
              child: BigCard(pair: pair), // El widget hijo
            ),
            SizedBox(height: 30),

            // WIDGET: Row
            // Organiza una lista de widgets hijos en un eje horizontal.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Distribuye el espacio
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Llama a la función en el estado para cambiar el texto
                    appState.updateText();
                  },
                  child: Text('Cambiar Texto'),
                ),
                OutlinedButton(
                  onPressed: () {
                    // Botón de ejemplo sin acción
                  },
                  child: Text('Otro Botón'),
                ),
              ],
            ),
          ],
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
      child:
          // WIDGET: Stack
          // Un widget que apila a sus hijos uno encima del otro.
          // Es útil para superponer widgets.
          Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(40.0), // Más padding para dar espacio al icono
            child: Text(
              pair.toLowerCase(),
              style: style,
              textAlign: TextAlign.center,
            ),
          ),

          // Hijo 2: Un icono (superpuesto en la esquina superior derecha)
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
