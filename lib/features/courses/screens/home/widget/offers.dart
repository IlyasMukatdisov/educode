import 'dart:async';

import 'package:educode/utils/constants.dart';
import 'package:flutter/material.dart';

class Offers extends StatefulWidget {
  const Offers({super.key});

  @override
  State<Offers> createState() => _OffersState();
}

class _OffersState extends State<Offers> {
  int _selectedPromo = 0;

  late Timer timer;
  late PageController _controller;

  final List<Image> widgetList = [
    Image.asset(
      "assets/images/offer/offer1.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/images/offer/offer2.png",
      fit: BoxFit.cover,
    ),
    Image.asset(
      "assets/images/offer/offer3.png",
      fit: BoxFit.cover,
    ),
  ];

  void startTimer() {
    timer = Timer.periodic(
      const Duration(seconds: 5),
      (timer) {
        if (_selectedPromo < widgetList.length - 1) {
          _controller.nextPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn);
        } else {
          _controller.animateTo(0,
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeIn);
        }
      },
    );
  }

  void stopTimer() {
    timer.cancel();
  }

  void restartTimer() {
    stopTimer();
    startTimer();
  }

  @override
  void initState() {
    _controller = PageController();
    startTimer();
    super.initState();
  }

  @override
  void dispose() {
    stopTimer();
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: restartTimer,
      onLongPressStart: (details) => stopTimer(),
      onLongPressEnd: (details) => startTimer(),
      child: Column(
        children: [
          SizedBox(
            height: 250,
            child: PageView.builder(
              controller: _controller,
              onPageChanged: (selectedPage) {
                restartTimer();
                setState(() {
                  _selectedPromo = selectedPage;
                });
              },
              itemCount: widgetList.length,
              itemBuilder: (context, index) {
                return widgetList[index];
              },
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widgetList.length; i++)
                  if (i == _selectedPromo) ...[createCircle(true)] else
                    createCircle(false)
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget createCircle(bool isSelected) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      height: 8,
      width: 8,
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: isSelected ? kPrimaryColor : Colors.grey),
    );
  }
}
