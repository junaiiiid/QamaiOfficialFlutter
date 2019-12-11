import 'package:flutter/material.dart';
import 'package:qamai_official/containers/modules/user_information.dart';


//COLORS
const Color QamaiThemeColor = Color(0xFF1D4354);
const Color BlackMaterial = Color(0xFF2E2F41);
const Color QamaiGreen = Color(0xFF00DD99);
const Color LightGray = Colors.grey;
const Color White = Colors.white;
const Color Red = Colors.red;
const Color VeryLightGray = Color(0xFFEFF0F1);

const Color NEWCOLOR = Color(0xFF062639);

//STRINGS
const String AppName='Qamai';
const String ForgotPassword='Forgot password ? tap here';
const String SignupText='New to Qamai? Sign Up';
const String Login='Log In';
const String Signup='Sign Up';
const String Email='Email';
const String Password='Password';
const String RPassword='Repeat Password';
const String FirstName='First Name';
const String LastName='Last Name';
const String CNIC='CNIC number';
const String TOS='By Signing Up you agree to Qamai\'s Terms of Service and Privacy Policy';
const String DOB='Date of Birth';
const String Phone='Phone Number';
const String FP1='Forgot your password?';
const String FP2='We\'ll send you instructions on how to change it. Please confirm your email,Tap Submit, and then check your mailbox for further instructions';
const String Submit='Submit';
const String Next='Next';


const String WarningDialogTitle= 'Invalid Enteries';
const String WarningDialogText= 'Invalid Information provided, Please fill in every box with correct Information to proceed.';

const String RegistrationSuccess='Registration Sucessful';
String PleaseLogin='An email has been sent to ${getEmail()}, Please vefiry email address then log in';

const String RegistrationFailed='Registration Failed';
const String LoginFailed='Login Failed';
const String IncorrectPass='Invalid Email or Password entered, Please try again';

const String VerifyEmailtitle='Email not verified';
const String VerifyEmailtext='Please Verify your email address to continue';

const String ResestPasstitle='Instructions Sent!';
String ResestPasstext='An Email has been sent to ${getRecoveryMail()} with instruction, on how to reset your password.';


const String Logouttitle='Log Out';
const String Logoutext='Are you sure you want to log out?';


const String UserInformation='UserInformation';
const String storytext='Your Story in one line?';

const String storytitle='Story';

const String cancel='Cancel';
const String update='Update';

const String dpfemale='https://firebasestorage.googleapis.com/v0/b/qamai-official-5cd60.appspot.com/o/ProfilePicture%2Fdpfemale.png?alt=media&token=9ebfdec5-c505-495f-958c-ea18a352a2e2';
const String dpmale='https://firebasestorage.googleapis.com/v0/b/qamai-official-5cd60.appspot.com/o/ProfilePicture%2Fdpmale.png?alt=media&token=94630c7e-e1f4-4b11-ae85-63f94c492e36';

const String WorkInformation = 'WorkInformation';
const String InternshipInformation = 'InternshipInformation';
const String ProposalsInformation = 'Proposals';

const String dpinternship = 'https://firebasestorage.googleapis.com/v0/b/qamai-official-5cd60.appspot.com/o/ProfilePicture%2Fdpinternship.png?alt=media&token=cdcfcb9d-e106-4744-a0e2-61fd123c968f';
const String dpwork = 'https://firebasestorage.googleapis.com/v0/b/qamai-official-5cd60.appspot.com/o/ProfilePicture%2Fdpwork.png?alt=media&token=8ee229d1-c8b6-4fc5-99fb-ee9a74b42546';