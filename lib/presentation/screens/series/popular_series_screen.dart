import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_app/business_logic/cubit/series_cubit.dart';
import 'package:tv_app/constants/my_color.dart';
import 'package:tv_app/data/models/series.dart';
import 'package:tv_app/presentation/widgets/series_item.dart';

class PopularSeriesScreen extends StatefulWidget {

  @override
  State<PopularSeriesScreen> createState() => _PopularSeriesScreenState();
}

class _PopularSeriesScreenState extends State<PopularSeriesScreen> {
  late ScrollController _scrollController;
  List<Series> allSeries = [];
  List<Series> searchedSeries = [];
  bool _isSearching = false;
  final _searchTextController = TextEditingController();

  Widget _buildAppBarSearchField(){
    return TextField(
      controller: _searchTextController,
      cursorColor: MyColors.myGray,
      decoration: InputDecoration(
        hintText: "Find a Series",
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: MyColors.myGray,
          fontSize: 16,
        ),
      ),
      style: TextStyle(
        color: MyColors.myGray.withOpacity(0.75),
        fontSize: 16,
      ),
      onChanged: (searchSeriesText){
        addSearchedForItemToSearchedList(searchSeriesText);
      },
    );
  }

  void addSearchedForItemToSearchedList(String searchSeriesText){
    searchedSeries = allSeries
        .where((series) =>
        series.name.toLowerCase().startsWith(searchSeriesText))
        .toList();
  }

  List<Widget> _buildAppBarActions(){
    if(_isSearching){
      return [
        IconButton(
            onPressed: (){
              _clearSearch();
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
            onPressed: _startSearch,
            icon: Icon(
              Icons.search,
              color: MyColors.myGray,
            ),
        ),
      ];
    }
  }

  void _startSearch(){
    ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearch),);

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearch(){
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
    // tell the bloc to start
    BlocProvider.of<SeriesCubit>(context).getPopularSeries();
  }

  void _onScroll() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      BlocProvider.of<SeriesCubit>(context).getPopularSeries();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget buildBlocWidget(){
    return BlocBuilder<SeriesCubit, SeriesState>(builder: (context, state) {
      if (state is PopularSeriesLoaded){
        allSeries = (state).series;
        return buildLoadedListWidget();
      }else{
        return showLoadingIndicator();
      }
    });
  }

  Widget showLoadingIndicator(){
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLoadedListWidget(){
    return SingleChildScrollView(
      controller: _scrollController,
      child: Container(
        color: MyColors.myGray,
        child: Column(
          children: [
            buildSeriesList(),
            if (BlocProvider.of<SeriesCubit>(context).isLoading)
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

  Widget buildSeriesList(){
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
        itemCount: _searchTextController.text.isEmpty
            ? allSeries.length
            : searchedSeries.length,
        itemBuilder: (context, index) {
          return SeriesItem(
            series: _searchTextController.text.isEmpty
                ? allSeries[index]
                : searchedSeries[index],
          );
        },
    );
  }

  Widget _buildAppBarTitle(){
    return Text(
      "Popular Series",
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
