import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../Model/catalog_model.dart';
import '../Screen/Home/cart_screen.dart';

class CatalogViewModel with ChangeNotifier {
  final Box cartBox = Hive.box('cartBox');

  CatalogModel? catalogModel;

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

  // วิธีการเรียกใช้งาน catalogList จากหน้าอื่น
  // final catalogList = Provider.of<CatalogViewModel>(context).catalogList;

  void nToCartScreen(BuildContext context) {
    if (cartBox.isNotEmpty) Navigator.of(context).push(MaterialPageRoute(builder: (context) => const CartScreen()));
  }

  void addItem(int id) {
    cartBox.put(id, (cartBox.get(id) ?? 0) + 1);
    notifyListeners();
  }

  void removeItem(int id) {
    final currentQuantity = cartBox.get(id) ?? 0;
    if (currentQuantity > 0) {
      cartBox.put(id, currentQuantity - 1);
    }
    notifyListeners();
  }

  int getQuantity(int id) {
    return cartBox.get(id) ?? 0;
  }

  int getTotalItems() {
    int total = 0;
    for (int key in cartBox.keys) {
      var quantity = cartBox.get(key) ?? 0;
      total += quantity is int ? quantity : 0;
    }
    return total;
  }

  Map<int, int> getCartItems() {
    Map<int, int> items = {};
    for (var key in cartBox.keys) {
      final quantity = cartBox.get(key);
      if (quantity > 0) {
        items[key] = quantity;
      }
    }
    return items;
  }

  void addItemCart(int id) {
    cartBox.put(id, (cartBox.get(id) ?? 0) + 1);
    notifyListeners();
  }

  void removeItemCart(int id) {
    final currentQuantity = cartBox.get(id) ?? 0;
    try {
      if (currentQuantity > 1) {
        cartBox.put(id, currentQuantity - 1);
      } else {
        cartBox.delete(id);
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    notifyListeners();
  }

  void removeItemCompletely(int id) {
    try {
      cartBox.delete(id);
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  void clearCart() {
    try {
      cartBox.clear();
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  void clearCartAndPop(BuildContext context) {
    try {
      cartBox.clear().then((value) {
        if (cartBox.isEmpty) {
          Navigator.of(context).pop();
        } else {
          clearCartAndPop(context);
        }
      });
    } catch (e) {
      debugPrint(e.toString());
    }
    notifyListeners();
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;
    Map<int, int> itemQuantities = getCartItems(); // Assuming this method returns a map of item IDs to quantities
    for (var entry in itemQuantities.entries) {
      var itemId = entry.key;
      var quantity = entry.value;
      var item = catalogList.firstWhere((item) => item.id == itemId, orElse: () => null!);
      if (item != null) {
        totalPrice += item.price * quantity;
      }
    }
    return totalPrice;
  }

  String getCartSummary() {
    Map<int, int> itemQuantities = getCartItems();
    List<String> summaries = [];

    for (var entry in itemQuantities.entries) {
      var itemId = entry.key;
      var quantity = entry.value;
      var item = catalogList.firstWhere((item) => item.id == itemId, orElse: () => null!);
      if (item != null) {
        summaries.add("${item.title}: $quantity  \$${item.price * quantity}");
      }
    }

    return summaries.join('\n');
  }
}
