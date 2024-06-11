import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyModel {
  const CompanyModel({
    this.companyName = "Google",
    required this.logo,
    required this.about,
    required this.campusDate,
    required this.headQuarter,
    required this.lastDate,
    required this.jobProfile,
    required this.industryType,
    required this.qualification,
    required this.salaryBenefits,
    required this.cutOff,
    required this.responsibilities,
    required this.skillsRequired,
    required this.probationPeriod,
    required this.serviceAgreement,
    required this.driveMode,
    required this.joiningLocation,
    required this.joiningPeriod,
    required this.selectionProcess,
    required this.otherConditions,
  });

  final String companyName;
  final String logo;
  final String campusDate;
  final String headQuarter;
  final String lastDate;
  final String jobProfile;
  final String industryType;
  final String qualification;
  final String salaryBenefits;
  final String cutOff;
  final String responsibilities;
  final String skillsRequired;
  final String probationPeriod;
  final String serviceAgreement;
  final String driveMode;
  final String joiningLocation;
  final String joiningPeriod;
  final String selectionProcess;
  final String otherConditions;
  final String about;

  static CompanyModel empty() => const CompanyModel(
        companyName: '',
        logo: '',
        campusDate: '',
        headQuarter: '',
        lastDate: '',
        jobProfile: '',
        industryType: '',
        qualification: '',
        salaryBenefits: '',
        cutOff: '',
        responsibilities: '',
        skillsRequired: '',
        probationPeriod: '',
        serviceAgreement: '',
        driveMode: '',
        joiningLocation: '',
        joiningPeriod: '',
        selectionProcess: '',
        otherConditions: '',
        about: '',
      );

  Map<String, dynamic> companyDetailsToJson() {
    return {
      'Company Name': companyName,
      'About': about,
      'Logo': logo,
      'Campus Date': campusDate,
      'Head Quarter': headQuarter,
      'Last Date': lastDate,
      'Job Profile': jobProfile,
      'Industry Type': industryType,
      'Qualification': qualification,
      'Salary Benefits': salaryBenefits,
      'Cut Off': cutOff,
      'Responsibilities': responsibilities,
      'Skills Required': skillsRequired,
      'Probation Period': probationPeriod,
      'Service Agreement': serviceAgreement,
      'Drive Mode': driveMode,
      'Joining Location': joiningLocation,
      'Joining Period': joiningPeriod,
      'Selection Process': selectionProcess,
      'Other Conditions': otherConditions,
    };
  }

  factory CompanyModel.fromSnapshot(
   Map<String, dynamic> document) {
    if (document.isNotEmpty) {
      final data = document;
      return CompanyModel(
          companyName: data['Company Name'] ?? '',
          logo: data['Logo'] ?? '',
          campusDate: data['Campus Date'] ?? '',
          headQuarter: data['Head Quarter'] ?? '',
          lastDate: data['Last Date'] ?? '',
          jobProfile: data['Job Profile'] ?? '',
          industryType: data['Industry Type'] ?? '',
          qualification: data['Qualification'] ?? '',
          salaryBenefits: data['Salary'] ?? '',
          cutOff: data['Cut Off'] ?? '',
          responsibilities: data['Responsibilities'] ?? '',
          skillsRequired: data['Skills'] ?? '',
          probationPeriod: data['Probation'] ?? '',
          serviceAgreement: data['Agreement'] ?? '',
          driveMode: data['Mode'] ?? '',
          joiningLocation: data['Job Location'] ?? '',
          joiningPeriod: data['Joining Period'] ?? '',
          selectionProcess: data['Selection Process'] ?? '',
          otherConditions: data['Other Conditions'] ?? '', about: data['About'] ?? '');
    } else {
      return CompanyModel.empty();
    }
  }
}
