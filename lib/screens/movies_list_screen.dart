import 'package:flutter/material.dart';
import 'package:movie_project/constants.dart';
import 'package:movie_project/models/movie_data.dart';
import 'package:movie_project/screens/webview_screen.dart';
import 'package:provider/provider.dart';

class BookGrid extends StatefulWidget {
  BookGrid({Key key}) : super(key: key);

  @override
  _BookGridState createState() => _BookGridState();
}

class _BookGridState extends State<BookGrid> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<MovieData>(context, listen: false)
          .getMoviesBySearch('avengers');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MovieData>(
      builder: (BuildContext context, MovieData movieData, Widget child) {
        return buildScaffold(movieData);
      },
    );
  }

  /// Construct a color from a hex code string, of the format #RRGGBB.
  Color hexToColor(String code) {
    return new Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  Padding getMoviesGrid(MovieData movieData) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPaddin, vertical: kDefaultPaddin),
      child: GridView.builder(
        itemCount: movieData?.movieObj?.search != null
            ? movieData.movieObj.search.length
            : 0,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: kDefaultPaddin,
          crossAxisSpacing: kDefaultPaddin,
          childAspectRatio: 0.55,
        ),
        itemBuilder: (BuildContext context, int index) => Container(
          // padding: EdgeInsets.only(left: 5.0),
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Card(
                    elevation: 18.0,
                    child: Image(
                      image: NetworkImage(movieData?.movieObj?.search != null
                          ? movieData.movieObj.search[index].poster
                          : ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 2,
              ),
              Expanded(
                flex: 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5.0),
                  child: SizedBox(
                    width: 170,
                    child: RaisedButton(
                      onPressed: () {
                        Provider.of<MovieData>(context, listen: false)
                            .getMovieUrl(
                                movieData.movieObj.search[index].imdbID);
                      },
                      color: hexToColor(kButtonColor),
                      child: Text(
                        'watch',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.0,
                            letterSpacing: 0.94),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Scaffold buildScaffold(MovieData movieData) {
    return Scaffold(
      backgroundColor: hexToColor(kPrimaryColor),
      body: SafeArea(
          child: Stack(
        children: [
          movieData.loading != true
              ? Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 19.0),
                        child: SizedBox(
                          width: 350,
                          child: TextFormField(
                            style: TextStyle(
                                fontSize: 18,
                                color: hexToColor(kSecondaryColor),
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold),
                            cursorColor: Colors.white,
                            onFieldSubmitted: (value) {
                              Provider.of<MovieData>(context, listen: false)
                                  .getMoviesBySearch(value);
                            },
                            decoration: InputDecoration(
                              fillColor: null,
                              hintStyle: TextStyle(
                                color: Colors.white24,
                                fontSize: 18,
                                letterSpacing: 1.0,
                                fontWeight: FontWeight.w600,
                              ),
                              hintText: 'Search movies...',
                              suffixIcon: Icon(
                                Icons.search,
                                color: hexToColor(kSecondaryColor),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(
                                  color: hexToColor(kButtonColor),
                                ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: getMoviesGrid(
                        movieData,
                      ),
                    ),
                  ],
                )
              : Offstage(),
          movieData.loading == true
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: hexToColor(kSecondaryColor),
                  ),
                )
              : Offstage(),
          movieData.openUrl == true
              ? WebViewExample(url: movieData.url)
              : Offstage()
        ],
      )),
    );
  }
}
