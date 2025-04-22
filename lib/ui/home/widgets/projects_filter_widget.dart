import 'package:flutter/material.dart';

import '../../../theme/text_styles.dart';

class ProjectsFilterWidget extends StatefulWidget {
  final Size size;
  final List<String> filters;
  final Function(String) onFilterChanged;
  final VoidCallback onAddProjectClicked;

  const ProjectsFilterWidget({
    super.key,
    required this.size,
    required this.filters,
    required this.onFilterChanged,
    required this.onAddProjectClicked,
  });

  @override
  State<ProjectsFilterWidget> createState() => _ProjectsFilterWidgetState();
}

class _ProjectsFilterWidgetState extends State<ProjectsFilterWidget> {
  late String dropdownValue;

  @override
  void initState() {
    super.initState();
    dropdownValue = widget.filters.first;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: Container()),
        InkWell(
          onTap: () {
            widget.onAddProjectClicked();
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            child: Text(
              'Add'.toUpperCase(),
              style: WebTextStyles.bodyLargeBold.copyWith(
                color: Colors.blueAccent,
              ),
            ),
          ),
        ),
        const SizedBox(width: 20),
        Text(
          "Filter by",
          style: WebTextStyles.bodyLargeSemiBold.copyWith(color: Colors.grey),
        ),
        const SizedBox(width: 8),
        _buildDropDown(),
      ],
    );
  }

  Widget _buildDropDown() {
    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      style: WebTextStyles.bodyLargeRegular,
      underline: Container(height: 0),
      onChanged: (String? value) {
        setState(() {
          dropdownValue = value!;
        });
        widget.onFilterChanged(value!);
      },
      items:
          widget.filters.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value, style: WebTextStyles.bodyLargeRegular),
            );
          }).toList(),
    );
  }
}
