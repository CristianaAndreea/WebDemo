import 'package:flutter/material.dart';

class AddProjectItemWidget extends StatelessWidget {
  final VoidCallback onAddClick;

  const AddProjectItemWidget({
    super.key,
    required this.onAddClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onAddClick();
      },
      child: Container(
        // height: 360,
        // width: 360,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black12),
            borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.add_chart_outlined,
                color: Colors.red,
                size: 30.0,
              ),
              SizedBox(
                height: 8,
              ),
              Text("Add new"),
            ],
          ),
        ),
      ),
    );
  }
}
