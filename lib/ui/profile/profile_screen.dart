import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_demo/ui/common/web_alert_dialog.dart';
import 'package:web_demo/theme/text_styles.dart';

import '../../routes/routes.dart';
import '../common/general_button_widget.dart';
import 'bloc/profile.dart';
import 'widgets/user_details_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late ProfileBloc _profileBloc;

  @override
  void initState() {
    super.initState();
    _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.add(const ProfileEventGetDetails());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileBloc, ProfileState>(
      listener: (context, state) {
        _handleProfileState(state);
      },
      builder: (context, state) {
        var userName = state is ProfileStateLoadDetails ? state.userName : '';
        var email = state is ProfileStateLoadDetails ? state.email : '';
        var password =
            state is ProfileStateLoadDetails ? state.password ?? '' : '';

        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  UserDetailsWidget(
                    userName: userName,
                    email: email,
                    password: password,
                  ),
                  const SizedBox(height: 40),
                  Container(
                    height: 2,
                    color: Colors.black12,
                    width: double.infinity,
                  ),
                  const SizedBox(height: 40),
                  Text(
                    'Account Details',
                    style: WebTextStyles.bodyXLargeSemiBold,
                  ),
                  const SizedBox(height: 40),
                  Wrap(
                    spacing: 40,
                    runSpacing: 20,
                    children: [
                      GeneralButtonWidget(
                        text: "Delete Account",
                        onPressed: () {
                          _showDeleteAccountDialog();
                        },
                        backgroundColor: WidgetStateProperty.all(Colors.red),
                      ),
                      const SizedBox(width: 40),
                      GeneralButtonWidget(
                        text: "Logout",
                        onPressed: () {
                          _showLogoutDialog();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future _showDeleteAccountDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return WebAlertDialog(
          title: 'Delete account',
          content: 'Are you sure you want to delete your account?',
          confirmText: 'Yes',
          onConfirm: () {
            // redirect to login page
            _profileBloc.add(const ProfileEventDelete());
            Navigator.of(context).pop();
          },
          cancelText: 'No',
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  Future _showLogoutDialog() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return WebAlertDialog(
          title: 'Logout',
          content: 'Are you sure you want to logout?',
          confirmText: 'Yes',
          onConfirm: () {
            // redirect to login page
            _profileBloc.add(const ProfileEventLogout());
            Navigator.of(context).pop();
          },
          cancelText: 'No',
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _showSnackBar(String message, Color color) {
    final snackBar = SnackBar(content: Text(message), backgroundColor: color);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _handleProfileState(ProfileState state) {
    switch (state) {
      case ProfileStateLoggedOut():
        _handleLoggedOutState(state);
        break;
      case ProfileStateAccountDelete():
        _handleAccountDeleteState(state);
        break;
      case ProfileStateLoadDetails():
        _handleLoadDetailsState(state);
        break;
      default:
        break;
    }
  }

  void _handleLoggedOutState(ProfileStateLoggedOut state) {
    navKey.currentState?.pushNamedAndRemoveUntil(
      routeLogin,
      (Route<dynamic> route) => false,
    );
  }

  void _handleAccountDeleteState(ProfileStateAccountDelete state) {
    if (state.isDeleted) {
      navKey.currentState?.pushNamedAndRemoveUntil(
        routeLogin,
            (Route<dynamic> route) => false,
      );
    } else {
      _showSnackBar('Error deleting account', Colors.red);
    }
  }

  void _handleLoadDetailsState(ProfileStateLoadDetails state) {
    if (state.isError) {
      _showSnackBar('Error loading account details', Colors.red);
    } else if (state.savedDetails) {
      _showSnackBar('Saved account details', Colors.green);
    }
  }
}
