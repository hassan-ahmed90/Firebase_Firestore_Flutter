import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final VoidCallback onpress;
  final bool loading;
  RoundButton({Key? key,required this.title,required this.onpress,this.loading=false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpress,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: loading ? CircularProgressIndicator(color: Colors.white,):Text(title,style: TextStyle(color: Colors.white),),),
      ),
    );
  }
}
