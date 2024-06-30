import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_app/business_logic/cubit/movies_cubit.dart';
import 'package:tv_app/constants/my_color.dart';
import 'package:tv_app/data/models/movie.dart';
import 'package:tv_app/presentation/widgets/movies_item.dart';

class PopularMoviesScreen extends StatefulWidget {
  @override
  State<PopularMoviesScreen> createState() => _PopularMoviesScreenState();
}

class _PopularMoviesScreenState extends State<PopularMoviesScreen> {
  late ScrollController _scrollController;
  List<Movie> allMovies = [];
  List<Movie> searchedMovies = [];
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildAppBarSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGray,
      decoration: InputDecoration(
        hintText: "Find a Movie",
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColors.myGray.withOpacity(0.75),
          fontSize: 18,
        ),
      ),
      style: TextStyle(
        color: MyColors.myGray,
        fontSize: 18,
      ),
      onChanged: (searchMovieText){
        // take user text and compare with movies item
        addSearchesForItemToSearchedList(searchMovieText);
      },
    );
  }

  void addSearchesForItemToSearchedList(String searchMovieText){
    // toLowerCase to accept the lower and upper case
    // startsWith(searchesMovie) = movie how start in this string that the user write it
    searchedMovies = allMovies
      .where((movie) =>
         movie.title.toLowerCase().startsWith(searchMovieText))
      .toList();
  }

  // to change the appbar from title and icon to the icon and text field and icon and vice versa
  List<Widget> _buildAppBarActions(){
    // if user now searching
    if(_isSearching){
      return [
        IconButton(
            onPressed: (){
              _clearSearch();
              // like i have two screen one without the search and second with search
              Navigator.pop(context);
            },
            icon: Icon(
                Icons.clear,
                color: MyColors.myGray,
            ),
        ),
      ];
    }else{
      return [
        IconButton(
            onPressed: (){
              _startSearch();
            },
            icon: Icon(
              Icons.search,
              color: MyColors.myGray,
            ),
        ),
      ];
    }
  }

  void _startSearch(){
    // to show the back button (i do like i go to the other screen this icon be default show in the second screen)
    // like i have two screen one without the search and second with search
    // ! i tell the function it not be null do what i want
    // on remove to delete want user write when finish search
    ModalRoute.of(context)!
        .addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch(){
    // clear the controller text (delete the user text search)
    _clearSearch();

    setState(() {
      _isSearching = false;
    });
  }

  void _clearSearch(){
    setState(() {
      _searchTextController.clear();
    });
  }

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    BlocProvider.of<MoviesCubit>(context).getPopularMovies();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      BlocProvider.of<MoviesCubit>(context).getPopularMovies();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<MoviesCubit, MoviesState>(builder: (context, state) {
      if (state is PopularMoviesLoaded) {
        allMovies = state.movies;
        return buildLoadedListWidgets(state.movies);
      } else {
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidgets(List<Movie> movies) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Container(
        color: MyColors.myGray,
        child: Column(
          children: [
            buildMoviesList(movies),
            if (BlocProvider.of<MoviesCubit>(context).isLoading)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(
                  color: MyColors.myYellow,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget buildMoviesList(List<Movie> movies) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 3,
        crossAxisSpacing: 1,
        mainAxisSpacing: 1,
      ),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: _searchTextController.text.isEmpty ? allMovies.length : searchedMovies.length,
      itemBuilder: (ctx, index) {
        return MoviesItem(
            movie: _searchTextController.text.isEmpty
                ? allMovies[index]
                : searchedMovies[index]
        );
      },
    );
  }

  // the default without search (before search)
  Widget _buildAppBarTitle(){
    return Text(
      "Popular Movies",
      style: TextStyle(
        color: MyColors.myGray,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGray,
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        leading: _isSearching
            ? BackButton(color: MyColors.myGray,)
            : Container(),
        title: _isSearching
            ? _buildAppBarSearchField()
            : _buildAppBarTitle(),
        actions: _buildAppBarActions(),
      ),
      body: buildBlocWidget(),
    );
  }
}
