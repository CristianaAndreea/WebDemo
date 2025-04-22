import 'package:flutter/material.dart';
import 'package:web_demo/ui/map/widgets/web_map_widget.dart';

abstract class MapWidget extends StatefulWidget {
  factory MapWidget() => getMapWidget();
}