import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:viva_store_app/services/firestore_product_service.dart';

import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _products = [];

  final FirestoreProductService _firestoreProductService =
  FirestoreProductService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ProductProvider() {
    fetchProducts();
  }

  List<Product> get products => _products;

  void fetchProducts() async {
    print('fetchProducts de productProvider foi chamado');
    QuerySnapshot querySnapshot = await _firestore.collection('products').get();
    print('querySnapshot.docs.length => ${querySnapshot.docs.length}');
    for (var doc in querySnapshot.docs) {
      print('product.name => ${doc['name']}');
      _products.add(Product(
        id: doc['id'],
        name: doc['name'],
        category: doc['category'],
        description: doc['description'],
        price: doc['price'],
        imageUrl: doc['urlImage'],
        stockQuantity: doc['stockQuantity'],
      ));
    }
    notifyListeners();
  }

  Future<List<Product>> fetchProductsByCategory(String category) async {
    // Obter a lista de produtos filtrando por categoria do Firestore
    QuerySnapshot querySnapshot = await _firestore
        .collection('products')
        .where('category', isEqualTo: category)
        .get();

    for (var doc in querySnapshot.docs) {
      _products.add(Product(
        id: doc['id'],
        name: doc['name'],
        category: doc['category'],
        description: doc['description'],
        price: doc['price'],
        imageUrl: doc['urlImage'],
        stockQuantity: doc['stockQuantity'],
      ));
    }
    notifyListeners();
    return _products;
  }
}