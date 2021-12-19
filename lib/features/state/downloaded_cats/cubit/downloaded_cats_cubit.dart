import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:stb_cat_app/features/models/cat.dart';
import 'package:stb_cat_app/features/repository/cats_repo.dart';



part 'downloaded_cats_state.dart';

class DownloadedCatsCubit extends Cubit<DownloadedCatsState> {
  DownloadedCatsCubit({required this.repository}) : super(DownloadedCatsInitial()){
    getDownloadedPhotos();
  }
  final DBHelper repository;

  Future<void> getDownloadedPhotos()  async {
    try {
      emit(DownloadedCatsLoadingState());
      final  List<Photo> photos =  await repository.getPhotos();
      emit(DownloadedCatsLoadedState(photos));
    } on Exception {
      emit(DownloadedCatsErrorState());
    }
  }

  Future<void> deleteCatPhoto(String id)  async {
    try {
      emit(DeleteCatLoadingState());
      final  bool deleted =  await repository.deletePhoto(id);
      emit(DeleteCatLoadedState(deleted));
    } on Exception {
      emit(DownloadedCatsErrorState());
    }
  }

  Future<void> update(Photo photo)  async {
    try {
      emit(UpdatedCatsLoadingState());
      final  int deleted =  await repository.update(photo);
      emit(UpdatedCatsLoadedState(deleted));
    } on Exception {
      emit(UpdatedCatsErrorState());
    }
  }


}
