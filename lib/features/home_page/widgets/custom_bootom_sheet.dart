import 'package:flutter/material.dart';
import 'package:sist_hub/styles/styles.dart';

class CustomBottomSheet extends StatefulWidget {
  final Widget child;
  const CustomBottomSheet({
    super.key,
    required this.child,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  double _minHeight = 0.5;
  double _maxHeight = 0.9;
  double _currentPosition = 0.9;
  double _screenHeight = 0;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    _screenHeight = MediaQuery.of(context).size.height;
    _minHeight = _screenHeight *
        0.5; // 10% of the screen height, you can adjust this as needed.

    return SizedBox(
      width: double.infinity,
      child: GestureDetector(
        onVerticalDragStart: _onDragStart,
        onVerticalDragUpdate: _onDragUpdate,
        onVerticalDragEnd: _onDragEnd,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: _screenHeight * _currentPosition,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRRect(
                  borderRadius: AppSizes.border25,
                  child: Container(
                    height: 5,
                    width: 60,
                    color: AppColors.postBackgound,
                  ),
                ),
              ),
              Expanded(
                child: widget.child,
              ),
            ],
          ), // Replace with the content you want in the bottom sheet.
        ),
      ),
    );
  }

  void _onDragStart(DragStartDetails details) {
    _isDragging = true;
  }

  void _onDragUpdate(DragUpdateDetails details) {
    double newPosition = 0;
    if (_isDragging) {
      newPosition = 1 - details.globalPosition.dy / _screenHeight;
      // newPosition = newPosition.clamp(_minHeight / _screenHeight, _maxHeight);
    }

    setState(() {
      _currentPosition = newPosition;
    });
  }

  void _onDragEnd(DragEndDetails details) {
    _isDragging = false;
    // Check whether the bottom sheet should snap to the top or center based on its current position.
    if (_currentPosition > 0.7) {
      setState(() {
        _currentPosition = _maxHeight;
      });
    } else if (_currentPosition > 0.3) {
      setState(() {
        _currentPosition = _minHeight / _screenHeight;
      });
    } else {
      Navigator.of(context).pop();
    }
  }
}
