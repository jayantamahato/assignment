import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  final String name;
  final String email;
  final String uid;
  final Function fn;
  final bool isFollowed;
  const UserCard(
      {super.key,
      required this.name,
      required this.email,
      required this.uid,
      required this.fn,
      required this.isFollowed});

  @override
  Widget build(BuildContext context) {
    List<String> latter = name.split('');

    return ListTile(
      leading: CircleAvatar(
        child: Text(latter[0]),
      ),
      title: Text(name),
      subtitle: Text(
        email,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: SizedBox(
        height: 25,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          decoration: BoxDecoration(
              color: Colors.purple, borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            onTap: () {
              fn();
            },
            child: const Text(
              'Follow',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
