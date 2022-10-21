import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:calory/Utilities/deviceData.dart';
class meter extends StatefulWidget {
  String name = '';

  int max= 0;
 double width_of_device;
  int current_val = 0;
  meter({this.current_val=0,this.name='',this.max=0,this.width_of_device=0});
  @override
  _meterState createState() => _meterState();
}

class _meterState extends State<meter> {


  @override
  Widget build(BuildContext context) {
    return CustomPaint(
        painter: mypainter(val: widget.current_val,max_val: widget.max,device_width: widget.width_of_device),);
    //   ),
        // Container(
        //   height: 130,
        //   width: 130,
        //   color: Colors.orange,
        //   child: Column(
        //
        //   ),
    //     )
    //   ]
    // );
  }
}
class mypainter extends CustomPainter{
  int val = 0;
  int max_val = 0;
  double device_width;
  mypainter({this.val=0, this.max_val=0,this.device_width=0});
  @override
  void paint(Canvas canvas, Size size) {
    var centrex = size.width / 2;
    var centrey = size.height / 2;
    Offset centre = Offset(centrex, centrey);
    var radius  = (145/360)*device_width/2 ;
    Paint grey_line_brush =  Paint()
      ..color = Color(0xffCDCDCD)
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = (1-.949) * radius;
    // grey circle
    canvas.drawCircle(centre, radius, grey_line_brush);
    Paint gradient_meter = Paint()
      ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xffEC14FF),Color(0xff5E00F9),Color(0xff00BDF9),Color(0xff00F9F9)]).createShader(Rect.fromCircle(center: centre, radius: radius))
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = (1-.839) * radius;
    canvas.drawArc(Rect.fromCircle(center: centre, radius: radius), 1.5*pi, (val/max_val)*2*pi, false, gradient_meter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}