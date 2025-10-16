import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_provider/main.dart' show CartModel, catalog;

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text("Catalog"),
        actions: [
          Consumer<CartModel>(
            builder: (_, cart, i) {
              return IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed("/cart");
                },
                icon: Icon(Icons.shopping_bag),
              );
            },
          ),
        ],
      ),
      body: ListView.separated(
        itemBuilder: (_, i) {
          final item = catalog[i];
          final inCart = cart.contains(item);
          return ListTile(
            title: Text("${item.name} ->>> \$${item.price}"),
            trailing: ElevatedButton(
              onPressed: inCart
                  ? null
                  : () => context.read<CartModel>().add(context, item),
              child: Text(inCart ? "Added" : "Add"),
            ),
          );
        },
        separatorBuilder: (_, i) => Divider(height: 1.5),
        itemCount: catalog.length,
      ),
    );
  }
}
