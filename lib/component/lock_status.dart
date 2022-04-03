import 'package:flutter/material.dart';

class ToogleWidget extends StatefulWidget {
  
  final Widget active;
  final Widget inactive;
  final Duration duration;
  final double startOpacity;
  final double transitionOpacity;
  const ToogleWidget({ Key? key, this.duration = const Duration(milliseconds: 300), this.startOpacity = 0.3, this.transitionOpacity = 1, required this.active,  required this.inactive }) : super(key: key);

  @override
  State<ToogleWidget> createState() => ToogleWidgetState();
}

class ToogleWidgetState extends State<ToogleWidget>{

  bool isTransitioning = false;
  late Widget current;
  
  @override
  void initState(){
    super.initState();
    current = widget.active;
  }

  IconData lock = Icons.lock;

  void showActive(){
    
      setState(() {
        current = widget.active;
        isTransitioning = true;
      });
    
  }
  void showInactive(){
      setState(() {
        current = widget.inactive;
        isTransitioning = true;
      });
    
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: isTransitioning ? widget.transitionOpacity : widget.startOpacity, 
      duration: widget.duration,
      child: current,
      onEnd: () => setState(() {
        isTransitioning = false;
      }),
    );
  }
}
