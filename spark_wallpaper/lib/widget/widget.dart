import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:spark_wallpaper/models/photos_model.dart';
import 'package:spark_wallpaper/view/image_view.dart';

Widget wallPaper(List<PhotosModel> listPhotos, BuildContext context) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 0.6,
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 6.0,
        crossAxisSpacing: 6.0,
        children: listPhotos.map((PhotosModel photoModel) {
          return GridTile(
              child: GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          ImageView(
                            imgPath: photoModel.src.portrait.replaceAll('h=1200&w=800', 'h=600&w=400'),
                          )));
            },
            child: Hero(
              tag: photoModel.src.portrait.replaceAll('h=1200&w=800', 'h=600&w=400'),
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: kIsWeb
                        ? Image.network(
                            photoModel.src.portrait.replaceAll('h=1200&w=800', 'h=600&w=400'),
                            height: 50,
                            width: 100,
                            fit: BoxFit.cover,
                          )
                        : CachedNetworkImage(
                            imageUrl: photoModel.src.portrait.replaceAll('h=1200&w=800', 'h=600&w=400'),
                            placeholder: (context, url) => Container(
                                  color: Color(0xfff5f8fd),
                                ),
                            fit: BoxFit.cover)),
              ),
            ),
          ));
        }).toList()),
  );
}

Widget brandName() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "Spark",
        style: TextStyle(color: Colors.white, fontFamily: 'Overpass'),
      ),
      Text(
        "Wallpaper",
        style: TextStyle(color: Colors.black, fontFamily: 'Overpass'),
      )
    ],
  );
}
