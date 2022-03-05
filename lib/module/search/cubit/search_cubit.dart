import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/model/search_model/search_model.dart';
import 'package:shopapp/module/search/cubit/search_states.dart';
import 'package:shopapp/shared/components/constants.dart';
import 'package:shopapp/shared/end_points/end_points.dart';
import 'package:shopapp/shared/network/remote/dio_helper.dart';

class SearchScreenCubit extends Cubit<SearchScreenStates>{
  SearchScreenCubit() : super(SearchScreenInitialState());

  static SearchScreenCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void postSearchData (String text){
    emit(SearchScreenLoadingState());

    DioHelper.postData(
        url: Search,
        token: tokenGeneral,
        data: {
          'text' : text,
        }).then((value) {
      searchModel = SearchModel.fromJson(value.data);
      print(searchModel!.status);
      emit(SearchScreenSuccessState());
    }).catchError((onError){
      print('search error ${onError.toString()}');
      emit(SearchScreenErrorState(onError.toString()));
    });
  }


}