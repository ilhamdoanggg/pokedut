import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kt_dart/collection.dart';
import 'package:pokedut/models/pokemon/pokemon.dart';
import 'package:pokedut/models/pokemonapi.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: (RouteSettings settings) {
        Object? params = settings.arguments;
        return null;
      },
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool _isLoading = false;
  final ScrollController _scrollController =
      ScrollController(debugLabel: 'pokemonSc');
  KtList<Pokemon> _pokemonList = emptyList();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _fetchPokemonList();

    _scrollController.addListener(() {
      if (!_isLoading && _scrollController.position.extentAfter == 00) {
        _fetchPokemonList();
      }
    });
  }

  _fetchPokemonList() async {
    setState(() {
      _isLoading = true;
    });
    final pokemonList = await PokemonApi().getPokemonList(_pokemonList.size);
    setState(() {
      _pokemonList = pokemonList.plus(pokemonList);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Scaffold(
            body: CustomScrollView(
      controller: _scrollController,
      slivers: Widget[SliverGrid(
          delegate: SliverChildBuilderDelegate((context, index) => null),
          gridDelegate: gridDelegate)],
    )));
  }
}

class ImageColoredShadow extends StatelessWidget {
  const ImageColoredShadow({super.key});
  @override
  Widget build(BuildContext context) {
    double size = 200.0;
    double blurRadius = 20.0;
    double blurSigma = 7.0;
    // String imageUrl =
    //     'https://mp-prod-de-medialib.s3-eu-central-1.amazonaws.com/motivwelt/stockimage/buntes-laub/overview/buntes-laub-l.jpg';
    String imageUrl =
        // 'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/132.png';
        'https://img.pokemondb.net/artwork/bulbasaur.jpg';

    return Stack(children: [
      Center(
          child: ClipRRect(
              child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    width: size + blurRadius,
                    height: size + blurRadius,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover, image: NetworkImage(imageUrl))),
                  )))),
      Positioned.fill(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
              child: Container(color: Colors.black.withOpacity(0)))),
      Positioned.fill(
        child: Center(
          child: Container(
              width: size,
              height: size,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      fit: BoxFit.cover, image: NetworkImage(imageUrl)))),
        ),
      )
    ]);
  }
}
