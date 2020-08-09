import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sy_expedition_travel_challenge/main_page.dart';
import 'package:sy_expedition_travel_challenge/styles.dart';

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

class LeopardImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<PageOffsetNotifier>(
      builder: (context, notifier, child) {
        double left = notifier.offset;
        return Positioned(
            width: MediaQuery.of(context).size.width * 1.6,
            left: 0.85 * -left,
            child: child);
      },
      child: IgnorePointer(child: Image.asset('assets/leopard.png')),
    );
  }
}
