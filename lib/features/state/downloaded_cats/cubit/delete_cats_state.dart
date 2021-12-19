
import 'downloaded_cats_cubit.dart';



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