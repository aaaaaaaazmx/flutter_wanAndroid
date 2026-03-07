import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../util/screen_adapter_help.dart';

/// bannerWidget
class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key, required this.bannerListUrl});

  final List<String> bannerListUrl;

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  int _currentIndex = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CarouselSlider(
          carouselController: _controller,
          items: widget.bannerListUrl
              .map((url) => _getBannerWidget(url))
              .toList(),
          options: CarouselOptions(
            autoPlay: true,
            onPageChanged: (index, _) {
              return setState(() {
                _currentIndex = index;
              });
            },
          ),
        ),
        Positioned(
          child: _indicator(),
          bottom: 10.px,
          right: 0.px,
          left: 0.px,
        ),
      ],
    );
  }

  Widget _getBannerWidget(String url) {
    return GestureDetector(
      onTap: () {
        _jumpToHtml();
      },
      child: Image.network(url, fit: BoxFit.fill),
    );
  }

  /// 跳转到网页
  void _jumpToHtml() {
    print("CURRENINDEX: $_currentIndex");
  }

  Widget _indicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.bannerListUrl.asMap().entries.map((entry) {
        return GestureDetector(
          onTap: () {
            print("CURRENINDEX: ${entry.key}");
            _controller.animateToPage(entry.key);
          },
          child: Container(
            width: 8.px,
            height: 8.px,
            margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 4.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: (Colors.white).withAlpha(
                _currentIndex == entry.key ? 1000 : 100,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
