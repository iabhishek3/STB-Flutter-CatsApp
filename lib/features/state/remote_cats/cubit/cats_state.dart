part of 'cats_cubit.dart';

@immutable
abstract class CatsState extends Equatable{}

class CatsInitial extends CatsState {
  @override
  List<Object> get props => <Object>[];
}


class CatsLoadingState extends CatsState {
  @override
  List<Object> get props => <Object>[];
}

class CatsLoadedState extends CatsState {
  CatsLoadedState(this.photos);

  final  List<CatApi> photos;

  @override
  List<Object> get props => <Object>[photos];
}


class  CatsErrorState extends CatsState {
  @override
  List<Object> get props => <Object>[];
}
