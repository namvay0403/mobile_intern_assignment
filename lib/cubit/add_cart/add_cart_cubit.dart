import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_intern_assignment/models/cart_model.dart';

part 'add_cart_state.dart';

class AddCartCubit extends Cubit<AddCartState> {
  AddCartCubit() : super(AddCartInitial());

  List<dynamic> carts = [];

  void addCart(CartModel cartModel) {
    if (checkCart(cartModel.id) == false) {
      carts.add(cartModel);
      double totalPrice = 0;
      for (var i = 0; i < carts.length; i++) {
        totalPrice += carts[i].price * carts[i].count;
      }
      emit(AddCartSuccess(carts, totalPrice));
    } else {
      double totalPrice = 0;
      for (var i = 0; i < carts.length; i++) {
        totalPrice += carts[i].price * carts[i].count;
      }
      emit(AddCartSuccess(carts, totalPrice));
    }
  }

  void plusItem(int id) {
    for (var i = 0; i < carts.length; i++) {
      if (carts[i].id == id) {
        carts[i].count++;
        break;
      }
    }
    double totalPrice = 0;
    for (var i = 0; i < carts.length; i++) {
      totalPrice += carts[i].price * carts[i].count;
    }
    emit(AddCartSuccess(carts, totalPrice));
  }

  void minus(int id) {
    for (var i = 0; i < carts.length; i++) {
      if (carts[i].id == id) {
        if (carts[i].count > 1) {
          carts[i].count--;
        }
        break;
      }
    }
    double totalPrice = 0;
    for (var i = 0; i < carts.length; i++) {
      totalPrice += carts[i].price * carts[i].count;
    }
    emit(AddCartSuccess(carts, totalPrice));
  }

  bool checkCart(int id) {
    for (var i = 0; i < carts.length; i++) {
      if (carts[i].id == id) {
        print(carts[i].id);
        return true;
      }
    }
    return false;
  }

  void removeCart(int id) {
    for (var i = 0; i < carts.length; i++) {
      if (carts[i].id == id) {
        carts.removeAt(i);
        break;
      }
    }
    double totalPrice = 0;
    for (var i = 0; i < carts.length; i++) {
      totalPrice += carts[i].price * carts[i].count;
    }
    emit(AddCartSuccess(carts, totalPrice));
  }
}
