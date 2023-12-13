import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/core/generated/locale_keys.g.dart';
import 'package:flutter_application_firebase/presentation/bloc/cardbloc/card_bloc.dart';
import 'package:flutter_application_firebase/presentation/bloc/cardbloc/card_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_firebase/presentation/bloc/shop_bloc/shop_bloc.dart';
import 'package:flutter_application_firebase/presentation/bloc/shop_bloc/shop_event.dart';
import 'package:flutter_application_firebase/presentation/bloc/shop_bloc/shop_state.dart';


class InstrumentsListScreen extends StatefulWidget {
  @override
  _InstrumentsListScreenState createState() => _InstrumentsListScreenState();
}

class _InstrumentsListScreenState extends State<InstrumentsListScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ShopBloc>().add(LoadInstrumentsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.music.tr()),
      ),
      body: BlocBuilder<ShopBloc, ShopState>(
        builder: (context, state) {
          if (state is ShopLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ShopLoaded) {
            if (state.instruments.isEmpty) {
              return Center(child: Text('No instruments available'));
            }
            return ListView.builder(
              itemCount: state.instruments.length,
              itemBuilder: (context, index) {
                final instrument = state.instruments[index];
                return Card(
                  child: ListTile(
                    leading: Image.asset('${instrument.photoUrl}'),
                    title: Text(instrument.name),
                    subtitle: Text(instrument.price),
                    onTap: () {
                      context.read<CartBloc>().add(AddItemToCart(instrument));
                    },
                  ),
                );
              },
            );
          } else if (state is ShopError) {
            return Center(child: Text('Error loading data'));
          } else {
            return Center(child: Text('Unexpected state'));
          }
        },
      ),
    );
  }
}