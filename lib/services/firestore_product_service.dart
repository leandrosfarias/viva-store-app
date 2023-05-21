import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:viva_store_app/models/product.dart';

class FirestoreProductService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addProduct(
      {required String name,
        required double price,
        required category,
        required urlImage,
        required description,
        required stockQuantity}) async {
    // Obter o usuário atual
    User? user = _auth.currentUser;
    if (user != null) {
      try {
        // Adicionar o produto ao Firestore
        DocumentReference docRef = await _firestore.collection('products').add({
          'name': name,
          'price': price,
          'userId': user.uid, // Associar o produto ao usuário
          'category': category,
          'urlImage': urlImage,
          'description': description,
          'stockQuantity': stockQuantity,
          'id': '', // placeholder para o id do documento
        });
        // Atualizar o documento recém-criado com o seu próprio id
        await docRef.update({'id': docRef.id});
      } catch (e) {
        // Handle error
        print(e);
      }
    } else {
      print('No user is currently signed in.');
    }
  }

  Future<List<Product>> getProducts() async {
    final response = await _firestore.collection('products').get();
    List<Product> products = [];
    //
    for (var doc in response.docs) {
      products.add(Product(
          id: doc['id'],
          name: doc['name'],
          category: doc['category'],
          description: doc['description'],
          price: doc['price'],
          imageUrl: doc['imageUrl']));
    }
    //
    return products;
  }

  Future<bool> updateProduct(Product product) async {
    try {
      await _firestore
          .collection('products')
          .doc(product.id)
          .update(product.toMap());
      return true;
    } catch (e) {
      print('EXCEÇÃO => $e');
      return false;
    }
  }

  Future<bool> deleteProduct(String productId) async {
    try {
      await _firestore.collection('products').doc(productId).delete();
      return true;
    } catch (e) {
      // Handle error
      print('Exceção em deleteProduct => $e');
      return false;
    }
  }
}