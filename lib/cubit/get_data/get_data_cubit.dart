import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

import '../../models/shoe_model.dart';

part 'get_data_state.dart';

class GetDataCubit extends Cubit<GetDataState> {
  GetDataCubit() : super(GetDataInitial());

  Future<void> getData() async {
    emit(GetDataLoading());
    try {
      final String response = await rootBundle.loadString('assets/shoes.json');
      final data = jsonDecode(response);
      List<dynamic> shoes = [];
      shoes = data['shoes'].map((e) => Shoe.fromJson(e)).toList();
      emit(GetDataLoaded(shoes)); // convert json to list of shoes
    } catch (e) {
      emit(GetDataFailed(e.toString()));
    }
  }
}
