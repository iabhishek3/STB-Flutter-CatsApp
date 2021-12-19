import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stb_cat_app/features/models/cat.dart';
import 'package:stb_cat_app/features/models/detail_image.dart';
import 'package:stb_cat_app/features/repository/cats_repo.dart';
import 'package:stb_cat_app/features/state/downloaded_cats/cubit/downloaded_cats_cubit.dart';
import 'package:stb_cat_app/features/utils/screen_util.dart';
import 'package:flutter_device_type/flutter_device_type.dart';
import 'details_view.dart';

class SavedCats extends StatefulWidget {
  const SavedCats({Key? key}) : super(key: key);

  @override
  _SavedCatsState createState() => _SavedCatsState();
}

class _SavedCatsState extends State<SavedCats> {
  @override
  Widget build(BuildContext context) => BlocProvider<DownloadedCatsCubit>(
        create: (BuildContext context) =>
            DownloadedCatsCubit(repository: DBHelper()),
        child: const MyHomePage(),
      );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State createState() => MyHomePageState();
}

class MyHomePageState extends State {
  DBHelper dbHelper = DBHelper();
  late final DownloadedCatsCubit _downloadedCatsCubit;
  TextEditingController catNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _downloadedCatsCubit = BlocProvider.of<DownloadedCatsCubit>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Downloaded Images"),),
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<DownloadedCatsCubit, DownloadedCatsState>(
          builder: (BuildContext context, DownloadedCatsState state) {
        if (state is DownloadedCatsLoadedState) {
          return OrientationBuilder(
            builder: (context, orientation) {
              return Column(children: [
                Expanded(
                  child: GridView.count(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: false,
                    crossAxisCount: Device.get().isTablet
                        ? getCrossCount(orientation, context)
                        : 1,
                    // Generate 100 widgets that display their index in the List.
                    children: List.generate(state.photos.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ImageDetail(
                                      detailPage: DetailPage(
                                          state.photos[index].image_source,
                                          "base64",
                                          'pic' + index.toString()),
                                    )),
                          );
                        },
                        onLongPress: () async {
                          _downloadedCatsCubit
                              .deleteCatPhoto(state.photos[index].id);
                          _downloadedCatsCubit.getDownloadedPhotos();
                        },
                        child: SizedBox(
                          child: Card(
                              color: Colors.grey[200],
                              child: Stack(children: [
                                SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 300,
                                        width: double.infinity,
                                        child: Hero(
                                          tag: "pic1" + index.toString(),
                                          child: Card(
                                              child: Image.memory(
                                            const Base64Codec().decode(state
                                                .photos[index].image_source),
                                            fit: BoxFit.cover,
                                          )),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              state.photos[index].photo_name
                                                    .isEmpty
                                                ? ""
                                                : state
                                                    .photos[index].photo_name,
                                              style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                                            ),
                                            Row(
                                              children: [
                                                ClipOval(
                                                  child: Material(
                                                    color: Colors.green,
                                                    // Button color
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.indigo,
                                                      // Splash color
                                                      onTap: () {
                                                        showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title: const Text(
                                                                    "Name of the Cat",
                                                                  style: TextStyle(fontWeight: FontWeight.bold),),
                                                                content:
                                                                    TextField(
                                                                  controller:
                                                                      catNameController,
                                                                  decoration: const InputDecoration(
                                                                      border:
                                                                          OutlineInputBorder(),
                                                                      hintText:
                                                                          "Cat's Name"),
                                                                ),
                                                                actions: <
                                                                    Widget>[
                                                                  TextButton(
                                                                    child: const Text(
                                                                        'Save'),
                                                                    onPressed:
                                                                        () {
                                                                          _downloadedCatsCubit.update(Photo(
                                                                          state
                                                                              .photos[
                                                                                  index]
                                                                              .id,
                                                                          catNameController
                                                                              .text,
                                                                          state
                                                                              .photos[index]
                                                                              .image_source));
                                                                      Navigator.of(
                                                                              context)
                                                                          .pop();
                                                                      catNameController
                                                                          .text = "";
                                                                      _downloadedCatsCubit
                                                                          .getDownloadedPhotos();
                                                                    },
                                                                  ),
                                                                ],
                                                              );
                                                            });
                                                      },
                                                      child: const SizedBox(
                                                          width: 30,
                                                          height: 30,
                                                          child: Icon(
                                                            Icons
                                                                .create_rounded,
                                                            color: Colors.white,
                                                          )),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                ClipOval(
                                                  child: Material(
                                                    color: Colors
                                                        .red, // Button color
                                                    child: InkWell(
                                                      splashColor:
                                                          Colors.indigo,
                                                      // Splash color
                                                      onTap: () {
                                                        _downloadedCatsCubit
                                                            .deleteCatPhoto(
                                                                state
                                                                    .photos[
                                                                        index]
                                                                    .id);
                                                        _downloadedCatsCubit
                                                            .getDownloadedPhotos();
                                                      },
                                                      child: const SizedBox(
                                                          width: 32,
                                                          height: 32,
                                                          child: Icon(
                                                            Icons
                                                                .delete_forever_rounded,
                                                            color: Colors.white,
                                                          )),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ])),
                        ),
                      );
                    }),
                  ),
                ),
              ]);
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      }),



    );
  }
}
