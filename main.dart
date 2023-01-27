import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
// import 'package:post_update_ioe/posts.dart';
// import 'package:post_update_ioe/try_everything.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:const Website(),
    );
  }
}

class Website extends StatelessWidget {
  const Website ({Key? key}) : super(key: key);

  Future<String> readHtmlFile(String filePath) async {
    final response = await http.get(Uri.parse(filePath));
    final contents = response.body;
    return contents;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("WebSite Rendering. !!"),
      ),
      body: Container(
        color: Colors.black12,
        child: FutureBuilder<String>(
            future: readHtmlFile('https://www.ioenotes.edu.np/syllabus'),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              // List<Widget> widgetList;
              String? htmlContents;
              if (snapshot.hasData) {
                //   widgetList = <Widget>[
              //     Padding(
              //       padding: const EdgeInsets.only(top: 10),
              //       child: Text('$snapshot.data'),
              //     )
              //   ];
                htmlContents = snapshot.data;
              } else if (snapshot.hasError) {
                // widgetList = <Widget>[
                  //   const Icon(
                  //     Icons.error_outline,
                  //     color: Colors.red,
                  //     size: 60,
                  //   ),
                  //   Padding(
                  //     padding: const EdgeInsets.only(top: 16),
                  //     child: Text('Error: ${snapshot.error}'),
                  //   ),
                  // ];
                print('Error: ${snapshot.error}');
              }else{
                // widgetList = const <Widget>[
                //   SizedBox(
                //     width: 60,
                //     height: 60,
                //     child: CircularProgressIndicator(),
                //   ),
                //   Padding(
                //     padding: EdgeInsets.only(top: 16),
                //     child: Text('Awaiting result...'),
                //   ),
                // ];
                print("Fetching .....");
              }

              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Expanded(
                  child: Container(
                    color: Colors.black26,
                    child: Html(
                      data: htmlContents,
                    ),
                  ),
                ),
              );
            }
          ),
      ),
    );
  }
}
