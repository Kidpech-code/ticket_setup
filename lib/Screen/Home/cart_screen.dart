import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/catalog.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Consumer<CatalogViewModel>(
        builder: (context, model, child) {
          final cartItems = model.getCartItems();
          if (cartItems.isEmpty) {
            return const Center(child: Text('Your cart is empty'));
          }

          if (model.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final itemId = cartItems.keys.elementAt(index);
              final itemQuantity = cartItems[itemId];
              final catalogItem = model.catalogList.firstWhere((item) => item.id == itemId); // Handle the case when the item is not found

              return Dismissible(
                key: Key(catalogItem.id.toString()),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  model.removeItemCompletely(catalogItem.id);
                },
                background: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  alignment: AlignmentDirectional.centerEnd,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                child: ListTile(
                  leading: const Icon(Icons.shopping_cart),
                  title: Text(catalogItem.name),
                  subtitle: Text('\$${catalogItem.price} x $itemQuantity'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () => model.removeItem(catalogItem.id),
                      ),
                      Text('$itemQuantity'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => model.addItem(catalogItem.id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        height: 250,
        child: Column(
          children: [
            Consumer<CatalogViewModel>(
              builder: (context, model, child) {
                return Column(
                  children: [
                    Text(
                      model.getCartSummary(),
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    Text('Total: \$${model.calculateTotalPrice().toStringAsFixed(2)}', style: Theme.of(context).textTheme.headlineSmall),
                  ],
                );
              },
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Provider.of<CatalogViewModel>(context, listen: false).clearCartAndPop(context);
                  },
                  child: const Text('Clear Cart'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  onPressed: () {
                    // Implement your checkout logic here
                  },
                  child: const Text('Checkout'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
