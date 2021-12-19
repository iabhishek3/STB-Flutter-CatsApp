import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stb_cat_app/features/models/detail_image.dart';
import 'package:stb_cat_app/features/presentation/widgets/cat_card.dart';
import 'package:stb_cat_app/features/presentation/widgets/success_widget.dart';
import 'package:stb_cat_app/features/repository/cats_repo.dart';
import 'package:stb_cat_app/features/state/remote_cats/cubit/cats_cubit.dart';
import 'package:stb_cat_app/features/state/remote_cats/cubit/save_image_cubit.dart';
import 'package:stb_cat_app/features/utils/screen_util.dart';

import 'details_view.dart';

class NewCat extends StatelessWidget {
  const NewCat({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => MultiBlocProvider(providers: [
        BlocProvider<CatsCubit>(
          create: (BuildContext context) => CatsCubit(repository: DBHelper()),
        ),
        BlocProvider<SaveImageCubit>(
          create: (BuildContext context) =>
              SaveImageCubit(repository: DBHelper()),
        ),
      ], child: const CatCard());
}



