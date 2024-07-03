import 'package:facebook_ui_resposive/config/palette.dart';
import 'package:facebook_ui_resposive/widgets/profile_avatar.dart';
import 'package:facebook_ui_resposive/widgets/responsive.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/user_model.dart';

class Rooms extends StatelessWidget {
  final List<User> onlineUsers;
  Rooms({super.key, required this.onlineUsers});
  final ScrollController _firstController = ScrollController();


  @override
  Widget build(BuildContext context) {
    final bool isDesktop = Responsive.isDesktop(context);
    return Card(
        margin: EdgeInsets.symmetric(horizontal: isDesktop ? 5.0 : 0.0),
        elevation: isDesktop ? 1.0 : 0.0,
        shape: isDesktop ? RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)) : null,
        child: Container(
        height: 60.0,
        color: Colors.white,
        child: Scrollbar(
          controller: _firstController,
          thumbVisibility: true,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 5.0),
            child: ListView.builder(
              controller: _firstController,
                padding: const EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 4.0
                ),
                scrollDirection: Axis.horizontal,
                itemCount: 1 + onlineUsers.length,
                itemBuilder: (ctx,index){
                if(index == 0) {
                  return const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: _CreateRoomButton(),
                  );
                }
                final User user = onlineUsers[index -1];
                  return Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ProfileAvatar(
                    imageUrl: user.imageUrl,
                    isActive: true,
                  ),);
            }),
          ),
        ),
      ),
    );
  }
}

class _CreateRoomButton extends StatelessWidget {
  const _CreateRoomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        onPressed: (){
          if (kDebugMode) {
            print('CreateRoom');
          }
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          side: BorderSide(
            width: 3.0,
            color: Colors.blueAccent.shade100
          ),
        textStyle: const TextStyle(color: Palette.facebookBlue),
        ),

        child: const Row(

          children: [
            /*ShaderMask(
              shaderCallback: (rect){
                return Palette.createRoomGradient.createShader(rect);
              },
              child: const Icon(
                Icons.video_call,
                color: Colors.white,
                size: 35.0,
              ),
            ),*/
            Icon(
              Icons.video_call,
              color: Colors.purple,
              size: 35.0,
            ),
             SizedBox(width: 4.0,),
             Text('Create\nRoom'),
          ],
        ),
    );
  }
}
