import 'package:examen_flutter/screens/anuncios/bloc/anuncios_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnunciosSearchBar extends StatefulWidget {
  const AnunciosSearchBar({super.key});

  @override
  State<AnunciosSearchBar> createState() => _AnunciosSearchBarState();
}

class _AnunciosSearchBarState extends State<AnunciosSearchBar> {
  late TextEditingController _searchController;
  late AnunciosCubit _anunciosCubit;
  // Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _anunciosCubit = context.read<AnunciosCubit>();
    _searchController.addListener(_onTextChange);
  }

  _onTextChange(){
   // _debounce?.cancel();
   //  _debounce = Timer(const Duration(milliseconds: 100), () {
   // });
    _anunciosCubit.buscaAnuncios(_searchController.text);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      decoration: const InputDecoration(
          border: OutlineInputBorder(),
          prefixIcon: Icon(Icons.search),
          hintText: 'Buscar'
      ),
    );
  }
}
