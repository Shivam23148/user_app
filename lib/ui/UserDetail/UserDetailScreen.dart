import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'package:user_app/data/models/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  UserDetailScreen({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "User Detail",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [IconButton(onPressed: sharePressed, icon: Icon(Icons.share))],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CircleAvatar(
              backgroundColor: Colors.grey.shade100,
              radius: MediaQuery.of(context).size.height * 0.1,
              child: Image.asset(
                "assets/user.png",
                height: MediaQuery.of(context).size.height * 0.15,
              ),
            ),
          ),
          Text(
            user.name ?? "",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                _buildInfoTile("UserName", user.username),
                _buildInfoTile("Email", user.email),
                _buildInfoTile("Contact", user.phone),
                _buildCompanyTile(user.company),
                _buildInfoTile("Website",
                    user.website != null ? "www.${user.website}" : ""),
                _buildAddressTile(user.address),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoTile(String title, String? subtitle) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
      title: Text(
        title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
      subtitle: Text(subtitle ?? ""),
    );
  }

  Widget _buildAddressTile(Address? address) {
    if (address == null) return const SizedBox.shrink();
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
      title: const Text(
        "Address",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Street: ${address.street ?? ''}"),
          Text("Suite: ${address.suite ?? ''}"),
          Text("City: ${address.city ?? ''}"),
          Text("Zipcode: ${address.zipcode ?? ''}"),
          Text(
              "Geo: Lat: ${address.geo?.lat ?? ''}, Lng: ${address.geo?.lng ?? ''}"),
        ],
      ),
    );
  }

  Widget _buildCompanyTile(Company? company) {
    if (company == null) return const SizedBox.shrink();
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4.0),
      title: const Text(
        "Company",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Name: ${company.name ?? ''}"),
          Text("CatchPhrase: ${company.catchPhrase ?? ''}"),
          Text("BS: ${company.bs ?? ''}"),
        ],
      ),
    );
  }

  void sharePressed() {
    final String userData = '''
  Name: ${user.name}
  Username: ${user.username}
  Email: ${user.email}
  Address: 
    Street: ${user.address?.street ?? ''}
    Suite: ${user.address?.suite ?? ''}
    City: ${user.address?.city ?? ''}
    Zipcode: ${user.address?.zipcode ?? ''}
    Geo: 
      Lat: ${user.address?.geo?.lat ?? ''}
      Lng: ${user.address?.geo?.lng ?? ''}
  Phone: ${user.phone}
  Website: ${user.website}
  Company: 
    Name: ${user.company?.name ?? ''}
    CatchPhrase: ${user.company?.catchPhrase ?? ''}
    BS: ${user.company?.bs ?? ''}
  ''';

    Share.share(userData);
  }
}
