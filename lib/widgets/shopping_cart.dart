import 'package:flutter/material.dart';

import '../models/product.dart';

class ShoppingCart extends StatefulWidget {
  final List<Product> products;
  final Function(String productId) onDeleteProductFromShoppingCart;

  const ShoppingCart(
      {Key? key,
      required this.products,
      required this.onDeleteProductFromShoppingCart})
      : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  Widget build(BuildContext context) {
    for (var product in widget.products) {
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
                itemCount: widget.products.length,
                itemBuilder: (context, index) => Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        print('direction => $direction');
                        print('Id do produto que deve ser removido '
                            '=> ${widget.products[index].id}');
                        setState(() {
                          // widget.products.removeWhere(
                          //     (p) => p.id == widget.products[index].id);
                          widget.onDeleteProductFromShoppingCart(
                              widget.products[index].id);
                          // print(
                          //     'Reconstruindo a tela após remover produto '
                          //         'cujo id é => ${widget.products[index].id}...');
                        });
                      },
                      background: Container(
                        color: Colors.red,
                      ),
                      child: ListTile(
                        title: Text(widget.products[index].name),
                        subtitle: Text(
                            'R\$ ${widget.products[index].price.toString()}'),
                      ),
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
    for (var product in widget.products) {
      total += product.price;
    }
    return total;
  }
}
