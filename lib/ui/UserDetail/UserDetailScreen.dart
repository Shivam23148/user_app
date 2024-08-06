import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import 'package:user_app/data/models/user_model.dart';

class UserDetailScreen extends StatelessWidget {
  final User user;

  const UserDetailScreen({
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
        actions: [
          IconButton(onPressed: _shareUserData, icon: Icon(Icons.share))
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserAvatar(context),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: _buildUserName(),
          ),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              children: [
                _buildInfoTile("Username", user.username),
                _buildInfoTile("Email", user.email),
                _buildInfoTile("Contact", user.phone),
                _buildInfoTile("Website",
                    user.website != null ? "www.${user.website}" : ""),
                _buildAddressTile(user.address),
                _buildCompanyTile(user.company),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserAvatar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: CircleAvatar(
        backgroundColor: Colors.grey.shade100,
        radius: MediaQuery.of(context).size.height * 0.1,
        child: Image.asset(
          "assets/user.png",
          height: MediaQuery.of(context).size.height * 0.15,
        ),
      ),
    );
  }

  Widget _buildUserName() {
    return Text(
      user.name ?? "No Name",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
    );
  }

  Widget _buildInfoTile(String title, String? subtitle) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.black54,
        ),
      ),
      subtitle: Text(subtitle ?? "Not Available"),
    );
  }

  Widget _buildAddressTile(Address? address) {
    if (address == null) return SizedBox.shrink();
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
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
          Text("Street: ${address.street ?? 'Not Available'}"),
          Text("Suite: ${address.suite ?? 'Not Available'}"),
          Text("City: ${address.city ?? 'Not Available'}"),
          Text("Zipcode: ${address.zipcode ?? 'Not Available'}"),
          Text(
              "Geo: Lat: ${address.geo?.lat ?? 'Not Available'}, Lng: ${address.geo?.lng ?? 'Not Available'}"),
        ],
      ),
    );
  }

  Widget _buildCompanyTile(Company? company) {
    if (company == null) return SizedBox.shrink();
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8.0),
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
          Text("Name: ${company.name ?? 'Not Available'}"),
          Text("CatchPhrase: ${company.catchPhrase ?? 'Not Available'}"),
          Text("BS: ${company.bs ?? 'Not Available'}"),
        ],
      ),
    );
  }

  void _shareUserData() {
    final String userData = '''
Name: ${user.name ?? 'Not Available'}
Username: ${user.username ?? 'Not Available'}
Email: ${user.email ?? 'Not Available'}
Address: 
  Street: ${user.address?.street ?? 'Not Available'}
  Suite: ${user.address?.suite ?? 'Not Available'}
  City: ${user.address?.city ?? 'Not Available'}
  Zipcode: ${user.address?.zipcode ?? 'Not Available'}
  Geo: 
    Lat: ${user.address?.geo?.lat ?? 'Not Available'}
    Lng: ${user.address?.geo?.lng ?? 'Not Available'}
Phone: ${user.phone ?? 'Not Available'}
Website: ${user.website ?? 'Not Available'}
Company: 
  Name: ${user.company?.name ?? 'Not Available'}
  CatchPhrase: ${user.company?.catchPhrase ?? 'Not Available'}
  BS: ${user.company?.bs ?? 'Not Available'}
''';

    Share.share(userData);
  }
}
