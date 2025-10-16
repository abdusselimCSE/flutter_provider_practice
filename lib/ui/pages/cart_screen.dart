import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_provider/main.dart' show CartModel;

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = context.select((CartModel cart) => cart.items);

    return Scaffold(
      appBar: AppBar(title: Text("My Cart")),
      body: items.isEmpty
          ? Center(child: Text("No items in Cart"))
          : ListView.builder(
              itemBuilder: (_, i) {
                final item = items[i];
                return ListTile(
                  title: Text("${item.name} ->>> \$${item.price}"),
                  trailing: ElevatedButton(
                    onPressed: () => context.read<CartModel>().remove(item),
                    child: Text("Remove"),
                  ),
                );
              },
              itemCount: items.length,
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Consumer<CartModel>(
                  builder: (_, cart, i) => Text("Total : \$${cart.totalPrice}"),
                ),
              ),
              FilledButton.tonal(
                onPressed: () => context
                    .read<CartModel>()
                    .clearAll(), // Provider.of(..., listen:false)
                child: const Text('Clear cart'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
