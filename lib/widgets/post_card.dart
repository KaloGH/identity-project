import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:identity_project/models/user.dart' as model;
import 'package:identity_project/providers/user_provider.dart';
import 'package:identity_project/resources/firestore_methods.dart';
import 'package:identity_project/screens/comments_screen.dart';
import 'package:identity_project/utils/colors.dart';
import 'package:identity_project/utils/global_variables.dart';
import 'package:identity_project/utils/utils.dart';
import 'package:identity_project/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final snap;

  const PostCard({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  int commentLen = 0;
  bool isLikeAnimating = false;

  @override
  void initState() {
    super.initState();
    fetchCommentLen();
  }

  fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('comments')
          .get();
      commentLen = snap.docs.length;
    } catch (err) {
      showSnackBar(
        err.toString(),
        context,
        true,
      );
    }
    setState(() {});
  }

  deletePost(String postId) async {
    try {
      await FirestoreMethods().deletePost(postId);
    } catch (err) {
      showSnackBar(err.toString(), context, true);
    }
  }

  _openDetails(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CommentsScreen(
          postId: widget.snap['postId'].toString(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    final screenWidth = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      margin: EdgeInsets.only(
        top: 15,
        bottom: 15,
        left: screenWidth > webScreenSize ? screenWidth * 0.3 : 15,
        right: screenWidth > webScreenSize ? screenWidth * 0.3 : 15,
      ),
      elevation: 10,
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 8,
              horizontal: 15,
            ).copyWith(right: 0),
            child: Row(
              children: <Widget>[
                CircleAvatar(
                  radius: screenWidth > webScreenSize ? 25 : 18,
                  backgroundImage: NetworkImage(
                    widget.snap['profileImage'].toString(),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.snap['username'].toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth > webScreenSize ? 20 : 16,
                        ),
                      ),
                    ],
                  ),
                ),
                widget.snap['uid'].toString() == user.uid
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: IconButton(
                          onPressed: () {
                            showDialog(
                              useRootNavigator: false,
                              context: context,
                              builder: (context) {
                                return Dialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: SizedBox(
                                    width:
                                        screenWidth > webScreenSize ? 400 : 300,
                                    child: ListView(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        shrinkWrap: true,
                                        children: [
                                          'Delete',
                                        ]
                                            .map(
                                              (e) => InkWell(
                                                  child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 12,
                                                        horizontal: 16),
                                                    child: Text(e),
                                                  ),
                                                  onTap: () {
                                                    deletePost(
                                                      widget.snap['postId']
                                                          .toString(),
                                                    );
                                                    // remove the dialog box
                                                    Navigator.of(context).pop();
                                                  }),
                                            )
                                            .toList()),
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: pinkColor,
                          ),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          GestureDetector(
            onDoubleTap: () async {
              setState(() {
                isLikeAnimating = true;
              });
              await FirestoreMethods().likePost(
                widget.snap['postId'].toString(),
                user.uid,
                widget.snap['likes'],
              );
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                FadeInImage(
                  // En esta propiedad colocamos la imagen a descargar
                  image: NetworkImage(
                    widget.snap['postUrl'].toString(),
                  ),

                  // En esta propiedad colocamos el gif o imagen de carga
                  // debe estar almacenado localmente
                  placeholder: const AssetImage('assets/gif/loading.gif'),

                  // En esta propiedad colocamos mediante el objeto BoxFit
                  // la forma de acoplar la imagen en su contenedor
                  fit: BoxFit.cover,

                  // En esta propiedad colocamos el alto de nuestra imagen
                  height: screenWidth > webScreenSize
                      ? MediaQuery.of(context).size.height * 0.60
                      : MediaQuery.of(context).size.height * 0.35,
                  width: double.infinity,
                ),
                AnimatedOpacity(
                  duration: const Duration(milliseconds: 500),
                  opacity: isLikeAnimating ? 1.0 : 0.0,
                  child: LikeAnimation(
                    isAnimating: isLikeAnimating,
                    child: const Icon(
                      Icons.favorite,
                      color: pinkColor,
                      size: 100,
                    ),
                    duration: const Duration(
                      milliseconds: 500,
                    ),
                    onEnd: () {
                      setState(() {
                        isLikeAnimating = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: <Widget>[
              LikeAnimation(
                isAnimating: widget.snap['likes'].contains(user.uid),
                smallLike: true,
                child: IconButton(
                  icon: widget.snap['likes'].contains(user.uid)
                      ? const Icon(
                          Icons.favorite,
                          color: pinkColor,
                        )
                      : const Icon(
                          Icons.favorite_border,
                        ),
                  onPressed: () => FirestoreMethods().likePost(
                    widget.snap['postId'].toString(),
                    user.uid,
                    widget.snap['likes'],
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.comment_outlined,
                ),
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CommentsScreen(
                      postId: widget.snap['postId'].toString(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DefaultTextStyle(
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(fontWeight: FontWeight.w800),
                    child: Text(
                      '${widget.snap['likes'].length} likes',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.only(
                      top: 8,
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: const TextStyle(color: appWhiteColor),
                        children: [
                          TextSpan(
                            text: widget.snap['username'].toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, color: pinkColor),
                          ),
                          TextSpan(
                            text: ' ${widget.snap['caption']}',
                            style: const TextStyle(color: appBlackColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                      child: Container(
                        child: Text(
                          'View all $commentLen comments',
                          style: const TextStyle(
                            fontSize: 16,
                            color: appBlueColor,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 4),
                      ),
                      onTap: () {
                        _openDetails(context);
                      }),
                  Container(
                    child: Text(
                      DateFormat.yMMMd()
                          .format(widget.snap['datePublished'].toDate()),
                      style: const TextStyle(
                        color: appBlackColor,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
