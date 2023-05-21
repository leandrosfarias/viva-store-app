import 'order_item.dart';
import 'order_status.dart';

class Order {
  List<OrderItem> itemsOrders = [];
  DateTime dateOrder = DateTime.now();
  OrderStatus orderStatus = OrderStatus.pending;

  Order();

  void addOrderItem(OrderItem orderItem) {
    itemsOrders.add(orderItem);
    print('item de pedido adicionado');
  }

  void updateProductQuantity(String productId, int quantity) {
    print('Quantidade que desejo atualizar => $quantity');
    print('Produto que terá sua quantidade atualizada => $productId');
    var item =
        itemsOrders.firstWhere((orderItem) => orderItem.productId == productId);
    item.qtdProduct = quantity;
    print(
        'quantidade item de pedido atualizado para => ${itemsOrders.firstWhere((orderItem) => orderItem.productId == productId).qtdProduct}');
  }

  List<int> getQtdPerOrderItem() {
    List<int> qtdPerOrderItem = [];
    for (var orderItem in itemsOrders) {
      qtdPerOrderItem.add(orderItem.qtdProduct);
    }
    return qtdPerOrderItem;
  }
}
