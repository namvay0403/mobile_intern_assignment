part of 'cart_bloc.dart';

@immutable
abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  List<dynamic> cartModels;
  double totalPrice;
  CartSuccess(this.cartModels, this.totalPrice);
}

class CartFailed extends CartState {
  final String message;

  CartFailed(this.message);
}
