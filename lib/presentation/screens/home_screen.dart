import 'package:flutter/material.dart';
import 'package:tv_app/constants/my_color.dart';
import 'package:tv_app/constants/strings.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  Widget buildNavigationCard(BuildContext context,String route, String title, IconData icon) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        color: MyColors.myYellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 8.0,
        child: Center(
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.8,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 50, color: MyColors.myGray),
                SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(
                    color: MyColors.myGray,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.myGray,
      appBar: AppBar(
        title: Text(
            "Home",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
        backgroundColor: MyColors.myYellow,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildNavigationCard(
              context,
              popularMoviesRoute,
              "Movies",
              Icons.movie,
            ),
            SizedBox(height: 20),
            buildNavigationCard(
              context,
              popularSeriesRoute,
              "Series",
              Icons.tv,
            ),
            SizedBox(height: 20),
            buildNavigationCard(
              context,
              popularActorsRoute,
              "Actors",
              Icons.person,
            ),
          ],
        ),
      ),
    );
  }
}
