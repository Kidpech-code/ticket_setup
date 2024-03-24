import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/catalog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CatalogViewModel>(
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Catalog'),
          ),
          body: GridView.builder(
            padding: const EdgeInsets.all(4),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: model.catalogList.length,
            itemBuilder: (context, index) {
              var item = model.catalogList[index];
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(item.title),
                    Text('\$${item.price}'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () => Provider.of<CatalogViewModel>(context, listen: false).removeItem(item.id),
                        ),
                        Consumer<CatalogViewModel>(
                          builder: (context, model, child) {
                            return Text('${model.getQuantity(item.id)}');
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () => Provider.of<CatalogViewModel>(context, listen: false).addItem(item.id),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          bottomNavigationBar: BottomAppBar(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Provider.of<CatalogViewModel>(context, listen: false).clearCart();
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
                    Provider.of<CatalogViewModel>(context, listen: false).nToCartScreen(context);
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Checkout'),
                      const SizedBox(width: 8),
                      Consumer<CatalogViewModel>(
                        builder: (context, model, child) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  const Icon(
                                    Icons.shopping_cart,
                                  ),
                                  if (model.getTotalItems() > 0)
                                    Positioned(
                                      right: 1,
                                      top: 1,
                                      child: Container(
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(6),
                                        ),
                                        constraints: const BoxConstraints(
                                          minWidth: 14,
                                          minHeight: 14,
                                        ),
                                        child: Text(
                                          '${model.getTotalItems()}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 8,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
