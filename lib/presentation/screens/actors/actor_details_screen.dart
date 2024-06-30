import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_app/business_logic/cubit/actors_cubit.dart';
import 'package:tv_app/constants/my_color.dart';
import 'package:tv_app/data/models/actor.dart';

class ActorDetailsScreen extends StatelessWidget {
  final Actor actor;

  const ActorDetailsScreen({super.key, required this.actor,});

  Widget buildSliverAppBar(){
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGray,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          actor.name,
          style: TextStyle(
            color: MyColors.myWhite,
          ),
        ),
        background: Hero(
          tag: actor.id.toString(),
          child: actor.getProfileUrl().isNotEmpty
              ? Image.network(
            actor.getProfileUrl(),
            fit: BoxFit.cover,
          )
              : Image.asset(
            "assets/images/no image.png",
          ),
        ),
      ),
    );
  }

  Widget actorsInfo(String? title, String? value, bool isOneLine){
    return RichText(
      maxLines: isOneLine ? 1 : 5,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: title,
            style: TextStyle(
              color: MyColors.myWhite,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          TextSpan(
            text: value ?? "N/A",
            style: TextStyle(
              color: MyColors.myWhite.withOpacity(0.75),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double endIndent){
    return Divider(
      height: 30,
      endIndent: endIndent,
      color: MyColors.myYellow,
      thickness: 2,
    );
  }

  Widget checkActorDetailsAreLoaded(ActorsState state){
    if(state is ActorDetailsLoaded){
      return displayActorDetails(state);
    }else{
      return showProgressIndicator();
    }
  }

  Widget showProgressIndicator(){
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget displayActorDetails(state){
    var actorDetails = (state).actorDetails;
    print("Actors Details ${actorDetails.toJson()}");
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        actorsInfo("Birthday:  ", actorDetails.birthday ?? "N/A", true),
        buildDivider(295),
        actorsInfo("Death Day:  ", actorDetails.deathday ?? "N/A", true),
        buildDivider(250),
        actorsInfo("Place Of Birthday:  ", actorDetails.placeOfBirth ?? "N/A", true),
        buildDivider(200),
      ],
    );
  }

  String _getGenderString(int? gender) {
    if (gender == 2) {
      return "Male";
    } else if (gender == 1) {
      return "Female";
    } else {
      return "N/A";
    }
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ActorsCubit>(context).getActorDetails(actor.id);
    return Scaffold(
      backgroundColor: MyColors.myGray,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  margin: EdgeInsets.fromLTRB(14, 14, 14, 0),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      actorsInfo("Gender:  ", _getGenderString(actor.gender), true),
                      buildDivider(250),
                      actorsInfo("Original Name:  ", actor.originalName, true),
                      buildDivider(215),
                      actorsInfo("known For:  ", actor.knownFor.map((knownFor) => knownFor.title).join(" / "), false),
                      buildDivider(280),
                      BlocBuilder<ActorsCubit, ActorsState>(builder: (context, state){
                        return checkActorDetailsAreLoaded(state);
                      }),
                    ],
                  ),
                ),
                SizedBox(height: 300,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
