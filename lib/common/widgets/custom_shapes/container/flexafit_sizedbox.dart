import 'package:flutter/cupertino.dart';

class Flexafit extends StatefulWidget {
  const Flexafit({super.key, this.child});

  final Widget? child;

  @override
  State<Flexafit> createState() => _FlexafitState();
}

class _FlexafitState extends State<Flexafit> {

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double width = size.width * 0.9;

    if(size.width>=450 && size.width <= 552){
      width = size.width * 0.8;
    }

    else if(size.width>=552 && size.width <= 600){
      width = size.width * 0.75;
    }else if(size.width>=600 && size.width <= 700){
      width = size.width * 0.7;
    }else if(size.width>=700 && size.width <= 800){
      width = size.width * 0.625;
    }else if(size.width>=800 && size.width <= 900){
      width = size.width * 0.52;
    }
else if(size.width>=900 && size.width <= 1000){
      width = size.width * 0.48;
    }
else if(size.width>=1000 && size.width <= 1100){
      width = size.width * 0.425;
    }
else if(size.width>=1100 && size.width <= 1200){
      width = size.width * 0.38;
    }
    else if(size.width>=1200 && size.width <= 1300){
      width = size.width * 0.35;
    }
    else if(size.width>=1300 && size.width <= 1700){
      width = size.width * 0.3;
    }
    else if(size.width>=1700 && size.width <= 1900){
      width = size.width * 0.25;
    }else if(size.width>=1900 && size.width <= 2100){
      width = size.width * 0.225;
    }else if(size.width>=2100){
      width = size.width * 0.2;
    }
    return SizedBox(
      width: width,
      child: widget.child,
    );
  }
}
