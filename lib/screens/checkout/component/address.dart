import 'package:flutter/material.dart';
import 'package:techies_battle/app/constraint/user_permission.dart';
import 'package:techies_battle/data/remote_data_source/response/user_response.dart';
import 'package:techies_battle/model/export_model.dart';
import 'package:techies_battle/repository/remote_repository/export_remote_repo.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    return Card(
      // elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(9),
        child: Column(
          children: [
            Row(
              children: const [
                Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 22,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "My Location",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "$getCurrentLocation",
                style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            getUserPhone(),
          ],
        ),
      ),
    );
  }

  // getting User Phone Number
  FutureBuilder<UserProfileResponse?> getUserPhone() {
    return FutureBuilder<UserProfileResponse?>(
        future: UserRepository().getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User? userData = snapshot.data!.data!;
            return Row(
              children: [
                const Icon(
                  Icons.phone,
                  color: Colors.black,
                  size: 20,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  userData.phone!,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.black),
                ),
              ],
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }
}
