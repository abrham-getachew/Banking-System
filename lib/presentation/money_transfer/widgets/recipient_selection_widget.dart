import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RecipientSelectionWidget extends StatefulWidget {
  final List<Map<String, dynamic>> recentContacts;
  final Function(Map<String, dynamic>) onRecipientSelected;
  final Map<String, dynamic>? selectedRecipient;

  const RecipientSelectionWidget({
    super.key,
    required this.recentContacts,
    required this.onRecipientSelected,
    this.selectedRecipient,
  });

  @override
  State<RecipientSelectionWidget> createState() =>
      _RecipientSelectionWidgetState();
}

class _RecipientSelectionWidgetState extends State<RecipientSelectionWidget> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  bool _showAddNew = false;
  List<Map<String, dynamic>> _filteredContacts = [];

  @override
  void initState() {
    super.initState();
    _filteredContacts = widget.recentContacts;
  }

  @override
  void dispose() {
    _searchController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _filterContacts(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredContacts = widget.recentContacts;
      } else {
        _filteredContacts = widget.recentContacts.where((contact) {
          final name = (contact['name'] as String).toLowerCase();
          final email = (contact['email'] as String).toLowerCase();
          final phone = (contact['phone'] as String).toLowerCase();
          final searchQuery = query.toLowerCase();

          return name.contains(searchQuery) ||
              email.contains(searchQuery) ||
              phone.contains(searchQuery);
        }).toList();
      }
    });
  }

  void _addNewContact() {
    if (_nameController.text.isEmpty ||
        (_emailController.text.isEmpty && _phoneController.text.isEmpty)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please fill in name and at least one contact method'),
          backgroundColor: AppTheme.errorRed,
        ),
      );
      return;
    }

    final newContact = {
      "id": "new_${DateTime.now().millisecondsSinceEpoch}",
      "name": _nameController.text,
      "email": _emailController.text.isNotEmpty
          ? _emailController.text
          : "no-email@example.com",
      "phone": _phoneController.text.isNotEmpty
          ? _phoneController.text
          : "+1 (555) 000-0000",
      "avatar":
          "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      "isNewContact": true,
    };

    widget.onRecipientSelected(newContact);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Container(
            decoration: BoxDecoration(
              color: AppTheme.secondaryDark,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppTheme.borderGray,
                width: 1,
              ),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: _filterContacts,
              style: AppTheme.darkTheme.textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: 'Search contacts...',
                hintStyle: AppTheme.darkTheme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
                prefixIcon: Padding(
                  padding: EdgeInsets.all(3.w),
                  child: CustomIconWidget(
                    iconName: 'search',
                    color: AppTheme.textSecondary,
                    size: 5.w,
                  ),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 4.w,
                  vertical: 3.w,
                ),
              ),
            ),
          ),

          SizedBox(height: 3.h),

          if (!_showAddNew) ...[
            // Recent Contacts Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Contacts',
                  style: AppTheme.darkTheme.textTheme.titleMedium,
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showAddNew = true;
                    });
                  },
                  child: Text('Add New'),
                ),
              ],
            ),

            SizedBox(height: 2.h),

            // Recent Contacts List
            Expanded(
              child: _filteredContacts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomIconWidget(
                            iconName: 'person_search',
                            color: AppTheme.textSecondary,
                            size: 15.w,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            'No contacts found',
                            style: AppTheme.darkTheme.textTheme.bodyMedium
                                ?.copyWith(
                              color: AppTheme.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      itemCount: _filteredContacts.length,
                      itemBuilder: (context, index) {
                        final contact = _filteredContacts[index];
                        final isSelected =
                            widget.selectedRecipient?['id'] == contact['id'];

                        return Container(
                          margin: EdgeInsets.only(bottom: 2.h),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppTheme.accentGold.withValues(alpha: 0.1)
                                : AppTheme.secondaryDark,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: isSelected
                                  ? AppTheme.accentGold
                                  : AppTheme.borderGray,
                              width: isSelected ? 2 : 1,
                            ),
                          ),
                          child: ListTile(
                            contentPadding: EdgeInsets.all(3.w),
                            leading: CircleAvatar(
                              radius: 6.w,
                              backgroundColor:
                                  AppTheme.accentGold.withValues(alpha: 0.2),
                              child: ClipOval(
                                child: CustomImageWidget(
                                  imageUrl: contact['avatar'] as String,
                                  width: 12.w,
                                  height: 12.w,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            title: Text(
                              contact['name'] as String,
                              style: AppTheme.darkTheme.textTheme.titleMedium,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 0.5.h),
                                Text(
                                  contact['email'] as String,
                                  style: AppTheme.darkTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                                Text(
                                  contact['phone'] as String,
                                  style: AppTheme.darkTheme.textTheme.bodySmall
                                      ?.copyWith(
                                    color: AppTheme.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            trailing: isSelected
                                ? CustomIconWidget(
                                    iconName: 'check_circle',
                                    color: AppTheme.accentGold,
                                    size: 6.w,
                                  )
                                : CustomIconWidget(
                                    iconName: 'arrow_forward_ios',
                                    color: AppTheme.textSecondary,
                                    size: 4.w,
                                  ),
                            onTap: () => widget.onRecipientSelected(contact),
                          ),
                        );
                      },
                    ),
            ),
          ] else ...[
            // Add New Contact Form
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    setState(() {
                      _showAddNew = false;
                    });
                  },
                  icon: CustomIconWidget(
                    iconName: 'arrow_back',
                    color: AppTheme.textPrimary,
                    size: 6.w,
                  ),
                ),
                Text(
                  'Add New Contact',
                  style: AppTheme.darkTheme.textTheme.titleMedium,
                ),
              ],
            ),

            SizedBox(height: 3.h),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Name Field
                    TextField(
                      controller: _nameController,
                      style: AppTheme.darkTheme.textTheme.bodyMedium,
                      decoration: InputDecoration(
                        labelText: 'Full Name *',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(3.w),
                          child: CustomIconWidget(
                            iconName: 'person',
                            color: AppTheme.textSecondary,
                            size: 5.w,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 2.h),

                    // Email Field
                    TextField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      style: AppTheme.darkTheme.textTheme.bodyMedium,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(3.w),
                          child: CustomIconWidget(
                            iconName: 'email',
                            color: AppTheme.textSecondary,
                            size: 5.w,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 2.h),

                    // Phone Field
                    TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.phone,
                      style: AppTheme.darkTheme.textTheme.bodyMedium,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        prefixIcon: Padding(
                          padding: EdgeInsets.all(3.w),
                          child: CustomIconWidget(
                            iconName: 'phone',
                            color: AppTheme.textSecondary,
                            size: 5.w,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 4.h),

                    // Add Contact Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _addNewContact,
                        child: Text('Add Contact'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
