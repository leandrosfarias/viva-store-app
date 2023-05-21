import 'package:flutter/material.dart';

import '../models/product.dart';

class ShoppingCart extends StatelessWidget {
  final List<Product> products;

  const ShoppingCart({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    for (var product in products) {
      print('O preço do produto no carrinho é => R\$ ${product.price}');
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrinho'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) => ListTile(
                      title: Text(products[index].name),
                      subtitle: Text('R\$ ${products[index].price.toString()}'),
                    )),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Total R\$ ${calculateTotal()}',
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                // onPrimary: Theme.of(context).backgroundColor,
              ),
              onPressed: () {
                print('Finalizando compra...');
              },
              child: const Text('Finalizar compra'),
            ),
          ),
        ],
      ),
    );
  }

  double calculateTotal() {
    var total = 0.0;
    for (var product in products) {
      total += product.price;
    }
    return total;
  }
}
