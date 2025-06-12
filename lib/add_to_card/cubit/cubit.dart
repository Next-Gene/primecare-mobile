import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexgen/add_to_card/cubit/states.dart';
import '../model.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial()) {
    items = [];
    _updateCart();
  }

  List<CartItem> items = [];

  int get totalPrice => items.fold(0, (total, item) => total + (item.price * item.count));

  void increaseCount(CartItem item) {
    final index = items.indexOf(item);
    if (index != -1) {
      items[index].count++;
      _updateCart();
    }
  }

  void decreaseCount(CartItem item) {
    final index = items.indexOf(item);
    if (index != -1 && items[index].count > 1) {
      items[index].count--;
      _updateCart();
    }
  }

  void removeItem(CartItem item) {
    items.remove(item);
    _updateCart();
  }

  void addItem(CartItem item) {
    items.add(item);
    _updateCart();
  }

  void _updateCart() {
    emit(CartUpdated([...items]));
  }



  static CartCubit get(context) => BlocProvider.of(context);
}
