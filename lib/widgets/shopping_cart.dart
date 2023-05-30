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
      : super(key: key) {
    total = 0.0;
  }

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
    // inicializar total
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
                        // print('direction => $direction');
                        print('Id do produto que deve ser removido '
                            '=> ${widget.products[index].id}');
                        setState(() {
                          // atualizar total após remover produto do carrinho
                          subtractValue(widget.products[index].id);
                          widget.onDeleteProductFromShoppingCart(
                              widget.products[index].id);
                        });
                      },
                      background: Container(
                        color: Colors.red,
                      ),
                      child: Card(
                        child: Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    '${widget.products[index].name} ${quantityPerOrderItem[index]}x',
                                    style: const TextStyle(
                                      fontSize:
                                          20, // Defina um valor maior para aumentar o tamanho do texto
                                    ),
                                  ),
                                  // adicionar unidade
                                  IconButton(
                                      onPressed: () {
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
                                          widget.total = widget.total +
                                              widget.products[index].price;
                                        });
                                        //
                                      },
                                      icon: const Icon(Icons.add,
                                          color: Colors.green)),
                                  // remover unidade
                                  IconButton(
                                      onPressed: () {
                                        print(
                                            'Quantidade atual do produto é => ${quantityPerOrderItem[index]}');
                                        // decrementa quantidade do item
                                        quantityPerOrderItem[index] =
                                            quantityPerOrderItem[index] - 1;
                                        print(
                                            'Estou tentando atualizar unidade de produto para ${quantityPerOrderItem[index]}');
                                        setState(() {
                                          // atualiza a quantidade do item
                                          widget.order.updateProductQuantity(
                                              widget.products[index].id,
                                              quantityPerOrderItem[index]--);
                                          // atualiza o total
                                          widget.total = widget.total -
                                              widget.products[index].price;
                                        });
                                        //
                                      },
                                      icon: const Icon(Icons.remove,
                                          color: Colors.red))
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                      'R\$ ${widget.products[index].price.toString()}')
                                ],
                              )
                              // const SizedBox(height: 8.0),
                            ],
                          ),
                        ),
                      ));
                }),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
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

  void subtractValue(String productId) {
    print('subtractValue foi chamado');
    Product product =
        widget.products.firstWhere((element) => element.id == productId);
    // valor a subtrair
    double valueToSubtract = product.price;
    widget.total = widget.total - valueToSubtract;
    print('valor a subtrair => ${widget.total - valueToSubtract}');
    print('widget.total => ${widget.total}');
  }

  void confirmOrder() {}
}
