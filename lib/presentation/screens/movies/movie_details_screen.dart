import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_app/business_logic/cubit/movies_cubit.dart';
import 'package:tv_app/constants/my_color.dart';
import 'package:tv_app/data/models/movie.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;
  const MovieDetailsScreen({super.key, required this.movie});

  Widget buildSliverAppBar(){
    return SliverAppBar(
      expandedHeight: 600,
      pinned: true,
      stretch: true,
      backgroundColor: MyColors.myGray,
      iconTheme: IconThemeData(color: MyColors.myWhite),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          movie.title,
          style: TextStyle(
            color: MyColors.myWhite,
            fontSize: 18,
          ),
        ),
        background: Hero(
          tag: movie.id,
          child: Image.network(
              movie.getPosterUrl(),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  Widget movieInfo(String title, String value, bool isOneLine){
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
              text: value,
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
      color: MyColors.myYellow,
      height: 30,
      endIndent: endIndent,
      thickness: 2,
    );
  }

  Widget checkMovieDetailsAreLoaded(MoviesState state){
    if(state is MovieDetailsLoaded){
      return displayMovieDetails(state);
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

  Widget displayMovieDetails(state){
    var movieDetails = (state).movieDetails;
    print("Movie Details ${movieDetails.toJson()}");
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        movieInfo("Budget:  ", "\$${movieDetails.budget.toString()}", true),
        buildDivider(295),
        movieInfo("Genres:  ", movieDetails.genres.map((genre) => genre.name).join(" / "), false),
        buildDivider(295),
        movieInfo("Production Companies:  ", movieDetails.productionCompanies.map((productionCompanies) => productionCompanies.name).join(" / "), false),
        buildDivider(190),
        movieInfo("Revenue:  ", "\$${movieDetails.revenue.toString()}", true),
        buildDivider(290),
        movieInfo("Run Time:  ", "${movieDetails.runtime.toString()} minutes", true),
        buildDivider(280),
        movieInfo("Status:  ", movieDetails.status, true),
        buildDivider(300),
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
            child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  FlickerAnimatedText(movieDetails.tagline),
                ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<MoviesCubit>(context).getMovieDetails(movie.id);
    return Scaffold(
      backgroundColor: MyColors.myGray,
      body: CustomScrollView(
        slivers: [
          buildSliverAppBar(),
          SliverList(delegate: SliverChildListDelegate(
            [
              Container(
                margin: const EdgeInsets.fromLTRB(14, 14, 14, 0),
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // if i have parameter list write .join( / )
                    movieInfo("Original Title:  ", movie.originalTitle, true),
                    buildDivider(255),
                    movieInfo("Original Language:  ", movie.originalLanguage, false),
                    buildDivider(215),
                    movieInfo("Overview:  ", movie.overview, false),
                    buildDivider(280),
                    movieInfo("Release Data:  ", movie.releaseDate, true),
                    buildDivider(255),
                    movieInfo("Vote Average:  ", movie.voteAverage.toString(), true),
                    buildDivider(250),
                    BlocBuilder<MoviesCubit, MoviesState>(builder: (context, state){
                      return checkMovieDetailsAreLoaded(state);
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