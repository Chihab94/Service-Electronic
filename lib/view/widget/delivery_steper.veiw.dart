import 'package:flutter/material.dart';

class DeliverySteperView extends StatefulWidget {
  final List<DeliveryStep> steps;
  final int currentStep;
  final Size size;
  final EdgeInsets margin, padding;

  const DeliverySteperView({
    super.key,
    this.margin = EdgeInsets.zero,
    this.padding = EdgeInsets.zero,
    required this.steps,
    required this.currentStep,
    required this.size,
  });

  @override
  State<DeliverySteperView> createState() => _DeliverySteperViewState();
}

class _DeliverySteperViewState extends State<DeliverySteperView> {
  bool isChangingStep = false;

  @override
  Widget build(BuildContext context) {
    int stepsCount = widget.steps.length;
    return Container(
      padding: widget.padding,
      margin: widget.margin,
      child: SizedBox(
        width: double.infinity,
        height: widget.size.height,
        child: Stack(
          children: [
            CustomPaint(
              size: widget.size,
              painter: DeliveryPathCustomPanter(
                stepsCount: stepsCount,
                currentStep: widget.currentStep,
              ),
            ),
            for (int index = 0; index <= widget.currentStep; index++) ...[
              if (index == widget.currentStep)
                Positioned(
                  width: 32,
                  height: 32,
                  left: 4.6,
                  top: widget.size.height / stepsCount * index + 5,
                  child: ElevatedButton(
                    onPressed:
                        isChangingStep || widget.steps[index].onNext == null
                            ? null
                            : () async {
                                setState(() => isChangingStep = true);
                                await widget.steps[index].onNext!();
                                setState(() => isChangingStep = false);
                              },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          widget.steps[index].onNext == null
                              ? Color.fromARGB(255, 74, 247, 146)
                              : Colors.red),
                      padding: MaterialStateProperty.all(EdgeInsets.zero),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    child: isChangingStep
                        ? SizedBox(
                            width: 15,
                            height: 15,
                            child: CircularProgressIndicator(
                              color: widget.steps[index].onNext == null
                                  ? Color.fromARGB(255, 130, 130, 130)
                                  : Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : widget.steps[index].iconChild ??
                            const Icon(
                              Icons.directions_car_outlined,
                              color: Color.fromARGB(255, 18, 18, 18),
                            ),
                  ),
                ),
              Positioned(
                left: widget.size.width / 2 + 20,
                top: widget.size.height / stepsCount * index + 15,
                child: Text(
                    '${widget.steps[index].name}: ${widget.steps[index].detail ?? '...'}'),
              )
            ]
          ],
        ),
      ),
    );
  }
}

class DeliveryPathCustomPanter extends CustomPainter {
  final int stepsCount, currentStep;
  DeliveryPathCustomPanter({
    required this.stepsCount,
    required this.currentStep,
  });

  void drawCircle(
    Canvas canvas,
    double centerX,
    double centerY,
    double radius,
    bool active,
  ) {
    Paint bigCirclePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    canvas.drawCircle(
      Offset(centerX, centerY - radius * 0.3),
      radius * 0.7,
      bigCirclePaint,
    );

    Paint strokeCirclePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0XFFF5A832);
    canvas.drawCircle(
      Offset(centerX, centerY - radius * 0.3),
      radius * 0.7,
      strokeCirclePaint,
    );

    Paint centerCirclePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = active ? const Color(0XFF115056) : const Color(0xFFD6D6D6);
    canvas.drawCircle(
      Offset(centerX, centerY - radius * 0.3),
      radius * 0.3,
      centerCirclePaint,
    );
  }

  void drawStepCircle(
    Canvas canvas,
    double centerX,
    double centerY,
    double radius,
    bool active,
  ) {
    Paint bigCirclePaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.white;
    canvas.drawCircle(
        Offset(centerX, centerY - radius * 0.3), radius * 0.7, bigCirclePaint);

    Paint strokeCirclePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = const Color(0XFFF5A832);
    canvas.drawCircle(Offset(centerX, centerY - radius * 0.3), radius * 0.7,
        strokeCirclePaint);

    IconData icon = Icons.location_on;
    TextPainter textPainter = TextPainter(textDirection: TextDirection.rtl);
    textPainter.text = TextSpan(
        text: String.fromCharCode(icon.codePoint),
        style: TextStyle(
          fontSize: radius * 0.9,
          fontFamily: icon.fontFamily,
          color: active ? const Color(0XFF115056) : const Color(0xFFD6D6D6),
        ));
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        centerX - (radius * 0.45),
        centerY - (radius * 0.45) - radius * 0.3,
      ),
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    double centerX = size.width / 2;
    double itemSize = size.height / stepsCount;
    double radiusY = (itemSize / 2);
    double radius = 20;
    // double radius = (itemSize / 2);
    // radius = radius <= 25
    //     ? radius
    //     : radius < 10
    //         ? 10
    //         : 25;

    Offset bgPathStart = Offset(centerX, (itemSize * 1) - radiusY);
    Offset bgPathEnd = Offset(centerX, (itemSize * stepsCount) - radiusY);

    Paint bgPathPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.35
      ..color = const Color(0xFFD6D6D6);
    canvas.drawLine(bgPathStart, bgPathEnd, bgPathPaint);

    Offset fgPathStart = Offset(centerX, (itemSize * 1) - radiusY);
    Offset fgPathEnd = Offset(
        centerX,
        (itemSize *
                (currentStep < stepsCount ? currentStep : (stepsCount - 1))) +
            radiusY);

    Paint fgPathPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = radius * 0.35
      ..color = const Color(0XFF115056);
    canvas.drawLine(fgPathStart, fgPathEnd, fgPathPaint);

    for (int index = 1; index <= stepsCount; index++) {
      index == 1 || index == stepsCount
          ? drawCircle(
              canvas,
              centerX,
              (itemSize * index) - radiusY,
              radius,
              index <= currentStep,
            )
          : drawStepCircle(
              canvas,
              centerX,
              (itemSize * index) - radiusY,
              radius,
              index <= currentStep,
            );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class DeliveryStep {
  String name;
  String? detail;
  Future Function()? onNext;
  Widget? iconChild;

  DeliveryStep(this.name, this.detail, this.onNext, {this.iconChild});

  static DeliveryStep loading(
    String name,
    String? detail,
    Future Function()? onNext,
  ) =>
      DeliveryStep(
        name,
        detail,
        onNext,
        iconChild: const SizedBox(
          width: 15,
          height: 15,
          child: CircularProgressIndicator(
            color: Color.fromARGB(255, 35, 111, 252),
            strokeWidth: 2,
          ),
        ),
      );
}
