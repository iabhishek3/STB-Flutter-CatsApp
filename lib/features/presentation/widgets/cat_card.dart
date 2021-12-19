import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stb_cat_app/features/models/detail_image.dart';
import 'package:stb_cat_app/features/presentation/screens/details_view.dart';
import 'package:stb_cat_app/features/presentation/widgets/success_widget.dart';
import 'package:stb_cat_app/features/repository/cats_repo.dart';
import 'package:stb_cat_app/features/state/remote_cats/cubit/cats_cubit.dart';
import 'package:stb_cat_app/features/state/remote_cats/cubit/save_image_cubit.dart';
import 'package:stb_cat_app/features/utils/screen_util.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class CatCard extends StatefulWidget {
  const CatCard({Key? key}) : super(key: key);

  @override
  _CatCardState createState() => _CatCardState();
}

class _CatCardState extends State<CatCard> {
  late final CatsCubit _scanInspectionCubit;
  late final SaveImageCubit _saveImageCubit;

  @override
  void initState() {
    _scanInspectionCubit = BlocProvider.of<CatsCubit>(context);
    _saveImageCubit = BlocProvider.of<SaveImageCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final stateA = context.watch<SaveImageCubit>().state;
    if (stateA is SavedImageState) {
      WidgetsBinding.instance
          ?.addPostFrameCallback((_) => _showMyDialog(context));
    }
    if (stateA is SavingImageState) {
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(title: const Text("Cat World"),),
      body: BlocBuilder<CatsCubit, CatsState>(
        builder: (BuildContext context, CatsState state) {

          if (state is CatsLoadedState) {
            return OrientationBuilder(builder: (context, orientation) {

              return Center(
                child: SizedBox(
                   height: Device.get().isTablet ? getHeight(orientation, context) :400,
                  width: Device.get().isTablet ? getWidth(orientation, context) :350,
                  // height: getHeight(orientation, context),
                  // width: getWidth(orientation, context),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ImageDetail(
                                detailPage: DetailPage(state.photos[0].url,
                                    "url", "remote_image"))),
                      );
                    },
                    child: Card(
                        child: Column(
                          children: [
                            SizedBox(
                                height: 300,
                                width: double.infinity,
                                child: Image.network(
                                  state.photos[0].url,
                                  fit: BoxFit.fill,
                                )),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      _scanInspectionCubit
                                          .getDownloadedPhotos(true);
                                    },
                                    child: Column(
                                      children: const <Widget>[
                                        Icon(
                                          Icons.refresh_rounded,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'Fetch New Cat',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      _saveImageCubit.saveImage(
                                          state.photos[0].url, "");
                                    },
                                    child: Column(
                                      children: const <Widget>[
                                        Icon(
                                          Icons.download_for_offline_rounded,
                                          color: Colors.white,
                                        ),
                                        Text(
                                          'Download Image',
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )),
                  ),
                ),
              );
            });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

Future<void> _showMyDialog(context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context1) {
      return const AlertDart();
    },
  );
}
