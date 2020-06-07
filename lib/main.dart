import 'package:custom_contacts_prototype/Screens/cctv.dart';
import 'package:custom_contacts_prototype/Screens/transport_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';

void main() {
  runApp(AppRootWidget());
}

class AppRootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //set the status bar color to black
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarBrightness: Brightness.light),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _activeScreen = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: (() {
              switch (_activeScreen) {
                case 0:
                  return TransportScreen();
                  break;
                case 1:
                  return CctvScreen();
                  break;
                default:
                  throw PlatformException(
                      code: 'Out of bounds bottom navigation index');
              }
            }()),
          ),
          BottomNavigationBar(
            currentIndex: _activeScreen,
            onTap: (index) {
              setState(
                () {
                  _activeScreen = index;
                },
              );
            },
            items: [
              BottomNavigationBarItem(
                title: Text('Transport'),
                icon: Icon(AntDesign.car),
              ),
              BottomNavigationBarItem(
                title: Text('CCTV'),
                icon: Icon(AntDesign.camera),
              )
            ],
          )
        ],
      ),
    );
  }
}
