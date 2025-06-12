import 'package:flutter/material.dart';
import 'package:timeline_tile/timeline_tile.dart';

Widget buildTimelineStep({
  required String title,
  required String subtitle,
  bool isFirst = false,
  bool isLast = false,
  bool isActive = false,
}) {
  final Gradient activeGradient = LinearGradient(
    colors: [Color(0xFF5785FF), Color(0xFF002A99)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  final Color inactiveColor = Colors.grey;

  return Expanded(
    child: TimelineTile(
      axis: TimelineAxis.horizontal,
      alignment: TimelineAlign.center,
      isFirst: isFirst,
      isLast: isLast,
      indicatorStyle: IndicatorStyle(
        width: 40,
        height: 40,
        indicator: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: isActive ? activeGradient : null,
            color: isActive ? null : inactiveColor,
          ),
          child: isActive
              ? const Icon(
            Icons.check,
            color: Colors.white,
            size: 18,
          ) : null,
        ),
      ),
      beforeLineStyle: LineStyle(
        color: isActive ? const Color(0xFF002A99) : inactiveColor,
        thickness: 2,
      ),
      afterLineStyle: LineStyle(
        color: isActive ? const Color(0xFF002A99) : inactiveColor,
        thickness: 2,
      ),
      endChild: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10), // لإبعاد النصوص عن الدائرة
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isActive ? const Color(0xFF002A99) : Colors.black,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 12,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis, // سيظهر ... عندما يتجاوز النص المساحة

          ),
        ],
      ),
    ),
  );
}
