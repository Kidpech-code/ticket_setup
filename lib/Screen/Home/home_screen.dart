import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../ViewModel/catalog.dart';
import 'cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late CatalogViewModel viewModel;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel = Provider.of<CatalogViewModel>(context, listen: false);
      viewModel.navigateToCartScreenCallback = () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CartScreen(), fullscreenDialog: true));
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CatalogViewModel>(
      builder: (context, catalogVM, child) {
        if (catalogVM.isLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Ticket Setup'),
          ),
          body: GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: catalogVM.catalogList.length,
            itemBuilder: (context, index) {
              var item = catalogVM.catalogList[index];
              return Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Image here"),
                    Container(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(item.title),
                          Text('\$${item.price}'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              catalogVM.iconDeletionAndAddition(context, item.id, false),
                              const Spacer(),
                              Text(
                                '${catalogVM.getQuantity(item.id)}',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              const Spacer(),
                              catalogVM.iconDeletionAndAddition(context, item.id, true),
                            ],
                          ),
                        ],
                      ),
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
                    catalogVM.clearCart();
                  },
                  child: const Text('Clear Cart'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                  onPressed: () => viewModel.navigateToCartScreen(),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('Cart'),
                      const SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              const Icon(
                                Icons.shopping_cart,
                              ),
                              if (catalogVM.getTotalItems() > 0)
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
                                      '${catalogVM.getTotalItems()}',
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
