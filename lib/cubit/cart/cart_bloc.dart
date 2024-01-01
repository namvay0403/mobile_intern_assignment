import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:mobile_intern_assignment/models/cart_model.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  List<dynamic> carts = [];
  bool checkCart(int id) {
    for (var i = 0; i < carts.length; i++) {
      if (carts[i].id == id) {
        print(carts[i].id);
        return true;
      }
    }
    return false;
  }

  CartBloc() : super(CartInitial()) {
    on<CartEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<CartAddEvent>((event, emit) {
      if (checkCart(event.cartModel.id) == false) {
        carts.add(event.cartModel);
        double totalPrice = 0;
        for (var i = 0; i < carts.length; i++) {
          totalPrice += carts[i].price * carts[i].count;
        }
        emit(CartSuccess(carts, totalPrice));
      } else {
        double totalPrice = 0;
        for (var i = 0; i < carts.length; i++) {
          totalPrice += carts[i].price * carts[i].count;
        }
        emit(CartSuccess(carts, totalPrice));
      }
    });
    on<CartPlusEvent>((event, emit) {
      for (var i = 0; i < carts.length; i++) {
        if (carts[i].id == event.id) {
          carts[i].count++;
          break;
        }
      }
      double totalPrice = 0;
      for (var i = 0; i < carts.length; i++) {
        totalPrice += carts[i].price * carts[i].count;
      }
      emit(CartSuccess(carts, totalPrice));
    });
    on<CartMinusEvent>((event, emit) {
      for (var i = 0; i < carts.length; i++) {
        if (carts[i].id == event.id) {
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
      emit(CartSuccess(carts, totalPrice));
    });
    on<CartDeleteEvent>((event, emit) {
      for (var i = 0; i < carts.length; i++) {
        if (carts[i].id == event.id) {
          carts.removeAt(i);
          break;
        }
      }
      double totalPrice = 0;
      for (var i = 0; i < carts.length; i++) {
        totalPrice += carts[i].price * carts[i].count;
      }
      emit(CartSuccess(carts, totalPrice));
    });
  }
}
