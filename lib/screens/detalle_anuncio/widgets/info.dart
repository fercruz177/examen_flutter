import 'package:examen_flutter/core/extensions.dart';
import 'package:examen_flutter/screens/detalle_anuncio/bloc/detalle_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Info extends StatelessWidget {
  const Info({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DetalleCubit, DetalleState>(
      builder: (context, state) {
        switch(state){
          case LoadingState():{
            return Center(child: CircularProgressIndicator());
          }
          case SuccessState():{
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(state.anuncio.titulo, style: Theme.of(context).textTheme.headlineMedium,),
                          Text('\$${state.anuncio.precio.toCurrencyFormat()}', style: Theme.of(context).textTheme.headlineSmall,)
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.star),
                            Text('4.8'),
                            SizedBox(width: 15),
                            Text('100 reviews')
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {}, child: Text('Mapa'), style: ButtonStyle(

                        ),)
                      ],
                    )
                  ],
                ),
                SizedBox(height: 30,),
                Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.')
              ],
            );
          }
          case ErrorState():{
            return Text('');
          }
        }

      },
    );
  }
}
