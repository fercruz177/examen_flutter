import 'package:examen_flutter/models/api_response/categoria_model.dart';
import 'package:examen_flutter/screens/anuncios/bloc/categorias_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AnunciosCategoriasFilter extends StatefulWidget {
  final ValueChanged<List<String>>? onChange;

  const AnunciosCategoriasFilter({this.onChange, super.key});

  @override
  State<AnunciosCategoriasFilter> createState() =>
      _AnunciosCategoriasFilterState();
}

class _AnunciosCategoriasFilterState extends State<AnunciosCategoriasFilter> {
  late CategoriasCubit _categoriasCubit;
  Set<CategoriaModel> filters = <CategoriaModel>{};

  @override
  void initState() {
    super.initState();
    _categoriasCubit = context.read<CategoriasCubit>();
    _categoriasCubit.consultaCategorias();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriasCubit, CategoriasState>(
      builder: (context, state) {
        if (state is SuccessState) {
          return ListView.separated(
            itemCount: state.categorias.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              var categoria = state.categorias[index];
              return FilterChip(
                label: Text(categoria.nombre),
                selected: filters.contains(categoria),
                onSelected: (selected) {
                  setState(() {
                    if (selected) {
                      filters.add(categoria);
                    } else {
                      filters.remove(categoria);
                    }
                    widget.onChange?.call(filters
                        .map(
                          (e) => e.nombre,
                        )
                        .toList());
                  });
                },
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 8);
            },
          );
        } else {
          return Container();
        }
      },
    );
  }
}
