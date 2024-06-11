import 'package:flutter/material.dart';
import 'curved_edges.dart';

class CSCurvedEdgeWidget extends StatelessWidget {
  const CSCurvedEdgeWidget({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CSCustomCurvedEdges(),
      child: child,
    );
  }
}
