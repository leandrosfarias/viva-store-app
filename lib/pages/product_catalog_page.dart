import 'package:flutter/material.dart';
import 'package:viva_store_app/widgets/product_grid_widget.dart';
import 'package:viva_store_app/widgets/shopping_cart.dart';

import '../models/product.dart';

class ProductCatalogPage extends StatefulWidget {
  int totalShoppingCart = 0;
  final List<Product> shoppingCart = [];

  ProductCatalogPage({Key? key}) : super(key: key);

  @override
  State<ProductCatalogPage> createState() => _ProductCatalogPageState();
}

class _ProductCatalogPageState extends State<ProductCatalogPage> {
  void addProductToShoppingCart(Product product) {
    setState(() {
      print('Produto ${product.name} adicionado ao carrinho');
      widget.shoppingCart.add(product);
      widget.totalShoppingCart++;
    });
  }

  void deleteProductFromShoppingCart(String productId) {
    print('deleteProductFromShoppingCart foi chamado');
    setState(() {
      widget.shoppingCart.removeWhere((product) => product.id == productId);
      widget.totalShoppingCart--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 6,
      child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(100.0),
            child: AppBar(
              backgroundColor: Theme.of(context).primaryColor,
              title: const SizedBox(
                width: 250,
                height: 45,
                child: TextField(
                  decoration: InputDecoration(
                    // hintText: 'Search...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(Icons.search, color: Colors.black),
                  ),
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, right: 5.0),
                  child: Stack(children: <Widget>[
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ShoppingCart(
                                  products: widget.shoppingCart,
                                  onDeleteProductFromShoppingCart:
                                      deleteProductFromShoppingCart,
                                )));
                      },
                      icon: const Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                    Positioned(
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 20,
                            maxWidth: 20,
                            // minHeight: 15,
                          ),
                          child: Text(
                            widget.totalShoppingCart.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ))
                  ]),
                ),
              ],
              bottom: const TabBar(
                tabs: [
                  Tab(
                    text: 'Vestuario',
                  ),
                  Tab(
                    text: 'Decoração',
                  ),
                  Tab(
                    text: 'Beleza',
                  ),
                  Tab(
                    text: 'Camas',
                  ),
                  Tab(
                    text: 'Mesas',
                  ),
                  Tab(
                    text: 'Banho',
                  ),
                ],
                isScrollable: true,
              ),
            ),
          ),
          body: TabBarView(
            children: [
              ProductGridWidget(
                  category: 'vestuario',
                  onShoppingCartUpdate: addProductToShoppingCart),
              ProductGridWidget(
                  category: 'decoracao',
                  onShoppingCartUpdate: addProductToShoppingCart),
              ProductGridWidget(
                  category: 'beleza',
                  onShoppingCartUpdate: addProductToShoppingCart),
              ProductGridWidget(
                  category: 'cama',
                  onShoppingCartUpdate: addProductToShoppingCart),
              ProductGridWidget(
                  category: 'mesa',
                  onShoppingCartUpdate: addProductToShoppingCart),
              ProductGridWidget(
                  category: 'banho',
                  onShoppingCartUpdate: addProductToShoppingCart),
            ],
          ) // This trailing comma makes auto-formatting nicer for build methods.
          ),
    );
  }
}
