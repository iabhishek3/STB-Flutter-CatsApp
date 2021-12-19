part of 'downloaded_cats_cubit.dart';

@immutable
abstract class DownloadedCatsState extends Equatable{}

class DownloadedCatsInitial extends DownloadedCatsState {
  @override
  // TODO: implement props
  List<Object> get props => <Object>[];
}

class DownloadedCatsLoadingState extends DownloadedCatsState {
  @override
  List<Object> get props => <Object>[];
}

class DownloadedCatsLoadedState extends DownloadedCatsState {
  DownloadedCatsLoadedState(this.photos);

  final  List<Photo> photos;

  @override
  List<Object> get props => <Object>[photos];
}


class  DownloadedCatsErrorState extends DownloadedCatsState {
  @override
  List<Object> get props => <Object>[];
}