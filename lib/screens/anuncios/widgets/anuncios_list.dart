import 'dart:async';

import 'package:examen_flutter/models/api_response/anuncio_model.dart';
import 'package:examen_flutter/screens/anuncios/bloc/anuncios_cubit.dart';
import 'package:examen_flutter/screens/anuncios/bloc/anuncios_state.dart';
import 'package:examen_flutter/screens/anuncios/bloc/categorias_cubit.dart'
    as categorias;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'anuncio_list_item.dart';

class AnunciosList extends StatefulWidget {
  const AnunciosList({super.key});

  @override
  State<AnunciosList> createState() => AnunciosListState();
}

class AnunciosListState extends State<AnunciosList> {
  late AnunciosCubit _anunciosCubit;
  late categorias.CategoriasCubit _categoriasCubit;
  final PagingController<int, AnuncioModel> _pagingController =
      PagingController(firstPageKey: 0);
  Timer? _debounce;
  String? _busqueda;
  static const _pageSize = 5;
  int _pageKey = 0;

  @override
  void initState() {
    super.initState();
    _anunciosCubit = context.read<AnunciosCubit>();
    _categoriasCubit = context.read<categorias.CategoriasCubit>();
    _pagingController.addPageRequestListener((pageKey) {
      _pageKey = pageKey;
      _anunciosCubit.consultaAnuncios(_busqueda,pageKey,_pageSize);
    });
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  void _updateSearchTerm(String busqueda) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _busqueda = busqueda;
      _pagingController.refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AnunciosCubit, AnunciosState>(
        listener: (context, state) {
          if (state is SuccessState) {
            final isLastPage = state.anuncios.length < _pageSize;
            if (isLastPage) {
              _pagingController.appendLastPage(state.anuncios);
            } else {
              var newpageKey = _pageKey + state.anuncios.length;
              _pagingController.appendPage(state.anuncios, newpageKey);
            }
          }
        },
        child: Column(
          children: [
            TextField(
              onChanged: _updateSearchTerm,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Buscar'),
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  _pagingController.refresh();
                  _categoriasCubit.consultaCategorias();
                },
                child: PagedListView.separated(
                  pagingController: _pagingController,
                  builderDelegate: PagedChildBuilderDelegate<AnuncioModel>(
                    itemBuilder: (context, item, index) =>
                        AnuncioListItem(item),
                  ),
                  separatorBuilder: (context, index) {
                    return const SizedBox(height: 20);
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
