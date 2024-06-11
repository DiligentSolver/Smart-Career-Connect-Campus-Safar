import 'package:cloud_firestore/cloud_firestore.dart';

class RecruiterModel {
  final String? fullName,
      recruiterId,
      email,
      mobileNumber,
      companyName,
      designation,
      location,
      website;
  final List? shortlists, offerLetters, placedList;
  final String? id, user, profileImg;
  final List<Map<String, dynamic>>? applied, shortlisted, placed, offered;

  const RecruiterModel(
      {this.applied,
      this.shortlisted,
      this.placed,
      this.offered,
      this.user,
      this.id,
      this.fullName,
      this.email,
      this.mobileNumber,
      this.recruiterId,
      this.companyName,
      this.designation,
      this.location,
      this.website,
      this.profileImg,
      this.shortlists,
      this.offerLetters,
      this.placedList});

  Map<String, dynamic> recruiterToJson() {
    return {
      "User": user,
      "Uid": id,
      "Name": fullName,
      "Recruiter Id": recruiterId,
      "Email": email,
      "Mobile Number": mobileNumber,
      "Company Name": companyName,
      "Designation": designation,
      "Location": location,
      "Website": website,
      "Profile Image": profileImg,
      "Applied Students": applied,
      "Shortlisted Students": shortlisted,
      "Placed Students": placed,
      "Offered Students": offered,
    };
  }

  Map<String, dynamic> recruiterDocsToJson() {
    return {
      "Short List": shortlists,
      "Placed List": placedList,
      "Offer Letters": offerLetters,
    };
  }

  factory RecruiterModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
      return RecruiterModel(
        user: data?['User'] ?? '',
        id: data?['Uid'] ?? '',
        fullName: data?['Name'] ?? '',
        recruiterId: data?['Recruiter Id'] ?? '',
        email: data?['Email'] ?? '',
        mobileNumber: data?['Mobile Number'] ?? '',
        companyName: data?['Company Name'] ?? '',
        designation: data?['Designation'] ?? '',
        location: data?['Location'] ?? '',
        website: data?['Website'] ?? '',
        profileImg: data?['Profile Image'] ?? '',
        applied: data?['Applied'] ?? [],
        placed: data?['Placed'] ?? [],
        shortlisted: data?['Shortlisted'] ?? [],
        offered: data?['Offered'] ?? [],
        shortlists: data?['Short List'] ?? [],
        placedList: data?['Placed List'] ?? [],
        offerLetters: data?['Offer Letters'] ?? [],
      );
    } else {
      return RecruiterModel.empty();
    }
  }

  static RecruiterModel empty() => const RecruiterModel(
      user: '',
      id: '',
      fullName: '',
      email: '',
      mobileNumber: '',
      recruiterId: '',
      companyName: '',
      designation: '',
      location: '',
      website: '',
      shortlists: [],
      offerLetters: [],
      placedList: [],
      profileImg: '',
      applied: [],
      shortlisted: [],
      placed: [],
      offered: []);
}
