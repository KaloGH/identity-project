import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:identity_project/models/user.dart' as model;
import 'package:identity_project/providers/user_provider.dart';
import 'package:identity_project/utils/colors.dart';
import 'package:identity_project/utils/global_variables.dart';
import 'package:identity_project/widgets/image_logo.dart';
import 'package:identity_project/widgets/loader.dart';
import 'package:identity_project/widgets/post_card.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FavouriteScreen extends StatefulWidget {
  const FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: appYellowColor,
      appBar: screenWidth > webScreenSize
          ? null
          : AppBar(
              backgroundColor: appYellowColor,
              centerTitle: true,
              title: ImageLogo(
                  height: 45, logoType: 'brandname', textColor: 'white'),
            ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .where('likes', arrayContains: user.uid)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Loader(width: 350, height: 350),
            );
          }

          if (snapshot.data!.docs.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (ctx, index) => Container(
                color: appYellowColor,
                margin: const EdgeInsets.symmetric(
                  horizontal: 0,
                  vertical: 0,
                ),
                child: PostCard(
                  snap: snapshot.data!.docs[index].data(),
                ),
              ),
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(child: Container(), flex: 0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'assets/json/no_favourite_images.json',
                      width: 300,
                      height: 300,
                      fit: BoxFit.fill,
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'There is no favourite posts',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
