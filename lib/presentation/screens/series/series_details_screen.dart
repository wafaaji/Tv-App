import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_app/business_logic/cubit/series_cubit.dart';
import 'package:tv_app/constants/my_color.dart';
import 'package:tv_app/data/models/series.dart';

class SeriesDetailsScreen extends StatelessWidget {
  final Series series;

  const SeriesDetailsScreen({super.key, required this.series,});

  Widget buildSliverAppBar(){
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGray,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          series.name,
          style: TextStyle(
            color: MyColors.myWhite,
          ),
        ),
        background: Hero(
          tag: series.id,
          child: series.getPosterUrl().isNotEmpty
              ? Image.network(
              series.getPosterUrl(),
              fit: BoxFit.cover,
              )
            : Image.asset(
           "assets/images/no image.png",
          ),
        ),
      ),
    );
  }

  Widget seriesInfo(String? title, String? value, bool isOneLine){
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

  Widget checkSeriesDetailsAreLoaded(SeriesState state){
    if(state is SeriesDetailsLoaded){
      return displaySeriesDetails(state);
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

  Widget displaySeriesDetails(state){
    var seriesDetails = (state).seriesDetails;
    print("Series Details ${seriesDetails.toJson()}");
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        seriesInfo("Genres:  ", seriesDetails.genres.map((genre) => genre.name).join(" / "), false),
        buildDivider(295),
        seriesInfo("Last Air Date:  ", seriesDetails.lastAirDate, true),
        buildDivider(250),
        seriesInfo("Number Of Episodes:  ", "${seriesDetails.numberOfEpisodes.toString()} Episodes", true),
        buildDivider(200),
        seriesInfo("Number Of Seasons:  ", "${seriesDetails.numberOfSeasons.toString()} Seasons", true),
        buildDivider(200),
        seriesInfo("Production Companies:  ", seriesDetails.productionCompanies.map((productionCompanies) => productionCompanies.name).join(" / "), false),
        buildDivider(190),
        seriesInfo("Status:  ", seriesDetails.status, true),
        buildDivider(300),
        seriesInfo("Type:  ", seriesDetails.type, true),
        buildDivider(310),
        Center(
          child: DefaultTextStyle(
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20.0,
              color: MyColors.myWhite,
              shadows: [
                Shadow(
                  blurRadius: 7,
                  color: MyColors.myYellow,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: seriesDetails.tagline.isNotEmpty ?
            AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                FlickerAnimatedText(seriesDetails.tagline),
              ],
            ) : Container(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SeriesCubit>(context).getSeriesDetails(series.id);
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
                        seriesInfo("Original Name:  ", series.originalName, true),
                        buildDivider(250),
                        seriesInfo("Original Language:  ", series.originalLanguage, true),
                        buildDivider(215),
                        seriesInfo("Overview:  ", series.overview, false),
                        buildDivider(280),
                        seriesInfo("First Air Date:  ", series.firstAirDate, true),
                        buildDivider(255),
                        seriesInfo("Vote Average:  ", series.voteAverage.toString(), true),
                        buildDivider(250),
                        BlocBuilder<SeriesCubit, SeriesState>(builder: (context, state){
                          return checkSeriesDetailsAreLoaded(state);
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
