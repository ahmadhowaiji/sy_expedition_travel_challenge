import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sy_expedition_travel_challenge/leopard_page.dart';
import 'package:sy_expedition_travel_challenge/styles.dart';

class PageOffsetNotifier with ChangeNotifier {
  double _offset = 0;
  double _page = 0;

  PageOffsetNotifier(PageController pageController) {
    pageController.addListener(() {
      _offset = pageController.offset;
      _page = pageController.page;
      notifyListeners();
    });
  }

  double get offset => _offset;
  double get page => _page;
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (_) => PageOffsetNotifier(_pageController),
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              PageView(
                controller: _pageController,
                physics: ClampingScrollPhysics(),
                children: <Widget>[
                  LeopardPage(),
                  VulturePage(),
                ],
              ),
              LeopardImage(),
              VultureImage(),
              AppBar(),
              ShareButton(),
              PageIndicator(),
              ArrowIcon(),
              TravelDetailsLabel(),
              StartCampLabel(),
              StartTimeLabel(),
              BaseCampLabel(),
              BaseTimeLabel(),
              DistanceLabel(),
              TravelDots(),
              MapButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'SY',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Icon(Icons.menu),
          ],
        ),
      ),
    );
  }
}

class VultureImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double left = notifier.offset;

        return Positioned(
            left: 1.20 * MediaQuery.of(context).size.width - 0.85 * left,
            child: child);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 90),
        child: IgnorePointer(
          child: Image.asset(
            'assets/vulture.png',
            height: MediaQuery.of(context).size.height / 3,
          ),
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, _) => Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 24),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: notifier.page.round() == 0 ? white : lightGrey,
                ),
                width: 6,
                height: 6,
              ),
              SizedBox(
                width: 6,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: notifier.page.round() == 0 ? lightGrey : white,
                ),
                width: 6,
                height: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ArrowIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 165.0 + 400 + 32,
      right: 24,
      child: Icon(
        Icons.keyboard_arrow_up,
        size: 28,
        color: lighterGrey,
      ),
    );
  }
}

class ShareButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 24,
      bottom: 16,
      child: Icon(
        Icons.share,
      ),
    );
  }
}

class VulturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: VultureCircle());
    return Center(
        child: Padding(
      padding: const EdgeInsets.only(bottom: 64),
      child: Image.asset(
        'assets/vulture.png',
        height: MediaQuery.of(context).size.height / 3,
      ),
    ));
  }
}

class TravelDetailsLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) => Positioned(
        top: 164.0 + 400 + 32,
        left: 32 + MediaQuery.of(context).size.width - notifier.offset,
        child: Opacity(
          opacity: math.max(0, 4 * notifier.page - 3),
          child: child,
        ),
      ),
      child: Text(
        'Travel details',
        style: TextStyle(fontSize: 18),
      ),
    );
  }
}

class StartCampLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double page = math.max(0, 4 * notifier.page - 3);
        print(page * 24);
        return Positioned(
          top: 164.0 + 400 + 32 + 16 + 32,
          left: page * 24,
          width: (MediaQuery.of(context).size.width - 64) / 3,
          child: Opacity(
            opacity: page,
            child: child,
          ),
        );
      },
      child: Text(
        'Start camp',
        textAlign: TextAlign.right,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
      ),
    );
  }
}

class BaseCampLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double page = math.max(0, 4 * notifier.page - 3);
        print(page * 24);
        return Positioned(
          top: 164.0 + 400 + 32 + 16 + 32,
          right: page * 24,
          width: (MediaQuery.of(context).size.width - 64) / 3,
          child: Opacity(
            opacity: page,
            child: child,
          ),
        );
      },
      child: Text(
        'Base camp',
        textAlign: TextAlign.left,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
      ),
    );
  }
}

class BaseTimeLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double page = math.max(0, 4 * notifier.page - 3);
        print(page * 24);
        return Positioned(
          top: 164.0 + 400 + 32 + 16 + 32 + 40,
          right: page * 24,
          width: (MediaQuery.of(context).size.width - 64) / 3,
          child: Opacity(
            opacity: page,
            child: child,
          ),
        );
      },
      child: Text(
        '05:35 am',
        textAlign: TextAlign.left,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w300, color: lighterGrey),
      ),
    );
  }
}

class StartTimeLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double page = math.max(0, 4 * notifier.page - 3);
        print(page * 24);
        return Positioned(
          top: 164.0 + 400 + 32 + 16 + 32 + 40,
          left: page * 24,
          width: (MediaQuery.of(context).size.width - 64) / 3,
          child: Opacity(
            opacity: page,
            child: child,
          ),
        );
      },
      child: Text(
        '02:15 pm',
        textAlign: TextAlign.right,
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w300, color: lighterGrey),
      ),
    );
  }
}

class DistanceLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double page = math.max(0, 4 * notifier.page - 3);
        print(page * 24);
        return Positioned(
          top: 164.0 + 400 + 32 + 16 + 32 + 40,
          width: MediaQuery.of(context).size.width,
          left: 0,
          child: Opacity(
            opacity: page,
            child: child,
          ),
        );
      },
      child: Text(
        '72 km',
        textAlign: TextAlign.center,
        style:
            TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: white),
      ),
    );
  }
}

class MapButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double opacity = math.max(0, 4 * notifier.page - 3);
        return Positioned(
            bottom: 3, left: 8, child: Opacity(opacity: opacity, child: child));
      },
      child: FlatButton(
        child: Text(
          'ON MAP',
          style: TextStyle(fontSize: 12),
        ),
        onPressed: () {},
      ),
    );
  }
}

class VultureCircle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double multiplier = math.max(0, 4 * notifier.page - 3) *
            MediaQuery.of(context).size.width /
            2;
        return Container(
          margin: EdgeInsets.only(bottom: 250),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: lightGrey,
          ),
          width: multiplier,
          height: multiplier,
        );
      },
    );
  }
}

class TravelDots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double page = math.max(0, 4 * notifier.page - 3);
        return Positioned(
          top: 164.0 + 400 + 32 + 16 + 32 + 4,
          right: 0,
          left: 0,
          child: Opacity(
            opacity: page,
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: page * 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: lightGrey),
                  ),
                  width: 4,
                  height: 4,
                ),
                Container(
                  margin: EdgeInsets.only(right: page * 10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: lightGrey),
                  ),
                  width: 4,
                  height: 4,
                ),
                Container(
                  margin: EdgeInsets.only(left: page * 40),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: white),
                  ),
                  width: 8,
                  height: 8,
                ),
                Container(
                  margin: EdgeInsets.only(right: page * 40),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: white),
                  ),
                  width: 8,
                  height: 8,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
