import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../Model/catalog_model.dart';
import '../Screen/Home/cart_screen.dart';
import '../Unity/button_style.dart';

class CatalogViewModel with ChangeNotifier {
  final Box cartBox = Hive.box('cartBox');
  CatalogModel? catalogModel;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  List<CatalogModel> catalogList = [
    CatalogModel(
      id: 0,
      name: "catalog_model",
      title: "CatalogModel",
      description: "CatalogModel description",
      type: ["local", "foreign"],
      minSi: 1,
      maxSi: 10,
      image: ["https://www.example.com/image1.png", "https://www.example.com/image2.png"],
      price: 100,
      eventStartDate: DateTime.parse("2022-12-31T00:00:00.000Z"),
      eventEndDate: DateTime.parse("2026-12-31T00:00:00.000Z"),
      isAvailable: true,
    ),
    CatalogModel(
      id: 1,
      name: "catalog_model2",
      title: "CatalogModel2",
      description: "CatalogModel description 2",
      type: ["local", "foreign"],
      minSi: 1,
      maxSi: 100,
      image: ["https://www.example.com/image1.png", "https://www.example.com/image2.png"],
      price: 200,
      eventStartDate: DateTime.parse("2023-04-11T00:00:00.000Z"),
      eventEndDate: DateTime.parse("2026-12-31T00:00:00.000Z"),
      isAvailable: true,
    ),
    CatalogModel(
      id: 2,
      name: "catalog_model3",
      title: "CatalogModel3",
      description: "CatalogModel description 3",
      type: ["local", "foreign"],
      minSi: 1,
      maxSi: 100,
      image: ["https://www.example.com/image1.png", "https://www.example.com/image2.png"],
      price: 300,
      eventStartDate: DateTime.parse("2023-04-11T00:00:00.000Z"),
      eventEndDate: DateTime.parse("2026-12-31T00:00:00.000Z"),
      isAvailable: true,
    ),
    CatalogModel(
      id: 3,
      name: "catalog_model4",
      title: "CatalogModel4",
      description: "CatalogModel description 4",
      type: ["local", "foreign"],
      minSi: 1,
      maxSi: 100,
      image: ["https://www.example.com/image1.png", "https://www.example.com/image2.png"],
      price: 400,
      eventStartDate: DateTime.parse("2023-04-11T00:00:00.000Z"),
      eventEndDate: DateTime.parse("2026-12-31T00:00:00.000Z"),
      isAvailable: true,
    ),
  ];

  void navigateToCartScreen(BuildContext context) async {
    isLoading = true;
    try {
      if (cartBox.isNotEmpty) {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CartScreen(), fullscreenDialog: true));
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
    }
  }

  void addItem(int id) async {
    isLoading = true;
    try {
      cartBox.put(id, (cartBox.get(id) as int? ?? 0) + 1);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
    }
  }

  void removeItem(int id) {
    isLoading = true;
    try {
      final currentQuantity = cartBox.get(id) as num? ?? 0;
      if (currentQuantity > 0) {
        cartBox.put(id, currentQuantity - 1);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
    }
  }

  int getQuantity(int id) {
    if (cartBox.containsKey(id)) {
      return cartBox.get(id) as int? ?? 0;
    } else {
      return 0;
    }
  }

  int getTotalItems() {
    int total = 0;
    for (var key in cartBox.keys) {
      var quantity = cartBox.get(key) as int? ?? 0;
      total += quantity;
    }
    return total;
  }

  Map<int, int> getCartItems() {
    Map<int, int> items = {};
    for (var key in cartBox.keys) {
      final quantity = cartBox.get(key) as int?;
      if (quantity != null && quantity > 0) {
        items[key as int] = quantity;
      }
    }
    return items;
  }

  void removeItemFromCart(int id) {
    isLoading = true;
    try {
      final currentQuantity = cartBox.get(id) as int? ?? 0;
      if (currentQuantity > 1) {
        cartBox.put(id, currentQuantity - 1);
      } else if (currentQuantity == 1) {
        cartBox.delete(id);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
    }
  }

  void removeItemCompletely(int id) {
    isLoading = true;
    try {
      cartBox.delete(id);
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
    }
  }

  void clearCart() {
    isLoading = true;
    try {
      getCartItems().forEach((key, value) {
        cartBox.delete(key);
      });
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
    }
  }

  void clearCartAndPop(BuildContext context) {
    isLoading = true;
    try {
      getCartItems().forEach((key, value) {
        cartBox.delete(key);
        return;
      });
      Navigator.of(context).pop();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading = false;
    }
  }

  num calculateTotalPrice() {
    num totalPrice = 0.0;
    Map<int, int> itemQuantities = getCartItems();
    for (MapEntry<int, int> entry in itemQuantities.entries) {
      CatalogModel item = catalogList.firstWhere((item) => item.id == entry.key, orElse: () => null!);
      totalPrice += item.price * entry.value;
    }
    return totalPrice;
  }

  String getCartSummary() {
    Map<int, int> itemQuantities = getCartItems();
    List<String> summaries = itemQuantities.entries.map((entry) {
      var item = catalogList.firstWhere((item) => item.id == entry.key, orElse: () => null!);
      return "${item.title}: ${entry.value} item ${item.price * entry.value} \$";
    }).toList();
    return summaries.join('\n');
  }

  Widget iconDeletionAndAddition(BuildContext context, int id, bool isAddition) {
    return IconDeletionAndAddition(
      style: isAddition
          ? ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.primary),
              foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onPrimary),
            )
          : getQuantity(id) == 0
              ? null
              : ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
                  foregroundColor: MaterialStateProperty.all(Theme.of(context).colorScheme.onSecondary),
                ),
      isAddition: isAddition,
      ontap: isAddition
          ? () => addItem(id)
          : getQuantity(id) == 0
              ? null
              : () => removeItem(id),
    );
  }
}
