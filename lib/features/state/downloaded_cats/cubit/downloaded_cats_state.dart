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


class DeleteCatInitial extends DownloadedCatsState {
  @override
  // TODO: implement props
  List<Object> get props => <Object>[];
}

class DeleteCatLoadingState extends DownloadedCatsState {
  @override
  List<Object> get props => <Object>[];
}

class DeleteCatLoadedState extends DownloadedCatsState {
  DeleteCatLoadedState(this.deleted);

  final  bool deleted;

  @override
  List<Object> get props => <Object>[deleted];
}


class  DeleteCatCatsErrorState extends DownloadedCatsState {
  @override
  List<Object> get props => <Object>[];
}



class UpdateCatsInitial extends DownloadedCatsState {
  @override
  // TODO: implement props
  List<Object> get props => <Object>[];
}

class UpdatedCatsLoadingState extends DownloadedCatsState {
  @override
  List<Object> get props => <Object>[];
}

class UpdatedCatsLoadedState extends DownloadedCatsState {
  UpdatedCatsLoadedState(this.updated);

  final  int updated;

  @override
  List<Object> get props => <Object>[updated];
}


class  UpdatedCatsErrorState extends DownloadedCatsState {
  @override
  List<Object> get props => <Object>[];
}






