import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:args/args.dart';

// ======================================================================

void main(List<String> args) {
  final filenameToLoad = cli(args);
  // sleep(const Duration(seconds: 3));
  runApp(AphiApp(filenameToLoad));
}

// ----------------------------------------------------------------------

String? cli(List<String> args) {
  final parser = ArgParser();
  parser.addFlag('help', abbr: "h", negatable: false);
  try {
    final results = parser.parse(args);
    if (results["help"] as bool) {
      throw const FormatException("");
    } else if (results.rest.length > 1) {
      throw const FormatException("invalid number of arguments");
    } else if (results.rest.length == 1) {
      return results.rest[0];
    } else {
      return null;
    }
  } on FormatException catch (err) {
    if (err.message.isNotEmpty) {
      print("> ERROR: ${err.message}\n");
    }
    print("Usage: aphi [chart.ace | tree.tjz | client-setup.json]\n${parser.usage}");
    exit(1);
  }
}

// ======================================================================

class AphiApp extends StatelessWidget {
  final String? _filenameToLoad;

  AphiApp(this._filenameToLoad, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aphi',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: AphiWindow(filenameToLoadInitially: _filenameToLoad),
    );
  }
}

class AphiWindow extends StatefulWidget {
  final String? filenameToLoadInitially;

  const AphiWindow({Key? key, required this.filenameToLoadInitially}) : super(key: key);

  @override
  State<AphiWindow> createState() => _AphiWindowState();
}

class _AphiWindowState extends State<AphiWindow> {
  String? loadedFilename;

  @override
  void initState() {
    super.initState();
    loadedFilename = widget.filenameToLoadInitially;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the AphiWindow object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(loadedFilename ?? "Please choose .ace, .tjz or .aphi"),
      ),
      // body: Center(),
    );
  }
}

// class _AphiWindowState extends State<AphiWindow> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // Here we take the value from the AphiWindow object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.filenameToLoadInitially ?? "No file"),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Invoke "debug painting" (press "p" in the console, choose the
//           // "Toggle Debug Paint" action from the Flutter Inspector in Android
//           // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//           // to see the wireframe for each widget.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headline4,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }
