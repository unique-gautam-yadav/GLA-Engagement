import 'package:flutter/material.dart';

import '../../../backend/models.dart';

class StudentRegisterNextStep extends StatefulWidget {
  const StudentRegisterNextStep(
      {super.key, required this.model, required this.password});

  final Student model;
  final String password;

  @override
  State<StudentRegisterNextStep> createState() =>
      _StudentRegisterNextStepState();
}

class _StudentRegisterNextStepState extends State<StudentRegisterNextStep> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding:
            const EdgeInsets.only(left: 10, right: 10, top: 85, bottom: 85),
        child: Column(
          //
        ),
      ),
    );
  }
}
