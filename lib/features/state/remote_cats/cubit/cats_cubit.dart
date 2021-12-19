import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:stb_cat_app/features/models/cat_api.dart';
import 'package:stb_cat_app/features/repository/cats_repo.dart';

part 'cats_state.dart';

class CatsCubit extends Cubit<CatsState> {

  CatsCubit({required this.repository}) : super(CatsInitial()){
    getDownloadedPhotos(false);
  }
  final DBHelper repository;

  Future<void> getDownloadedPhotos([bool remote = false] )  async {
    try {
      emit(CatsLoadingState());
      final  List<CatApi> photos =  await repository.getCatRemote(remote);
      emit(CatsLoadedState(photos));
    } on Exception {
      emit(CatsErrorState());
    }
  }




}
