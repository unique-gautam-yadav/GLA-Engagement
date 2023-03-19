import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:validators/validators.dart' as validator;
import '../../../backend/auth.dart';
import '../../../backend/keywords.dart';
import '../../../backend/models.dart';

class SignUpWelcome extends StatefulWidget {
  const SignUpWelcome({super.key, required this.togglePages});

  final VoidCallback togglePages;
  @override
  State<SignUpWelcome> createState() => _SignUpWelcomeState();
}
class _SignUpWelcomeState extends State<SignUpWelcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 120),
          SizedBox(
              height: 250,
              child: SvgPicture.asset("assets/images/welcome.svg")),
          Text(
            "Welcome",
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontWeight: FontWeight.w100),
          ),
          // const Text(
          //   "Create account by getting started",
          //   style: TextStyle(fontSize: 16),
          // ),
          // const SizedBox(height: 85),
          const Expanded(child: SizedBox()),
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpPage(),
                    ));
              },
              child: const Text(
                "Get Started",
                style: TextStyle(color: Colors.white),
              )),
          const SizedBox(height: 4),
          const Text("or"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text("Have an account?"),
              InkWell(
                onTap: widget.togglePages,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Log in",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 75)
        ],
      ),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
    // required this.togglePages
  });

  // final VoidCallback togglePages;

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final accountFormKey = GlobalKey<FormState>();
  final personalFormKey = GlobalKey<FormState>();

  int stepIndex = 0;

  bool errorAt0 = false;
  bool errorAt1 = false;
  bool errorAt2 = false;

  bool processing = false;

  String? userType;
  TextEditingController mail = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController fullName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController id = TextEditingController();
  TextEditingController course = TextEditingController();
  TextEditingController branch = TextEditingController();
  TextEditingController sem = TextEditingController();
  TextEditingController admisionYear = TextEditingController();
  TextEditingController bio = TextEditingController();
  TextEditingController passoutYear = TextEditingController();
  TextEditingController company = TextEditingController();
  // String dropdownvalue = "please select sem";

  // // List of items in our dropdown menu
  // var items = [
  //   'sem 1',
  //   'sem 2',
  //   'sem 3',
  //   'sem 4',
  //   'sem 5',
  //   'sem 6',
  //   'sem 7',
  //   'sem 8',
  // ];

  switchToNextStep() async {
    setState(() {
      processing = true;
      errorAt0 = false;
      errorAt1 = false;
      errorAt2 = false;
    });
    if (stepIndex == 0) {
      if (accountFormKey.currentState!.validate()) {
        setState(() {
          stepIndex++;
        });
      } else {
        setState(() {
          errorAt0 = true;
        });
      }
    } else if (stepIndex == 1) {
      if (userType != null && userType!.isNotEmpty) {
        setState(() {
          stepIndex++;
        });
      } else {
        setState(() {
          errorAt1 = true;
        });
      }
    } else if (stepIndex == 2) {
      if (personalFormKey.currentState!.validate()) {
        Map<String, dynamic> profile = {};
        if (userType! == KeyWords.studentUser) {
          StudentModel data = StudentModel(
            addmissionYear: int.tryParse(admisionYear.text.toString()),
            branch: branch.text,
            course: course.text,
            desc: bio.text,
            mail: mail.text,
            name: fullName.text,
            phone: phone.text,
            sem: sem.text,
            // sem: dropdownvalue,
            unvRoll: id.text,
            type: userType,
          );
          profile = data.toMap();
        } else if (userType! == KeyWords.alumniUser) {
          AlumniModel data = AlumniModel(
            addmissionYear: int.tryParse(admisionYear.text.toString()),
            branch: branch.text,
            course: course.text,
            desc: bio.text,
            mail: mail.text,
            name: fullName.text,
            phone: phone.text,
            passoutYear: int.tryParse(passoutYear.text.toString()),
            unvRoll: id.text,
            type: userType,
          );
          profile = data.toMap();
        } else if (userType == KeyWords.teacherUser) {
          TeacherModel data = TeacherModel(
            branch: branch.text,
            course: course.text,
            desc: bio.text,
            mail: mail.text,
            name: fullName.text,
            phone: phone.text,
            type: userType,
            empID: id.text,
          );
          profile = data.toMap();
        }
        String msg = await Auth.createUser(profile, password.text);
        if (context.mounted) {
          if (msg == "email-already-in-use") {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              showCloseIcon: true,
              content: Text("This mail is already used"),
            ));
          } else if (msg == "weak-password") {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              showCloseIcon: true,
              content: Text("Weak password"),
            ));
          } else if (msg == "invalid-email") {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              showCloseIcon: true,
              content: Text("Invalid mail"),
            ));
          } else if (msg == "operation-not-allowed") {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              showCloseIcon: true,
              content: Text("We can't create account with this mail"),
            ));
          } else if (msg == "ok") {
            Navigator.pop(context);
          } else {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              showCloseIcon: true,
              content: Text("Some thing went wrong"),
            ));
          }
        }
        log(msg);
      } else {
        setState(() {
          errorAt2 = true;
        });
      }
    }
    setState(() {
      processing = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 5, left: 10, right: 10),
        child: Column(
          children: [
            // Container(
            //   height: 100,
            //   width: 100,
            //   decoration: BoxDecoration(
            //     gradient: LinearGradient(
            //         begin: Alignment.topLeft,
            //         end: Alignment.bottomRight,
            //         colors: [
            //           Colors.green.shade600,
            //           Colors.green.shade300,
            //         ]),
            //     borderRadius: BorderRadius.circular(25),
            //   ),
            //   child: const Center(
            //     child: Text(
            //       "Logo Here!!",
            //       style: TextStyle(color: Colors.white),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 35),
            Text("Registration", style: Theme.of(context).textTheme.titleLarge),
            // const SizedBox(height: 35),
            Expanded(
              child: Stepper(
                controlsBuilder: (context, details) {
                  return const SizedBox.shrink();
                },
                physics: const ClampingScrollPhysics(),
                type: StepperType.horizontal,
                currentStep: stepIndex,
                steps: [
                  Step(
                    title: Text(stepIndex == 0 ? "Account" : ""),
                    content: Form(
                      key: accountFormKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: mail,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is Required";
                              } else if (!validator.isEmail(value)) {
                                return "Please Enter Valid Mail";
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: "Enter Mail Address",
                              labelText: "Mail",
                              prefixIcon: const Icon(Icons.mail),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is Required";
                              } else if (value.length < 6) {
                                return "Password must have 6 chars atleast";
                              } else {
                                return null;
                              }
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "Enter password",
                                labelText: "Password",
                                prefixIcon: const Icon(Icons.lock),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "This field is Required";
                              } else if (password.text != value) {
                                return "Password didn't match Re-password";
                              } else {
                                return null;
                              }
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                                hintText: "Enter Password Again",
                                labelText: "Re-Password",
                                prefixIcon: const Icon(Icons.lock),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12))),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    isActive: true,
                    state: errorAt0
                        ? StepState.error
                        : stepIndex == 0
                            ? StepState.editing
                            : stepIndex > 0
                                ? StepState.complete
                                : StepState.indexed,
                  ),
                  Step(
                    title: Text(stepIndex == 1 ? "User Type" : ""),
                    content: Column(
                      children: [
                        SizedBox(
                          height: 212,
                          child: Stack(
                            children: [
                              Positioned(
                                top: 9.5,
                                left: 0,
                                right: 0,
                                child: Container(
                                  padding: const EdgeInsets.only(top: 8),
                                  height: 178,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: errorAt1
                                            ? Theme.of(context)
                                                .colorScheme
                                                .error
                                            : Theme.of(context)
                                                .iconTheme
                                                .color!),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    children: [
                                      RadioListTile(
                                        title: Text(
                                          "Student",
                                          style: TextStyle(
                                            color: errorAt1
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .error
                                                : null,
                                          ),
                                        ),
                                        value: KeyWords.studentUser,
                                        groupValue: userType,
                                        onChanged: (value) {
                                          FocusManager.instance.primaryFocus!
                                              .unfocus();
                                          setState(() {
                                            userType = value.toString();
                                          });
                                        },
                                      ),
                                      RadioListTile(
                                        title: Text(
                                          "Teacher",
                                          style: TextStyle(
                                            color: errorAt1
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .error
                                                : null,
                                          ),
                                        ),
                                        value: KeyWords.teacherUser,
                                        groupValue: userType,
                                        onChanged: (value) {
                                          FocusManager.instance.primaryFocus!
                                              .unfocus();
                                          setState(() {
                                            userType = value.toString();
                                          });
                                        },
                                      ),
                                      RadioListTile(
                                        title: Text(
                                          "Alumni",
                                          style: TextStyle(
                                            color: errorAt1
                                                ? Theme.of(context)
                                                    .colorScheme
                                                    .error
                                                : null,
                                          ),
                                        ),
                                        value: KeyWords.alumniUser,
                                        groupValue: userType,
                                        onChanged: (value) {
                                          FocusManager.instance.primaryFocus!
                                              .unfocus();
                                          setState(() {
                                            userType = value.toString();
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 0,
                                left: 10,
                                child: Container(
                                  padding:
                                      const EdgeInsets.only(left: 5, right: 5),
                                  color:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  child: Text(
                                    "You are a",
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: errorAt1
                                          ? Theme.of(context).colorScheme.error
                                          : null,
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Text(
                                  errorAt1 ? "This field is Required" : "",
                                  style: TextStyle(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    isActive: stepIndex >= 1,
                    state: errorAt1
                        ? StepState.error
                        : stepIndex == 1
                            ? StepState.editing
                            : stepIndex < 1
                                ? StepState.disabled
                                : StepState.complete,
                  ),
                  Step(
                    isActive: stepIndex == 2,
                    title: Text(stepIndex == 2 ? "Personal Details" : ""),
                    content: Form(
                      key: personalFormKey,
                      child: Column(
                        children: userType == null
                            ? []
                            : userType! == KeyWords.studentUser
                                ? [
                                    TextFormField(
                                      controller: fullName,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "This field is Required";
                                        } else {
                                          return null;
                                        }
                                      },
                                      decoration: InputDecoration(
                                        hintText: "Enter your Name",
                                        label: const RequiredLabel("Full Name"),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      controller: phone,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "This field is Required";
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        hintText: "Enter your Phone Number",
                                        label: const RequiredLabel("Phone"),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      controller: id,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return "This field is Required";
                                        } else if (value.length < 5) {
                                          return "Invalid Roll No";
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText:
                                            "Enter your University Roll No",
                                        label: const RequiredLabel("Roll No."),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      controller: course,
                                      decoration: InputDecoration(
                                        hintText: "Enter your course name",
                                        // labelText: "Course",
                                        label: RequiredLabel("course"),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      controller: branch,
                                      decoration: InputDecoration(
                                        hintText: "Enter your branch",
                                        // labelText: "Branch",
                                        label: const RequiredLabel("Branch"),

                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      controller: sem,
                                      keyboardType: TextInputType.number,
                                      decoration: InputDecoration(
                                        hintText: "Enter your semester",
                                        // labelText: "semester",
                                        label: RequiredLabel("Semester"),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                    // DropdownButton(
                                    //   hint: Text('select your semester'),
                                    //   // Initial Value
                                    //   value: dropdownvalue,
                                    //   icon:
                                    //       const Icon(Icons.keyboard_arrow_down),

                                    //   // Array list of items
                                    //   items: items.map((e) {
                                    //     return DropdownMenuItem(
                                    //       value: e,
                                    //       child: Text(e),
                                    //     );
                                    //   }).toList(),

                                    //   onChanged: (newValue) {
                                    //     setState(() {
                                    //       dropdownvalue = "$newValue";
                                    //     });
                                    //   },
                                    // ),
                                    const SizedBox(height: 15),
                                    TextFormField(
                                      controller: admisionYear,
                                      keyboardType: TextInputType.number,
                                      maxLength: 4,
                                      decoration: InputDecoration(
                                        hintText: "Enter your Admission year",
                                        // labelText: "Session",
                                        label: RequiredLabel("Session"),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    TextField(
                                      controller: bio,
                                      maxLength: 200,
                                      maxLines: 5,
                                      decoration: InputDecoration(
                                        hintText: "Enter Bio for your Account",
                                        label: const Align(
                                            alignment: Alignment.topLeft,
                                            child: Text("Bio")),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                      ),
                                    )
                                  ]
                                : userType == KeyWords.alumniUser
                                    ? [
                                        TextFormField(
                                          controller: fullName,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This field is required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            hintText: "Enter your name",
                                            label: const RequiredLabel(
                                                "Full Name"),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        TextFormField(
                                          controller: phone,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This field is required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            hintText: "Enter your Phone Number",
                                            label: const RequiredLabel("Phone"),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        TextFormField(
                                          controller: id,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This field is reuired";
                                            } else if (value.length < 5) {
                                              return "Invalid roll no";
                                            } else {
                                              return null;
                                            }
                                          },
                                          keyboardType: TextInputType.number,
                                          decoration: InputDecoration(
                                            hintText:
                                                "Enter your University Roll no",
                                            label:
                                                const RequiredLabel("Roll no."),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        TextFormField(
                                          controller: course,
                                          decoration: InputDecoration(
                                            hintText: "Enter your Course Name",
                                            labelText: "Course",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        TextFormField(
                                          controller: branch,
                                          decoration: InputDecoration(
                                            hintText: "Enter your Branch",
                                            labelText: "Branch",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        TextFormField(
                                          controller: admisionYear,
                                          keyboardType: TextInputType.number,
                                          maxLength: 4,
                                          decoration: InputDecoration(
                                            hintText:
                                                "Enter your Admission Year",
                                            labelText: "Admission Year",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        TextFormField(
                                          controller: passoutYear,
                                          keyboardType: TextInputType.number,
                                          maxLength: 4,
                                          decoration: InputDecoration(
                                            hintText: "Enter your Passout Year",
                                            labelText: "Passout Year",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        TextFormField(
                                          controller: company,
                                          // keyboardType: TextInputType.number,
                                          // maxLength: 4,
                                          decoration: InputDecoration(
                                            hintText: "Enter yourCompany Name",
                                            labelText: "Company",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        TextField(
                                          controller: bio,
                                          maxLength: 200,
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                            hintText:
                                                "Enter bio for your account",
                                            label: const Align(
                                                alignment: Alignment.topLeft,
                                                child: Text("Bio")),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        )
                                      ]
                                    : [
                                        TextFormField(
                                          controller: fullName,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This field is required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            hintText: "Enter your Name",
                                            label: const RequiredLabel(
                                                "Full Name"),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        TextFormField(
                                          controller: phone,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This field is required";
                                            } else {
                                              return null;
                                            }
                                          },
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            hintText: "Enter your phone number",
                                            label: const RequiredLabel("Phone"),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        TextFormField(
                                          controller: id,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return "This field is required";
                                            } else if (value.length < 5) {
                                              return "Invalid EMP ID";
                                            } else {
                                              return null;
                                            }
                                          },
                                          decoration: InputDecoration(
                                            hintText: "Enter your EMP ID",
                                            label:
                                                const RequiredLabel("EMP ID"),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        TextFormField(
                                          controller: course,
                                          decoration: InputDecoration(
                                            hintText: "Enter your Course Name",
                                            labelText: "Course",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        TextFormField(
                                          controller: branch,
                                          decoration: InputDecoration(
                                            hintText: "Enter your Branch",
                                            labelText: "Branch",
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        TextField(
                                          controller: bio,
                                          maxLength: 200,
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                            hintText:
                                                "Enter bio for your Account",
                                            label: const Align(
                                                alignment: Alignment.topLeft,
                                                child: Text("Bio")),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                            ),
                                          ),
                                        )
                                      ],
                      ),
                    ),
                    state: errorAt2
                        ? StepState.error
                        : stepIndex == 2
                            ? StepState.editing
                            : stepIndex > 2
                                ? StepState.complete
                                : StepState.indexed,
                  ),
                ],
              ),
            ),
            ButtonBar(
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Colors.green.shade100.withOpacity(.1)),
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(left: 15, right: 15))),
                    onPressed: stepIndex == 0
                        ? () {
                            Navigator.pop(context);
                          }
                        : () {
                            if (stepIndex > 0) {
                              setState(() {
                                errorAt0 = false;
                                errorAt1 = false;
                                errorAt2 = false;
                                stepIndex--;
                              });
                            }
                          },
                    child: Text("Back",
                        style: Theme.of(context).textTheme.bodyMedium)),
                ElevatedButton(
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(left: 15, right: 15))),
                    onPressed: !processing ? switchToNextStep : () {},
                    child: processing
                        ? const SpinKitFadingCircle(
                            color: Colors.white, size: 20)
                        : Text(stepIndex < 2 ? "Next" : "Submit",
                            style: const TextStyle(color: Colors.white))),
              ],
            )
            // const SizedBox(height: 50),
            // ElevatedButton(
            //     onPressed: () {
            //       navigateToNextStep();
            //     },
            //     child: const Text(
            //       "Sign Up",
            //       style: TextStyle(color: Colors.white),
            //     )),
            // const Text("or"),
            // InkWell(
            //   onTap: widget.togglePages,
            //   child: Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: RichText(
            //       text: TextSpan(
            //         text: "Hava an account?",
            //         style: const TextStyle(
            //           color: Colors.black,
            //           fontSize: 17,
            //           fontWeight: FontWeight.w400,
            //         ),
            //         children: [
            //           TextSpan(
            //               text: " Log in",
            //               style:
            //                   TextStyle(color: Theme.of(context).primaryColor))
            //         ],
            //       ),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    mail.dispose();
    phone.dispose();
    course.dispose();
    admisionYear.dispose();
    passoutYear.dispose();
    bio.dispose();
    id.dispose();
    sem.dispose();
    password.dispose();
    company.dispose();
    super.dispose();
  }
}

class RequiredLabel extends StatelessWidget {
  const RequiredLabel(
    this.lable, {
    super.key,
  });

  final String lable;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: lable,
        children: [
          TextSpan(
              text: " *",
              style: TextStyle(color: Theme.of(context).colorScheme.error))
        ],
      ),
    );
  }
}
