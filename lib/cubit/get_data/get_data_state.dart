part of 'get_data_cubit.dart';

@immutable
abstract class GetDataState {}

class GetDataInitial extends GetDataState {}

class GetDataLoading extends GetDataState {}

class GetDataLoaded extends GetDataState {
  List<dynamic> shoes;
  GetDataLoaded(this.shoes);
}

class GetDataFailed extends GetDataState {
  String message;
  GetDataFailed(this.message);
}
