import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with TickerProviderStateMixin {
  double horizontalPadding = 50.0;
  double horizontalMargin = 20.0;
  int no_of_icons = 3;

  //will be used for animation
  late double position;

  int selected = 0;

  //icons
  List<String> icons = [
    'assets/images/chat.png',
    'assets/images/flames.png',
    'assets/images/music_note.png'
  ];

  late AnimationController controller;
  late Animation<double> animation;

  List<Color> colors = [
    const Color.fromARGB(255, 252, 177, 26),
    const Color.fromARGB(255, 218, 31, 59),
    Color.fromARGB(255, 3, 91, 179)
  ];

  @override
  void initState() {
    //initialize the controller
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 375));

    super.initState();
  }

  @override
  void didChangeDependencies() {
    animation = Tween(begin: getEndPosition(0), end: getEndPosition(2)).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack));
    position = getEndPosition(0);

    super.didChangeDependencies();
  }

  double getEndPosition(int index) {
    double totalMargin = 2 * horizontalMargin;
    double totalPadding = 2 * horizontalPadding;
    double valueToOmit = totalMargin + totalPadding;

    return (((MediaQuery.of(context).size.width - valueToOmit) / no_of_icons) *
                index +
            horizontalPadding) +
        ((((MediaQuery.of(context).size.width - valueToOmit)) / no_of_icons) /
            2) -
        70;
  }

  void animationDrop(int index) {
    animation = Tween(begin: position, end: getEndPosition(index)).animate(
        CurvedAnimation(parent: controller, curve: Curves.easeOutBack));

    controller.forward().then((value) {
      position = getEndPosition(index);
      controller.dispose();
      controller = AnimationController(
          vsync: this, duration: Duration(milliseconds: 370));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: [
            Positioned.fill(
                child: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              curve: Curves.easeOut,
              color: colors[selected],
            )),
            Positioned(
              bottom: horizontalMargin,
              left: horizontalMargin,
              child: AnimatedBuilder(
                  animation: controller,
                  builder: (BuildContext context, Widget? child) {
                    return CustomPaint(
                      painter: AppBarPainter(animation.value),
                      size: Size(
                          MediaQuery.of(context).size.width -
                              (2 * horizontalMargin),
                          80.0),

                      //showing icons
                      child: SizedBox(
                        height: 120.0,
                        width: MediaQuery.of(context).size.width -
                            (2 * horizontalMargin),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          child: Row(
                            children: icons.map<Widget>((icon) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    animationDrop(icons.indexOf(icon));
                                    selected = icons.indexOf(icon);
                                  });
                                },
                                child: AnimatedContainer(
                                  duration: Duration(milliseconds: 570),
                                  curve: Curves.easeOut,
                                  height: 100.0,
                                  width: (MediaQuery.of(context).size.width -
                                          (2 * horizontalMargin) -
                                          (2 * horizontalPadding)) /
                                      3,
                                  // color: icons.indexOf(icon) % 2 == 0
                                  //     ? Colors.amber.withOpacity(0.5)
                                  //     : Colors.red.withOpacity(0.5),
                                  padding: //22.5,17.5
                                      EdgeInsets.only(bottom: 17.5, top: 22.5),
                                  alignment: selected == icons.indexOf(icon)
                                      ? Alignment.topCenter
                                      : Alignment.bottomCenter,
                                  child: SizedBox(
                                    width: 35,
                                    height: 35,
                                    child: Center(
                                        child: AnimatedSwitcher(
                                      duration: Duration(milliseconds: 375),
                                      switchInCurve: Curves.easeOut,
                                      switchOutCurve: Curves.easeOut,
                                      child: selected == icons.indexOf(icon)
                                          ? Image.asset(
                                              icon,
                                              width: 30,
                                              color:
                                                  colors[icons.indexOf(icon)],
                                              key: ValueKey('yellow$icon'),
                                            )
                                          : Image.asset(
                                              // color: Colors.transparent,
                                              icon,
                                              key: ValueKey('white$icon'),
                                              width: 30.0,
                                            ),
                                    )),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}

//handles the logic of drawing curves.
class AppBarPainter extends CustomPainter {
  double x;
  AppBarPainter(this.x);

  double height = 80.0;
  double start = 40.0;
  double end = 120.0;

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    var path = Path();
    /*
    path.moveTo(0.0, 0.0);
    path.lineTo(20.0, 0);

    path.quadraticBezierTo(40.0, 0.0, 50.0, 30.0);
    path.quadraticBezierTo(60.0, 55.0, 90.0, 55.0);
    path.quadraticBezierTo(120.0, 55.0, 130.0, 30.0);
    path.quadraticBezierTo(140.0, 0.0, 160.0, 0.0);

    path.lineTo(size.width - 20.0, 0.0);

    path.quadraticBezierTo(size.width, 0.0, size.width, 25.0);
    path.lineTo(size.width, size.height - 25.0);
    path.quadraticBezierTo(
        size.width, size.height, size.width - 25.0, size.height);
    path.lineTo(25.0, size.height);
    path.quadraticBezierTo(0.0, size.height, 0.0, size.height - 25.0);
    path.lineTo(0.0, 25.0);
    path.quadraticBezierTo(0.0, 0.0, 20.0, 0.0);
    */
    path.moveTo(0.0, start);
    path.lineTo((x) < 20.0 ? 20.0 : x, start);
    path.quadraticBezierTo(20.0 + x, start, 30.0 + x, start + 30.0);
    path.quadraticBezierTo(40.0 + x, start + 55.0, 70.0 + x, start + 55.0);
    path.quadraticBezierTo(100.0 + x, start + 55.0, 110.0 + x, start + 30.0);

    path.quadraticBezierTo(
        120.0 + x,
        start,
        (140 + x) > (size.width - 20.0) ? (size.width - 20.0) : 140.0 + x,
        start);
    path.lineTo(size.width - 20.0, start);

    //box with border-radius
    path.quadraticBezierTo(size.width, start, size.width, start + 25.0);
    path.lineTo(size.width, end - 25.0);
    path.quadraticBezierTo(size.width, end, size.width - 25.0, end);
    path.lineTo(25.0, end);
    path.quadraticBezierTo(0.0, end, 0.0, end - 25.0);
    path.lineTo(0.0, start + 25.0);
    path.quadraticBezierTo(0.0, start, 20.0, start);

    path.close();

    canvas.drawPath(path, paint);

    canvas.drawCircle(Offset(70.0 + x, 50.0), 35.0, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
