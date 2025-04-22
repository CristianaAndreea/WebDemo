import 'package:flutter/material.dart';

class AdjustableToolbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextStyle? titleTextStyle;
  final Color backgroundColor;
  final List<Widget> actions;

  // Width at which the toolbar switches to a hamburger menu
  final double breakpoint;

  final Function(String)? onMenuItemSelected;

  const AdjustableToolbar({
    super.key,
    required this.title,
    this.titleTextStyle,
    this.backgroundColor = Colors.blueAccent,
    this.actions = const [],
    this.breakpoint = 500,
    this.onMenuItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      title: Text(
        title,
        style: titleTextStyle ?? const TextStyle(color: Colors.white),
      ),
      centerTitle: false,
      actions:
          screenWidth > breakpoint
              ? actions
              : [
                PopupMenuButton<String>(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  color: Colors.white, // Background color of the popup menu
                  itemBuilder:
                      (context) =>
                          actions.map((action) {
                            if (action is TextButton) {
                              final text = (action.child as Text).data ?? '';
                              return PopupMenuItem<String>(
                                value: text,
                                child: Text(
                                  text,
                                  style: const TextStyle(
                                    color: Colors.black, // Text color
                                    fontSize: 16, // Font size
                                  ),
                                ),
                              );
                            }
                            return const PopupMenuItem<String>(
                              value: '',
                              child: Text('Unknown Action'),
                            );
                          }).toList(),
                  onSelected: (value) {
                    if (onMenuItemSelected != null) {
                      onMenuItemSelected!(value);
                    }
                  },
                ),
              ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
