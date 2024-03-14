const String pokemonAuthority = 'pokeapi.co';
const String pokemonBaseApi = '/api/v2';
String getPokemonImage(pokeId) =>
    'https://raw.githubusercontent.com/PokeAPI/pokeapi/master/data/v2/sprites/pokemon/$pokeId.png';
String imageUrl(name) => 'https://img.pokemondb.net/artwork/$name.jpg';
