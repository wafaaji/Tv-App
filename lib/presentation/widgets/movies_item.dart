import 'package:flutter/material.dart';
import 'package:tv_app/constants/my_color.dart';
import 'package:tv_app/constants/strings.dart';
import 'package:tv_app/data/models/movie.dart';

class MoviesItem extends StatelessWidget {

  final Movie movie;

  const MoviesItem({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      // InkWell widget for click
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, moviesDetailsRoute, arguments: movie),
        child: GridTile(
          // for animation image when navigate to the other screen
          child: Hero(
            // tag = uniqe id
            tag: movie.id,
            child: Container(
              color: MyColors.myGray,
              child: movie.getPosterUrl().isNotEmpty
                  ? FadeInImage.assetNetwork(
                width: double.infinity,
                height: double.infinity,
                placeholder: "assets/images/loading.gif",
                image: movie.getPosterUrl(),
                fit: BoxFit.cover,
              )
                  : Image.asset(
                "assets/images/no image.png",
              ),
            ),
          ),
          footer: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            color: Colors.black54,
            alignment: Alignment.bottomCenter,
            child: Text(
              movie.title,
              style: TextStyle(
                height: 1.3,
                fontSize: 16,
                color: MyColors.myWhite,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
