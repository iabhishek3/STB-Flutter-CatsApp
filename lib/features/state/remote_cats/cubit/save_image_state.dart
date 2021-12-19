part of 'save_image_cubit.dart';

@immutable
abstract class SaveImageState extends Equatable{}

class SaveImageInitial extends SaveImageState {
  @override
  // TODO: implement props
  List<Object> get props => <Object>[];
}



class SavingImageState extends SaveImageState {
  @override
  List<Object> get props => <Object>[];
}

class SavedImageState extends SaveImageState {
  SavedImageState( this.saved);
  final  bool saved;
  @override
  List<Object> get props => <Object>[saved];
}

class  SavingErrorState extends SaveImageState {
  @override
  List<Object> get props => <Object>[];
}