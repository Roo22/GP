import 'package:flutter/material.dart';
import 'package:graduation_project/models/user_model.dart';

class EditUserScreen extends StatefulWidget {
  final UserModel user;

  EditUserScreen({required this.user});

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _bodyTypeController = TextEditingController();
  TextEditingController _userTypeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.user.name ?? '';
    _emailController.text = widget.user.email ?? '';
    _phoneController.text = widget.user.phone ?? '';
    _locationController.text = widget.user.location ?? '';
    _bodyTypeController.text = widget.user.bodyType ?? '';
    _userTypeController.text = widget.user.userType ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _bodyTypeController.dispose();
    _userTypeController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      // Save changes to the user model or perform necessary operations
      UserModel updatedUser = UserModel(
        email: _emailController.text,
        name: _nameController.text,
        phone: _phoneController.text,
        uId: widget.user.uId,
        image: widget.user.image,
        cover: widget.user.cover,
        location: _locationController.text,
        lat: widget.user.lat,
        long: widget.user.long,
        bodyType: _bodyTypeController.text,
        userType: _userTypeController.text,
      );

      // TODO: Save the updated user model to your desired storage or database

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    // TODO: Add email validation logic if needed
                    return null;
                  },
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                  ),
                  validator: (value) {
                    // TODO: Add phone validation logic if needed
                    return null;
                  },
                ),
                TextFormField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    labelText: 'Location',
                  ),
                ),
                TextFormField(
                  controller: _bodyTypeController,
                  decoration: InputDecoration(
                    labelText: 'Body Type',
                  ),
                ),
                TextFormField(
                  controller: _userTypeController,
                  decoration: InputDecoration(
                    labelText: 'User Type',
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: _saveChanges,
                  child: Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
