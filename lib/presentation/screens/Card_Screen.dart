import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/core/generated/locale_keys.g.dart';
import 'package:flutter_application_firebase/presentation/bloc/cardbloc/card_bloc.dart';
import 'package:flutter_application_firebase/presentation/bloc/cardbloc/card_event.dart';
import 'package:flutter_application_firebase/presentation/bloc/cardbloc/card_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.cart.tr()),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is CartLoaded && state.items.isNotEmpty) {
            return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final item = state.items[index];
                return ListTile(
                  title: Text(item.name),
                  subtitle: Text(item.price),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_shopping_cart),
                    onPressed: () {
                      context.read<CartBloc>().add(RemoveItemFromCart(item));
                    },
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('Your cart is empty'));
          }
        },
      ),
    );
  }
}