import 'package:flutter/material.dart';

import '../models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final Function(Product) onProductAddToShoppingCart;

  const ProductCard(
      {super.key,
      required this.product,
      required this.onProductAddToShoppingCart});

  @override
  Widget build(BuildContext context) {
    // print('ID DO PRODUTO NO CARD => ${product.id}');
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 18.0 / 15.0,
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontSize: 18.0),
                  maxLines: 1,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'R\$ ${product.price.toStringAsFixed(2).toString()}',
                  style: const TextStyle(
                      fontSize: 22.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    const Spacer(),
                    IconButton(
                        onPressed: () => onProductAddToShoppingCart(product),
                        icon: const Icon(
                          Icons.add_shopping_cart,
                          color: Colors.red,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
