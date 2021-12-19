import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:stb_cat_app/features/repository/cats_repo.dart';

part 'save_image_state.dart';

class SaveImageCubit extends Cubit<SaveImageState> {
  SaveImageCubit({required this.repository}) : super(SaveImageInitial());

  final DBHelper repository;

   saveImage(String url,String name )  async {
    try {
      emit(SavingImageState());
      bool  saved =  await repository.addToDb(url ,name);
      emit(SavedImageState(saved));
    } on Exception {
      emit(SavingErrorState());
    }
  }
}
