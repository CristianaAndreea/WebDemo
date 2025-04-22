

class PhotoVoltaicSystem {
  final int id;
  final String brandName;
  final String systemType;
  final String systemDescription;
  final String modelName;
  final String systemPower;
  final String area;
  final String powerPeak;
  final String orientation;
  final String tiltAngle;
  final bool selected;

  PhotoVoltaicSystem({
    required this.id,
    required this.brandName,
    required this.systemType,
    required this.systemDescription,
    required this.modelName,
    required this.systemPower,
    required this.area,
    required this.powerPeak,
    required this.orientation,
    required this.tiltAngle,
    this.selected = false,
  });

  factory PhotoVoltaicSystem.fromMap(Map<String, dynamic> json) {
    return PhotoVoltaicSystem(
      id: json['id'],
      brandName: json['brand_name'],
      systemDescription: json['system_description'],
      systemType: json['system_type'],
      modelName: json['model_name'],
      systemPower: json['system_power'],
      tiltAngle: json['system_tilt'],
      orientation: json['system_orientation'],
      area: json['system_area'],
      powerPeak: json['system_power'],
    );
  }

  factory PhotoVoltaicSystem.offGrid() {
    return PhotoVoltaicSystem(
      id: 0,
      brandName: "JINGSUN",
      systemType: "Off Grid",
      systemDescription: "100KW Off Grid Solar System",
      modelName: "JS100K-OFF",
      systemPower: "100W",
      area: "458",
      powerPeak: "0",
      orientation: "N",
      tiltAngle: "45",
    );
  }

  factory PhotoVoltaicSystem.onGrid() {
    return PhotoVoltaicSystem(
      id: 1,
      brandName: "JINGSUN",
      systemType: "On Grid",
      systemDescription: "100KW On Grid Solar System",
      modelName: "JS100K-ON",
      systemPower: "100W",
      area: "540",
      powerPeak: "0",
      orientation: "N",
      tiltAngle: "45",
    );
  }

  factory PhotoVoltaicSystem.hybrid() {
    return PhotoVoltaicSystem(
      id: 2,
      brandName: "JINGSUN",
      systemType: "Hybrid",
      systemDescription: "100KW Hybrid Solar System",
      modelName: "JS100K-HY",
      systemPower: "100W",
      area: "1404",
      powerPeak: "0",
      orientation: "N",
      tiltAngle: "45",
    );
  }

  PhotoVoltaicSystem copyWith({
    bool? selected,
    String? tiltAngle,
    String? orientation,
    String? area,
    String? powerPeak,
  }) {
    return PhotoVoltaicSystem(
      id: id,
      brandName: brandName,
      systemType: systemType,
      systemDescription: systemDescription,
      modelName: modelName,
      systemPower: systemPower,
      area: area?? this.area,
      powerPeak: powerPeak?? this.powerPeak,
      orientation: orientation?? this.orientation,
      tiltAngle: tiltAngle?? this.tiltAngle,
      selected: selected ?? this.selected,
    );
  }

  Map<String, dynamic> toInsertMap() {
    final data = <String, dynamic>{};
    data['brand_name'] = brandName;
    data['system_type'] = systemType;
    data['system_description'] = systemDescription;
    data['model_name'] = modelName;
    data['system_power'] = systemPower;
    data['system_orientation'] = orientation;
    data['system_tilt'] = tiltAngle;
    data['system_area'] = area;
    return data;
  }

  Map<String, dynamic> toUpdateMap() {
    final data = <String, dynamic>{};
    data['brand_name'] = brandName;
    data['system_type'] = systemType;
    data['system_description'] = systemDescription;
    data['model_name'] = modelName;
    data['system_power'] = systemPower;
    data['system_orientation'] = orientation;
    data['system_tilt'] = tiltAngle;
    data['system_area'] = area;
    return data;
  }
}
