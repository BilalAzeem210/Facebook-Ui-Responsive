import 'package:facebook_ui_resposive/config/palette.dart';
import 'package:facebook_ui_resposive/widgets/custom_tab_bar.dart';
import 'package:facebook_ui_resposive/widgets/user_card.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

import '../models/user_model.dart';
import 'circle_button.dart';

class CustomAppBar extends StatelessWidget {
  final User currentUser;
  final List<IconData> icon;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomAppBar({super.key, required this.currentUser, required this.icon, required this.selectedIndex, required this.onTap,});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 65.0,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black12, offset: Offset(0 , 2), blurRadius: 4.0)
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Expanded(
            child: Text('facebook',
            style: TextStyle(
              color: Palette.facebookBlue,
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -1.2
            ),
            ),
          ),
          Container(
            height: double.infinity,
            width: 550.0,
            child: CustomTabBar(icons: icon,selectedIndex: selectedIndex,onTap: onTap,
            isBottomIndicator: true),
          ),
          Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
               children: [
               UserCard(user: currentUser),
               const SizedBox(width: 12.0,),
               CircleButton(
                icon: Icons.search,
                iconSize: 25.0,
                onPressed: () => print('Search'),
              ),
                 CircleButton(
                   icon: MdiIcons.facebookMessenger,
                   iconSize: 25.0,
                   onPressed: () => print('Messanger'),
                 ),
            ],
          )),

        ],
      ),
    );
  }
}
