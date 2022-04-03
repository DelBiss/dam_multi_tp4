import 'package:flutter/material.dart';

class BigButton extends StatelessWidget {
    final Widget child;
    final void Function()? onPressed;

    const BigButton({Key? key, required this.child, this.onPressed}):super(key: key);

    BigButton.icon(IconData icon, {Key? key, this.onPressed}):
        child = Icon(icon,size: 50,),
        super(key: key);

    BigButton.text(String text, {Key? key, this.onPressed}):
        child = Text(text, style: const TextStyle(fontSize: 60),),
        super(key: key);
    
    // const BigButton({ Key? key, this.icon, this.text }) : super(key: key);

    @override
    Widget build(BuildContext context) {
        return SizedBox.square(
            dimension: 100,
            child:ElevatedButton(
                child: child,
                onPressed: onPressed,
            ),
        );
    }
}