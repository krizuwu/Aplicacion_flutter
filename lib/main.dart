import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http; 
import 'dart:convert'; 


import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
            'assets/mi_imagen_de_fondo.jpg', 
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey[300],
                alignment: Alignment.center,
                child: Text(
                  'Error al cargar imagen de fondo.\nVerifica assets/mi_imagen_de_fondo.jpg',
                  textAlign: TextAlign.center,
                ),
              );
            },
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
                
                SizedBox(height: 40), 
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.primary,
                    foregroundColor: theme.colorScheme.onPrimary,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PokemonPage()),
                    );
                  },
                  child: Text(
                    'Ir a la PokeAPI',
                    style: theme.textTheme.titleMedium!.copyWith(
                      color: theme.colorScheme.onPrimary,
                    ),
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

class PokemonPage extends StatefulWidget {
  @override
  _PokemonPageState createState() => _PokemonPageState();
}

class _PokemonPageState extends State<PokemonPage> {
  String _pokemonName = '...';
  String? _pokemonImageUrl;
  bool _isLoading = false;


  Future<void> _fetchPokemonData() async {
    setState(() {
      _isLoading = true;
      _pokemonName = 'Buscando...';
      _pokemonImageUrl = null;
    });

    try {
      final pokemonId = (DateTime.now().millisecondsSinceEpoch % 898) + 1;
      final url = Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonId');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          _pokemonName = data['name'];
          _pokemonImageUrl = data['sprites']['other']['official-artwork']['front_default'] 
                              ?? data['sprites']['front_default'];
          _isLoading = false;
        });
      } else {
        setState(() {
          _pokemonName = 'Error al cargar';
          _pokemonImageUrl = null;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _pokemonName = 'Error de conexión';
        _pokemonImageUrl = null;
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchPokemonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta a PokeAPI'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (_pokemonImageUrl != null)
                Image.network(
                  _pokemonImageUrl!,
                  height: 250,
                  width: 250,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 250,
                      width: 250,
                      alignment: Alignment.center,
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    );
                  },
                ),

              if (_isLoading && _pokemonImageUrl == null)
                Container(
                  height: 250,
                  width: 250,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(),
                ),

              SizedBox(height: 20),
              
              Text(
                _pokemonName.toUpperCase(),
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              
              SizedBox(height: 40),
              
              ElevatedButton(
                onPressed: _isLoading ? null : _fetchPokemonData,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                ),
                child: Text('¡Buscar otro Pokémon!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}