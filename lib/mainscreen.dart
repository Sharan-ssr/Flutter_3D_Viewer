import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:imageview360/imageview360.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<AssetImage> imageList = List<AssetImage>();
  bool autoRotate = true;
  int rotationCount = 1;
  int swipeSensitivity = 2;
  bool allowSwipeToRotate = true;
  RotationDirection rotationDirection = RotationDirection.anticlockwise;
  Duration frameChangeDuration = Duration(milliseconds: 50);
  bool imagePrecached = false;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance
        .addPostFrameCallback((_) => updateImageList(context));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Honda-Civic",
          style: TextStyle(fontSize: 35),
        ),
        backgroundColor: Colors.red,
        elevation: 10,
      ),
      body: Column(
        children: <Widget>[
          Container(
            height: 600,
            child: ListView(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      height: 300,
                      child: Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 72.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              (imagePrecached == true)
                                  ? ImageView360(
                                      key: UniqueKey(),
                                      imageList: imageList,
                                      autoRotate: autoRotate,
                                      rotationCount: rotationCount,
                                      rotationDirection:
                                          RotationDirection.anticlockwise,
                                      frameChangeDuration:
                                          Duration(milliseconds: 30),
                                      swipeSensitivity: swipeSensitivity,
                                      allowSwipeToRotate: allowSwipeToRotate,
                                      onImageIndexChanged: (currentImageIndex) {
                                        print(
                                            "currentImageIndex: $currentImageIndex");
                                      },
                                    )
                                  : Text("Loading..."),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: Positioned(
                        bottom: 10,
                        right: 150,
                        child: Text(
                          "<360 View>",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    )
                  ],
                ),
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  height: 450,
                  color: Colors.grey[100],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Honda Civic LX",
                        style: TextStyle(fontSize: 30),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                          "The Honda Civic LX starts at 20,650 dollars for the sedan, 21,050 dollars for the coupe, and 21,750 dollars for the hatchback. The sedan and coupe come with the 158-horsepower four-cylinder engine. The hatchback has the 174-horsepower turbo-four. The sedan features a manual transmission, while the coupe and hatch come with a continuously variable automatic transmission. You can get the sedan with a CVT for 800 dollars.Standard features across the board include a 5-inch screen, Bluetooth, a four-speaker stereo, a USB port, automatic climate control, cloth seats, and a multi-angle rearview camera. It also comes with the Honda Sensing Suite of safety features, which bundles together forward collision warning, a collision mitigation braking system, lane departure warning, lane keep assist, road departure warning, and adaptive cruise control. A remote start is available in the hatchback for about 400 dollars and in the coupe for around 500 dollars. A wireless device charger can be added to the sedan or coupe for about 300 dollars."),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            height: 92,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[200]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Honda Civic",
                        style: TextStyle(fontSize: 25),
                      ),
                      Text("₹ 17.94 Lakh")
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.orange,
                  ),
                  child: Center(
                      child: Text(
                    "Book Now",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateImageList(BuildContext context) async {
    for (int i = 1; i <= 52; i++) {
      imageList.add(AssetImage('assets/$i.png'));
      //* To precache images so that when required they are loaded faster.
      await precacheImage(AssetImage('assets/$i.png'), context);
    }
    setState(() {
      imagePrecached = true;
    });
  }
}
