import 'package:cloud_firestore/cloud_firestore.dart';

class StudentModel {
  final String? fullName,
      enrollmentNo,
      resume,
      email,
      profileImg,
      mobileNumber,
      heading,
      about,
      address,
      user,
      instituteName,
      course,
      branch,
      startYear,
      passingYear,
      percentage,
      backlogs,
      projectTitle,
      projectDescription,
      technologiesUsed,
      projStartDate,
      projEndDate,
      id,
      image,
      registeredOn;
  final FaceFeatures? faceFeatures;
  final List<Map<String, dynamic>>? applied, shortlisted, placed, offered;
  final bool? isFaceRegistered;
  final List? education, skills, projects;

  const StudentModel(
      {this.applied,
      this.shortlisted,
      this.placed,
      this.offered,
      this.projects,
      this.resume,
      this.profileImg,
      this.education,
      this.backlogs,
      this.heading,
      this.about,
      this.skills,
      this.address,
      this.user,
      this.id,
      this.image,
      this.faceFeatures,
      this.registeredOn,
      this.fullName,
      this.enrollmentNo,
      this.email,
      this.mobileNumber,
      this.instituteName,
      this.course,
      this.branch,
      this.percentage,
      this.startYear,
      this.passingYear,
      this.projectTitle,
      this.projectDescription,
      this.technologiesUsed,
      this.projStartDate,
      this.projEndDate,
      this.isFaceRegistered});

  factory StudentModel.studentFacesFromJson(Map<String, dynamic> json) {
    return StudentModel(
      id: json['Uid'] ?? ' ',
      fullName: json['Name'] ?? ' ',
      image: json['Image'] ?? ' ',
      faceFeatures: FaceFeatures.facesFromJson(json['Face Features']),
      registeredOn: json['Registered On'] ?? ' ',
    );
  }

  Map<String, dynamic> studentFacesToJson() {
    return {
      "Uid": id,
      "Name": fullName,
      "Image": image,
      "Registered On": registeredOn,
      "Face Features": faceFeatures?.facesToJson() ?? {},
    };
  }

  Map<String, dynamic> studentPersonalDetailsToJson() {
    return {
      "Name": fullName,
      "Email": email,
      "Mobile Number": mobileNumber,
      "Address": address,
      "Resume": resume,
    };
  }

  Map<String, dynamic> studentAboutToJson() {
    return {
      "Heading": heading,
      "About": about,
    };
  }

  Map<String, dynamic> studentEduToJson() {
    return {
      "Institute Name": instituteName,
      "Course": course,
      "Branch": branch,
      "Start Year": startYear,
      "Passing Year": passingYear,
      "Backlogs": backlogs,
      "Percentage": percentage,
    };
  }

  Map<String, dynamic> studentSkillsToJson() {
    return {
      "Skills": skills,
    };
  }

  Map<String, dynamic> studentProfImgToJson() {
    return {
      "Profile Image": profileImg,
    };
  }

  Map<String, dynamic> studentProjectToJson() {
    return {
      "Project Title": projectTitle,
      "Project Description": projectDescription,
      "Project Technologies": technologiesUsed,
      "Project Start Date": projStartDate,
      "Project End Date": projEndDate
    };
  }

  Map<String, dynamic> studentToJson() {
    return {
      "User": user,
      "Uid": id,
      "Name": fullName,
      "Profile Image": profileImg,
      "Enrollment Number": enrollmentNo,
      "Email": email,
      "Mobile Number": mobileNumber,
      "Institute Name": instituteName,
      "Course": course,
      "Branch": branch,
      "Passing Year": passingYear,
      "Heading": heading,
      "About": about,
      "Skills": skills,
      "Projects": projects,
      "Address": address,
      "Applied": applied,
      "Shortlisted": shortlisted,
      "Placed": placed,
      "Offered": offered,
      "isFaceRegistered": isFaceRegistered,
      "Backlogs": backlogs,
      "Education": education,
      "Resume": resume,
    };
  }

  factory StudentModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() != null) {
      final data = document.data();
      return StudentModel(
          user: data?['User'] ?? '',
          id: data?['Uid'] ?? '',
          fullName: data?['Name'] ?? '',
          enrollmentNo: data?['Enrollment Number'] ?? '',
          email: data?['Email'] ?? '',
          profileImg: data?['Profile Image'] ?? '',
          mobileNumber: data?['Mobile Number'] ?? '',
          instituteName: data?['Institute Name'] ?? '',
          course: data?['Course'] ?? '',
          branch: data?['Branch'] ?? '',
          passingYear: data?['Passing Year'] ?? '',
          heading: data?['Heading'] ?? '',
          about: data?['About'] ?? '',
          skills: data?['Skills'] ?? [],
          address: data?['Address'] ?? '',
          applied: data?['Applied'] ?? [],
          placed: data?['Placed'] ?? [],
          shortlisted: data?['Shortlisted'] ?? [],
          offered: data?['Offered'] ?? [],
          resume: data?['Resume'] ?? '',
          isFaceRegistered: data?['isFaceRegistered'] ?? false,
          education: data?['Education'] ?? [],
          projects: data?['Projects'] ?? []);
    } else {
      return StudentModel.empty();
    }
  }

  static StudentModel empty() => const StudentModel(
        user: '',
        id: '',
        fullName: '',
        enrollmentNo: '',
        email: '',
        profileImg: '',
        mobileNumber: '',
        instituteName: '',
        course: '',
        branch: '',
        passingYear: '',
        heading: '',
        about: '',
        skills: [],
        education: [],
        projects: [],
        address: '',
      );
}

class FaceFeatures {
  Points? rightEar;
  Points? leftEar;
  Points? rightEye;
  Points? leftEye;
  Points? rightCheek;
  Points? leftCheek;
  Points? rightMouth;
  Points? leftMouth;
  Points? noseBase;
  Points? bottomMouth;

  FaceFeatures({
    this.rightMouth,
    this.leftMouth,
    this.leftCheek,
    this.rightCheek,
    this.leftEye,
    this.rightEar,
    this.leftEar,
    this.rightEye,
    this.noseBase,
    this.bottomMouth,
  });

  factory FaceFeatures.facesFromJson(Map<String, dynamic> json) => FaceFeatures(
        rightMouth: Points.fromJson(json["rightMouth"]),
        leftMouth: Points.fromJson(json["leftMouth"]),
        leftCheek: Points.fromJson(json["leftCheek"]),
        rightCheek: Points.fromJson(json["rightCheek"]),
        leftEye: Points.fromJson(json["leftEye"]),
        rightEar: Points.fromJson(json["rightEar"]),
        leftEar: Points.fromJson(json["leftEar"]),
        rightEye: Points.fromJson(json["rightEye"]),
        noseBase: Points.fromJson(json["noseBase"]),
        bottomMouth: Points.fromJson(json["bottomMouth"]),
      );

  Map<String, dynamic> facesToJson() => {
        "rightMouth": rightMouth?.toJson() ?? {},
        "leftMouth": leftMouth?.toJson() ?? {},
        "leftCheek": leftCheek?.toJson() ?? {},
        "rightCheek": rightCheek?.toJson() ?? {},
        "leftEye": leftEye?.toJson() ?? {},
        "rightEar": rightEar?.toJson() ?? {},
        "leftEar": leftEar?.toJson() ?? {},
        "rightEye": rightEye?.toJson() ?? {},
        "noseBase": noseBase?.toJson() ?? {},
        "bottomMouth": bottomMouth?.toJson() ?? {},
      };
}

class Points {
  int? x;
  int? y;

  Points({
    required this.x,
    required this.y,
  });

  factory Points.fromJson(Map<String, dynamic> json) => Points(
        x: (json['x'] ?? 0) as int,
        y: (json['y'] ?? 0) as int,
      );

  Map<String, dynamic> toJson() => {'x': x, 'y': y};
}
