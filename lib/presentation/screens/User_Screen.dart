import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_firebase/core/generated/locale_keys.g.dart';
import 'package:flutter_application_firebase/presentation/themes/theme.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_firebase/presentation/bloc/bloc/auth_bloc.dart';
import 'package:flutter_application_firebase/presentation/bloc/bloc/auth_event.dart';
import 'package:flutter_application_firebase/presentation/screens/Card_Screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  String _name = '';
  String _phone = '';
  String _country = '';
  String _photoUrl = '';
  List<String> _stories = [];

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  _loadUserInfo() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userData = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      setState(() {
        _name = userData.data()?['name'] ?? '';
        _phone = userData.data()?['phone'] ?? '';
        _country = userData.data()?['country'] ?? '';
      });

      final prefs = await SharedPreferences.getInstance();
      _photoUrl = prefs.getString('photoUrl') ?? '';
      _stories = prefs.getStringList('stories') ?? [];
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('photoUrl', pickedFile.path);

      setState(() {
        _photoUrl = pickedFile.path;
      });
    }
  }

  Future<void> _addStory() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final prefs = await SharedPreferences.getInstance();
      _stories.add(pickedFile.path);
      await prefs.setStringList('stories', _stories);

      setState(() {
        _stories = List.from(_stories);
      });
    }
  }

  ImageProvider<Object> _getImage(String imageUrl) {
    if (imageUrl.isEmpty) {
      return AssetImage('assets/images/orta.png');
    }

    if (kIsWeb) {
      return NetworkImage(imageUrl);
    } else {
      return FileImage(File(imageUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.profile.tr()),
        backgroundColor: AppColors.primaryColor,
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CartScreen()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(SignOutRequested());
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _addStory,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/orta.png'),
                  ),
                ),
                Expanded(
                  child: _stories.isNotEmpty ? StoriesBar(stories: _stories, getImage: _getImage) : Container(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: _getImage(_photoUrl),
                ),
              ),
            ),
          ),
          _userInfoCard(LocaleKeys.name.tr(), _name, Icons.person),
          _userInfoCard(LocaleKeys.phone.tr(), _phone, Icons.phone),
          _userInfoCard(LocaleKeys.country.tr(), _country, Icons.flag),
        ],
      ),
    );
  }

  Widget _userInfoCard(String title, String value, IconData icon) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: AppColors.secondaryColor),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}

class StoriesBar extends StatelessWidget {
  final List<String> stories;
  final ImageProvider<Object> Function(String) getImage;

  StoriesBar({Key? key, required this.stories, required this.getImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => _showStory(context, stories[index]),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CircleAvatar(
                radius: 30,
                backgroundImage: getImage(stories[index]),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showStory(BuildContext context, String storyUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        Future.delayed(Duration(seconds: 5), () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop(true);
          }
        });
        return AlertDialog(
          content: Image(image: getImage(storyUrl)),
        );
      },
    );
  }
}