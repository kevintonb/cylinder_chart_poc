import 'package:flutter/material.dart';

class CylinderBarChart extends StatefulWidget {
  const CylinderBarChart({
    super.key,
  });

  @override
  State<CylinderBarChart> createState() => _CylinderBarChartState();
}

class _CylinderBarChartState extends State<CylinderBarChart> {
  @override
  Widget build(BuildContext context) {
    final List<DateTime> dates = [DateTime(2023, 10, 5)];
    final List<double> values = [17];

    // double maxValue = values.reduce((curr, next) => curr > next ? curr : next);
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                values[0].toString(),
              ),
              CylinderBar(
                value: values[0],
                maxValue: 20,
                mainColor: Colors.amber,
                accentColor: Colors.green,
              ),
              Text(
                "${dates[0].day}/${dates[0].month}",
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class EllipsePainter extends CustomPainter {
  final Color? color;

  EllipsePainter(this.color);
  @override
  void paint(
    Canvas canvas,
    Size size,
  ) {
    final paint = Paint()
      ..color = color ?? Colors.blue
      ..style = PaintingStyle.fill;

    // Calculate the center point of the canvas
    final center = Offset(size.width / 2, size.height / 2);

    // Calculate the radius of the ellipse
    final radiusX = size.width;
    final radiusY = size.height;

    // Create a path for the ellipse
    final path = Path()..addOval(Rect.fromCenter(center: center, width: radiusX, height: radiusY));

    // Draw the ellipse on the canvas
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}

class CylinderBar extends StatelessWidget {
  final double value, maxValue;
  final double height;
  final Color mainColor;
  final Color accentColor;

  const CylinderBar({
    super.key,
    this.height = 200,
    required this.value,
    required this.maxValue,
    required this.mainColor,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: "${value.toStringAsFixed(2)} / ${maxValue.toStringAsFixed(2)}",
      child: SizedBox(
        height: height,
        width: 50,
        child: Stack(
          children: [
            Positioned(
              top: 5,
              bottom: 5,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Colors.green,
                ),
                width: 50,
              ),
            ),
            Positioned(
              child: CustomPaint(
                painter: EllipsePainter(Colors.green),
                size: const Size(50, 20),
              ),
            ),
            Positioned(
              bottom: 0,
              child: CustomPaint(
                painter: EllipsePainter(const Color(0xffE5F1F)),
                size: const Size(50, 20),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                height: (value / maxValue) * height,
                child: Stack(
                  children: [
                    Positioned(
                      top: 5,
                      bottom: 5,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: mainColor,
                        ),
                        width: 50,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      child: CustomPaint(
                        painter: EllipsePainter(mainColor),
                        size: const Size(50, 20),
                      ),
                    ),
                    Positioned(
                      child: CustomPaint(
                        painter: EllipsePainter(accentColor),
                        size: const Size(50, 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
