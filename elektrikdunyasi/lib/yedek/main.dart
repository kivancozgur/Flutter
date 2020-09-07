import 'package:elektrikdunyasi/Adres.dart';
import 'package:elektrikdunyasi/Indirilenler.dart';
import 'package:elektrikdunyasi/WebSite.dart';
import 'package:elektrikdunyasi/theme_provider.dart';
import 'package:elektrikdunyasi/yedek/Cardlar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// import 'package:circular_bottom_navigation/circular_bottom_navigation.dart';
// import 'package:circular_bottom_navigation/tab_item.dart';

// void main() => runApp(
//       ChangeNotifierProvider<DynamicTheme>(
//         builder: (_) => DynamicTheme(),
//         child: MyStatefulWidget(),
//       ),
//     );

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      print(_selectedIndex.toString());
      if (_selectedIndex == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      } else if (_selectedIndex == 1) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Indirilenler()));
      } else if (_selectedIndex == 2) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => WebViewExample()));
      } else if (_selectedIndex == 3) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Adres()));
      }
    });
  }

  bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DynamicTheme>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeProvider.getDarkMode() ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Image.network(
                    "https://lh3.googleusercontent.com/bqkV29VDyFBojRUcth2684_jaNaCXGNDQOsCJv_xtLzL5Ew1A-NU79cKH8pHsnQX1Sg"),
                decoration: BoxDecoration(
                  color: themeProvider.getDarkMode()
                      ? Colors.white70
                      : Colors.black87,
                ),
              ),
              ListTile(
                title: Text('Dergiler'),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Indirilenler()));
                },
              ),
              ListTile(
                title: Text('Üyelik'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Karanlık Mod'),
                    Switch(
                      value: themeProvider.getDarkMode(),
                      onChanged: (value) {
                        setState(() {
                          themeProvider.changeDarkMode(value);
                        });
                      },
                      activeTrackColor: Colors.lightGreenAccent,
                      activeColor: Colors.green,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(themeProvider.getDarkMode()
              ? 'Dark Mode'
              : 'Light Mode'), // title: const Text('Elektrik Dünyası'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.search), onPressed: () {})
          ],
        ),
        // body: cardlar.Cardlar(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          iconSize: 30,
          //fixedColor: Colors.red,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.library_books),
              label: "Kütüphane",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.file_download),
              label: "İndirilenler",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.language),
              label: "Web Sitesi",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: "Adres",
            ),
          ],
        ),
      ),
    );
  }
}
