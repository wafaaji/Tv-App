import 'package:flutter/material.dart';
import 'package:tv_app/constants/my_color.dart';
import 'package:tv_app/constants/strings.dart';
import 'package:tv_app/data/models/actor.dart';

class ActorsItem extends StatelessWidget {
  final Actor actor;

  ActorsItem({super.key, required this.actor});

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
      child: InkWell(
        onTap: () => Navigator.pushNamed(context, actorDetailsRoute, arguments: actor),
        child: GridTile(
          child: Hero(
            tag: actor.id.toString(),
            child: Container(
              color: MyColors.myGray,
              child: actor.getProfileUrl().isNotEmpty
                  ? FadeInImage.assetNetwork(
                width: double.infinity,
                height: double.infinity,
                placeholder: "assets/images/loading.gif",
                image: actor.getProfileUrl(),
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
              '${actor.name}',
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
