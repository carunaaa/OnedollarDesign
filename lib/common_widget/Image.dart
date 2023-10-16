import 'dart:async';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Album>> fetchAlbums() async {
  final response = await http.get(Uri.parse(
      'https://v3rc.explorug.com/modules/virtualexhibition/virtualexhibition.aspx/?name=emotions'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonList = jsonDecode(response.body);
    final List<Album> albums =
        jsonList.map((json) => Album.fromJson(json)).toList();
    return albums;
  } else {
    throw Exception('Failed to load albums');
  }
}

class Album {
  final String name;
  final String renderedImageUrl;
  final double silkPercent;
  final double physicalWidth;
  final double physicalHeight;
  // void Function()? onPressed;

  Album({
    required this.name,
    required this.renderedImageUrl,
    required this.silkPercent,
    required this.physicalWidth,
    required this.physicalHeight,
    // required this.onPressed,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['Name'],
      renderedImageUrl: json['RenderedImageUrl'],
      silkPercent: json['SilkPercent'].toDouble(),
      physicalWidth: json['PhysicalWidth'].toDouble(),
      physicalHeight: json['PhysicalHeight'].toDouble(),
    );
  }
}

void main() {
  runApp(const ImagesState());
}

class ImagesState extends StatefulWidget {
  const ImagesState({Key? key});

  @override
  State<ImagesState> createState() => _ImagesStateState();
}

class _ImagesStateState extends State<ImagesState> {
  List<String> imageUrls = [];
  String baseUrl = 'https://v3.explorug.com';
  late Future<List<Album>> futureAlbums;
  int selectedAlbumIndex = 0; // Index of the selected album to display

  @override
  void initState() {
    super.initState();
    futureAlbums = fetchAlbums();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double sliderHeight = screenHeight * 0.5;

    return FutureBuilder<List<Album>>(
      future: futureAlbums,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final albums = snapshot.data!;
          imageUrls = albums
              .map((album) => baseUrl + Uri.encodeFull(album.renderedImageUrl))
              .toList();

          return Container(
            color: Colors.white,
            padding: EdgeInsets.only(top: 0),
            child: Column(
              children: [
                Text(
                  '\$1',
                  style: TextStyle(
                    fontSize: 30.0,
                    fontFamily: 'PoppinsLight',
                    fontWeight: FontWeight.bold,
                    color: Colors.amber,
                  ),
                ),
                Text(
                  // 'Name: ${albums[selectedAlbumIndex].name}\nSilk Percent: ${albums[selectedAlbumIndex].silkPercent}',
                  '${albums[selectedAlbumIndex].name}',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    // height: 400.0,
                    height: sliderHeight,

                    onPageChanged: (index, reason) {
                      // Update the selected album index as the user scrolls
                      setState(() {
                        selectedAlbumIndex = index;
                      });
                    },
                  ),
                  items: imageUrls.map((renderedImageUrl) {
                    return Image.network(
                      renderedImageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Text('Image not found');
                      },
                    );
                  }).toList(),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        child: Text(
                          "Add to Cart",
                          style: TextStyle(
                            fontFamily: 'PoppinsLight',
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueGrey.shade300,
                          elevation: 0,
                        ),
                        onPressed: () {},
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        } else {
          return Center(child: Text('No data available.'));
        }
      },
    );
  }
}
