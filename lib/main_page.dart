import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
            ],
          ),
        ),
      ),
    );
  }
}

class LeopardImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double left = notifier.offset;
        print(left);
        return Positioned(
            width: MediaQuery.of(context).size.width * 1.6,
            left: 0.85 * -left,
            child: child);
      },
      child: IgnorePointer(child: Image.asset('assets/leopard.png')),
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
        print(left);
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

class LeopardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 165,
        ),
        The72Number(),
        SizedBox(
          height: 32,
        ),
        TravelDescriptionLabel(),
        SizedBox(
          height: 32,
        ),
        LeopardDescription(),
      ],
    );
  }
}

class TravelDescriptionLabel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) => Opacity(
        child: child,
        opacity: math.max(0, 1 - 4 * notifier.page),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 32),
        child: Text(
          'Travel description',
          style: TextStyle(fontSize: 18),
        ),
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

class LeopardDescription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) => Opacity(
        child: child,
        opacity: math.max(0, 1 - 4 * notifier.page),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Text(
          'The leopard (Panthera pardus) is one of the five extant species in the genus Panthera, a member of the Felidae.',
          style: TextStyle(fontSize: 15, color: lightGrey),
        ),
      ),
    );
  }
}

class The72Number extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) => Transform.translate(
        offset: Offset(-32 - 0.5 * notifier.offset, 0),
        child: child,
      ),
      child: RotatedBox(
        quarterTurns: 1,
        child: SizedBox(
          width: 400,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Text(
              '72',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
    return Image.asset('assets/leopard.png');
  }
}

class VulturePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
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
