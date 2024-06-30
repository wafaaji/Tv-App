import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_app/business_logic/cubit/actors_cubit.dart';
import 'package:tv_app/constants/my_color.dart';
import 'package:tv_app/data/models/actor.dart';
import 'package:tv_app/presentation/widgets/actors_item.dart';

class PopularActorsScreen extends StatefulWidget {
  @override
  State<PopularActorsScreen> createState() => _PopularActorsScreenState();
}

class _PopularActorsScreenState extends State<PopularActorsScreen> {
  late ScrollController _scrollController;
  List<Actor> allActors = [];
  List<Actor> searchedActors = [];
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildAppBarSearchField() {
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGray,
      decoration: InputDecoration(
        hintText: "Find a Actor",
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
      onChanged: (searchActorText){
        // take user text and compare with actors item
        addSearchesForItemToSearchedList(searchActorText);
      },
    );
  }

  void addSearchesForItemToSearchedList(String searchActorText){
    searchedActors = allActors
        .where((actor) =>
        actor.name.toLowerCase().startsWith(searchActorText))
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
    BlocProvider.of<ActorsCubit>(context).getPopularActors();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      BlocProvider.of<ActorsCubit>(context).getPopularActors();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<ActorsCubit, ActorsState>(builder: (context, state) {
      if (state is PopularActorsLoaded) {
        allActors = state.actor;
        return buildLoadedListWidgets(state.actor);
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

  Widget buildLoadedListWidgets(List<Actor> actor) {
    return SingleChildScrollView(
      controller: _scrollController,
      child: Container(
        color: MyColors.myGray,
        child: Column(
          children: [
            buildActorsList(actor),
            if (BlocProvider.of<ActorsCubit>(context).isLoading)
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

  Widget buildActorsList(List<Actor> actor) {
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
      itemCount: _searchTextController.text.isEmpty ? allActors.length : searchedActors.length,
      itemBuilder: (ctx, index) {
        return ActorsItem(
            actor: _searchTextController.text.isEmpty
                ? allActors[index]
                : searchedActors[index]
        );
      },
    );
  }

  // the default without search (before search)
  Widget _buildAppBarTitle(){
    return Text(
      "Popular Actors",
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
