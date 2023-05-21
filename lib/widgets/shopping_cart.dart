import 'package:flutter/material.dart';
import 'package:viva_store_app/models/order_item.dart';
import 'package:viva_store_app/models/order.dart';

import '../models/product.dart';

class ShoppingCart extends StatefulWidget {
  final List<Product> products;
  final Function(String productId) onDeleteProductFromShoppingCart;
  final Order order = Order();
  late double total;

  // final Order order = Order(itemsOrders, dateOrder);
  // final ItemOrder itemOrder = ItemOrder(product, 1);
  ShoppingCart(
      {Key? key,
      required this.products,
      required this.onDeleteProductFromShoppingCart})
      : super(key: key);

  @override
  State<ShoppingCart> createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  @override
  void initState() {
    super.initState();
    for (var product in widget.products) {
      widget.order.addOrderItem(OrderItem(product.id, 1));
    }
    //
    widget.total = calculateTotal();
  }

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
                itemBuilder: (context, index) {
                  var quantityPerOrderItem = widget.order.getQtdPerOrderItem();
                  return Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      print('direction => $direction');
                      print('Id do produto que deve ser removido '
                          '=> ${widget.products[index].id}');
                      setState(() {
                        widget.onDeleteProductFromShoppingCart(
                            widget.products[index].id);
                      });
                    },
                    background: Container(
                      color: Colors.red,
                    ),
                    child: ListTile(
                      title: Text(
                          '${widget.products[index].name} ${quantityPerOrderItem[index]}x'),
                      subtitle: Text(
                          'R\$ ${widget.products[index].price.toString()}'),
                      trailing: IconButton(
                          onPressed: () {
                            //
                            print(
                                'Quantidade atual do produto é => ${quantityPerOrderItem[index]}');
                            // incrementa quantidade do item
                            quantityPerOrderItem[index] =
                                quantityPerOrderItem[index] + 1;
                            print(
                                'Estou tentando atualizar unidade de produto para ${quantityPerOrderItem[index]}');
                            setState(() {
                              // atualiza a quantidade do item
                              widget.order.updateProductQuantity(
                                  widget.products[index].id,
                                  quantityPerOrderItem[index]++);
                              // atualiza o total
                              widget.total =
                                  widget.total + widget.products[index].price;
                            });
                            //
                          },
                          icon: const Icon(
                            Icons.add,
                            color: Colors.green,
                          )),
                    ),
                  );
                }),
          ),
          Container(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Total R\$ ${widget.total}',
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

  void confirmOrder() {}
}
