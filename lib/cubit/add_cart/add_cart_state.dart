part of 'add_cart_cubit.dart';

@immutable
abstract class AddCartState {}

class AddCartInitial extends AddCartState {}

class AddCartLoading extends AddCartState {}

class AddCartSuccess extends AddCartState {
  List<dynamic> cartModels;
  double totalPrice;
  AddCartSuccess(this.cartModels, this.totalPrice);
}

class AddCartFailed extends AddCartState {
  String message;
  AddCartFailed(this.message);
}
