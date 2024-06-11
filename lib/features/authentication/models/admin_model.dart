import 'package:cloud_firestore/cloud_firestore.dart';

class AdminModel {
  final String? id, user;
  final String? fullName, adminId, email, mobileNumber;
  final List? shortlists, offerLetters, placedList, resumes;
  final List<Map<String, dynamic>>? applied, shortlisted, placed, offered;

  const AdminModel({
    this.resumes,
    this.applied,
    this.shortlisted,
    this.placed,
    this.offered,
    this.shortlists,
    this.offerLetters,
    this.placedList,
    this.user,
    this.id,
    this.fullName,
    this.adminId,
    this.email,
    this.mobileNumber,
  });

  Map<String, dynamic> adminToJson() {
    return {
      "User": user,
      "Uid": id,
      "Name": fullName,
      "Admin Id": adminId,
      "Email": email,
      "Mobile Number": mobileNumber,
    };
  }

  Map<String, dynamic> adminDocsToJson() {
    return {
      "Short List": shortlists,
      "Placed List": placedList,
      "Offer Letters": offerLetters,
      "Resumes": resumes,
    };
  }

  factory AdminModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
      return AdminModel(
        user: data?['User'] ?? '',
        id: data?['Uid'] ?? '',
        fullName: data?['Name'] ?? '',
        adminId: data?['Admin Id'] ?? '',
        email: data?['Email'] ?? '',
        mobileNumber: data?['Mobile Number'] ?? '',
        applied: data?['Applied'] ?? [],
        placed: data?['Placed'] ?? [],
        shortlisted: data?['Shortlisted'] ?? [],
        offered: data?['Offered'] ?? [],
        shortlists: data?['Short List'] ?? [],
        placedList: data?['Placed List'] ?? [],
        offerLetters: data?['Offer Letters'] ?? [],
        resumes: data?['Resumes'] ?? [],
      );
    } else {
      return AdminModel.empty();
    }
  }

  static AdminModel empty() => const AdminModel(
      user: '',
      id: '',
      fullName: '',
      adminId: '',
      email: '',
      mobileNumber: '',
      shortlists: [],
      offerLetters: [],
      placedList: [],
      resumes: [],
      applied: [],
      shortlisted: [],
      placed: [],
      offered: []);
}
