import 'package:flutter/material.dart';

class ReusableSlider extends StatefulWidget {
  final double minAmount;
  final double maxAmount;
  final String unit;
  final double currentValue;
  final Function(double) sliderOnChanged;
  const ReusableSlider({super.key, required this.minAmount, required this.maxAmount, required this.unit,required this.currentValue, required this.sliderOnChanged});

  @override
  State<ReusableSlider> createState() => _ReusableSliderState();
}

class _ReusableSliderState extends State<ReusableSlider> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                       Text(
                        '${widget.minAmount.toStringAsFixed(0)} ${widget.unit}',
                        style: const TextStyle(
                            fontSize: 10,
                            fontFamily: 'Bricolage-R',
                            color: Color(0xFF3C3C43)),
                      ),
                      Expanded(
                        child: Slider(
                          value: widget.currentValue,
                          min: widget.minAmount,
                          max: widget.maxAmount,
                          divisions: ((widget.maxAmount - widget.minAmount)/100).toInt(),
                          activeColor: const Color(0xffFF3997),
                          thumbColor: Colors.white,
                          label: '${widget.currentValue.toStringAsFixed(0)} ${widget.unit}',
                          onChanged: widget.sliderOnChanged,
                        ),
                      ),
                       Text(
                       '${widget.maxAmount.toStringAsFixed(0)} ${widget.unit}',
                        style: const TextStyle(
                            fontSize: 10,
                            fontFamily: 'Bricolage-R',
                            color: Color(0xFF3C3C43)),
                      ),
                    ],
                  ),
      ],
    );
  }
}
