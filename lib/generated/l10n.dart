// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Request timed out. Please check your internet connection.`
  String get connectionTimeout {
    return Intl.message(
      'Request timed out. Please check your internet connection.',
      name: 'connectionTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Server error. Please try again later.`
  String get serverError {
    return Intl.message(
      'Server error. Please try again later.',
      name: 'serverError',
      desc: '',
      args: [],
    );
  }

  /// `Requested resource not found.`
  String get notFound {
    return Intl.message(
      'Requested resource not found.',
      name: 'notFound',
      desc: '',
      args: [],
    );
  }

  /// `Something went wrong. Please try again.`
  String get errorMessageGeneric {
    return Intl.message(
      'Something went wrong. Please try again.',
      name: 'errorMessageGeneric',
      desc: '',
      args: [],
    );
  }

  /// `Network error. Please check your connection.`
  String get networkError {
    return Intl.message(
      'Network error. Please check your connection.',
      name: 'networkError',
      desc: '',
      args: [],
    );
  }

  /// `Request timed out. Please try again.`
  String get requestTimeout {
    return Intl.message(
      'Request timed out. Please try again.',
      name: 'requestTimeout',
      desc: '',
      args: [],
    );
  }

  /// `Failed to save information securely. Please try again.`
  String get secureStorageErrorMessage {
    return Intl.message(
      'Failed to save information securely. Please try again.',
      name: 'secureStorageErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `No value found for key: `
  String get noValueKeyFound {
    return Intl.message(
      'No value found for key: ',
      name: 'noValueKeyFound',
      desc: '',
      args: [],
    );
  }

  /// `Service disabled`
  String get serviceDisabled {
    return Intl.message(
      'Service disabled',
      name: 'serviceDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Permission denied`
  String get permissionDenied {
    return Intl.message(
      'Permission denied',
      name: 'permissionDenied',
      desc: '',
      args: [],
    );
  }

  /// `Permission denied forever`
  String get permissionDeniedForever {
    return Intl.message(
      'Permission denied forever',
      name: 'permissionDeniedForever',
      desc: '',
      args: [],
    );
  }

  /// `Please confirm your password`
  String get confirmPassword {
    return Intl.message(
      'Please confirm your password',
      name: 'confirmPassword',
      desc: '',
      args: [],
    );
  }

  /// `Passwords do not match`
  String get paswordNotMatched {
    return Intl.message(
      'Passwords do not match',
      name: 'paswordNotMatched',
      desc: '',
      args: [],
    );
  }

  /// `Code is required`
  String get codeIsRequired {
    return Intl.message(
      'Code is required',
      name: 'codeIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Invalid code`
  String get invalidCode {
    return Intl.message(
      'Invalid code',
      name: 'invalidCode',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid Egyptian phone number`
  String get enterValidEgyptianPhoneNumber {
    return Intl.message(
      'Enter a valid Egyptian phone number',
      name: 'enterValidEgyptianPhoneNumber',
      desc: '',
      args: [],
    );
  }

  /// `Must be at least 3 characters`
  String get mustBeAtLeast3Characters {
    return Intl.message(
      'Must be at least 3 characters',
      name: 'mustBeAtLeast3Characters',
      desc: '',
      args: [],
    );
  }

  /// `Only letters allowed`
  String get onlyLettersAllowed {
    return Intl.message(
      'Only letters allowed',
      name: 'onlyLettersAllowed',
      desc: '',
      args: [],
    );
  }

  /// `Email is required`
  String get emailIsRequired {
    return Intl.message(
      'Email is required',
      name: 'emailIsRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid email address`
  String get enterValidEmail {
    return Intl.message(
      'Enter a valid email address',
      name: 'enterValidEmail',
      desc: '',
      args: [],
    );
  }

  /// `Password needs uppercase, digit, and special char`
  String get enterValidPassword {
    return Intl.message(
      'Password needs uppercase, digit, and special char',
      name: 'enterValidPassword',
      desc: '',
      args: [],
    );
  }

  /// `ID number is required`
  String get idNumberRequired {
    return Intl.message(
      'ID number is required',
      name: 'idNumberRequired',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid 14-digit ID number`
  String get invalidIdNumber {
    return Intl.message(
      'Enter a valid 14-digit ID number',
      name: 'invalidIdNumber',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error {
    return Intl.message(
      'Error',
      name: 'error',
      desc: '',
      args: [],
    );
  }

  /// `Oops! Something went wrong.`
  String get oopsSomthingWentWrong {
    return Intl.message(
      'Oops! Something went wrong.',
      name: 'oopsSomthingWentWrong',
      desc: '',
      args: [],
    );
  }

  /// `goToHome`
  String get goToHome {
    return Intl.message(
      'goToHome',
      name: 'goToHome',
      desc: '',
      args: [],
    );
  }

  /// `Fitness App`
  String get fitnessApp {
    return Intl.message(
      'Fitness App',
      name: 'fitnessApp',
      desc: '',
      args: [],
    );
  }

  /// `Loading...`
  String get loading {
    return Intl.message(
      'Loading...',
      name: 'loading',
      desc: '',
      args: [],
    );
  }

  /// `Your fitness journey starts here`
  String get your_fitness_journey_starts_here {
    return Intl.message(
      'Your fitness journey starts here',
      name: 'your_fitness_journey_starts_here',
      desc: '',
      args: [],
    );
  }

  /// `Version 1.0.0`
  String get VersionNumber {
    return Intl.message(
      'Version 1.0.0',
      name: 'VersionNumber',
      desc: '',
      args: [],
    );
  }

  /// `The Price Of Excellence\nIs Discipline`
  String get onboarding_title_1 {
    return Intl.message(
      'The Price Of Excellence\nIs Discipline',
      name: 'onboarding_title_1',
      desc: '',
      args: [],
    );
  }

  /// `Fitness Has Never Been\nSo Much Fun`
  String get onboarding_title_2 {
    return Intl.message(
      'Fitness Has Never Been\nSo Much Fun',
      name: 'onboarding_title_2',
      desc: '',
      args: [],
    );
  }

  /// `NO MORE EXCUSES\nDo It Now`
  String get onboarding_title_3 {
    return Intl.message(
      'NO MORE EXCUSES\nDo It Now',
      name: 'onboarding_title_3',
      desc: '',
      args: [],
    );
  }

  /// `Lorem Ipsum Dolor Sit Amet Consectetur. Eu Urna Ut Gravida Quis Id Pretium Purus. Mauris Massa`
  String get onboarding_description {
    return Intl.message(
      'Lorem Ipsum Dolor Sit Amet Consectetur. Eu Urna Ut Gravida Quis Id Pretium Purus. Mauris Massa',
      name: 'onboarding_description',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Hey There`
  String get heyThere {
    return Intl.message(
      'Hey There',
      name: 'heyThere',
      desc: '',
      args: [],
    );
  }

  /// `WELCOME BACK`
  String get welcomeBack {
    return Intl.message(
      'WELCOME BACK',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get password {
    return Intl.message(
      'Password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password ?`
  String get forgetPassword {
    return Intl.message(
      'Forget Password ?',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Remember me`
  String get rememberMe {
    return Intl.message(
      'Remember me',
      name: 'rememberMe',
      desc: '',
      args: [],
    );
  }

  /// `Or`
  String get or {
    return Intl.message(
      'Or',
      name: 'or',
      desc: '',
      args: [],
    );
  }

  /// `Dont Have An Account Yet ?`
  String get dontHaveAccountYet {
    return Intl.message(
      'Dont Have An Account Yet ?',
      name: 'dontHaveAccountYet',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get register {
    return Intl.message(
      'Register',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `CREATE AN ACCOUNT`
  String get createAnAccount {
    return Intl.message(
      'CREATE AN ACCOUNT',
      name: 'createAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `First Name`
  String get firstName {
    return Intl.message(
      'First Name',
      name: 'firstName',
      desc: '',
      args: [],
    );
  }

  /// `Last Name`
  String get lastName {
    return Intl.message(
      'Last Name',
      name: 'lastName',
      desc: '',
      args: [],
    );
  }

  /// `Already Have An Account ?`
  String get alreadyHaveAnAccount {
    return Intl.message(
      'Already Have An Account ?',
      name: 'alreadyHaveAnAccount',
      desc: '',
      args: [],
    );
  }

  /// `Step {current} of {total}`
  String onboardingStepIndicator(Object current, Object total) {
    return Intl.message(
      'Step $current of $total',
      name: 'onboardingStepIndicator',
      desc: '',
      args: [current, total],
    );
  }

  /// `Tell us about yourself`
  String get tellUsAboutYourself {
    return Intl.message(
      'Tell us about yourself',
      name: 'tellUsAboutYourself',
      desc: '',
      args: [],
    );
  }

  /// `We need to know your gender`
  String get weNeedToKnowYourGender {
    return Intl.message(
      'We need to know your gender',
      name: 'weNeedToKnowYourGender',
      desc: '',
      args: [],
    );
  }

  /// `Male`
  String get male {
    return Intl.message(
      'Male',
      name: 'male',
      desc: '',
      args: [],
    );
  }

  /// `Female`
  String get female {
    return Intl.message(
      'Female',
      name: 'female',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `How old are you?`
  String get howOldAreYou {
    return Intl.message(
      'How old are you?',
      name: 'howOldAreYou',
      desc: '',
      args: [],
    );
  }

  /// `This helps us create your personalized plan.`
  String get thisHelpsUsCreateYourPersonalizedPlan {
    return Intl.message(
      'This helps us create your personalized plan.',
      name: 'thisHelpsUsCreateYourPersonalizedPlan',
      desc: '',
      args: [],
    );
  }

  /// `year`
  String get year {
    return Intl.message(
      'year',
      name: 'year',
      desc: '',
      args: [],
    );
  }

  /// `cm`
  String get cm {
    return Intl.message(
      'cm',
      name: 'cm',
      desc: '',
      args: [],
    );
  }

  /// `What is your height?`
  String get whatIsYourHeight {
    return Intl.message(
      'What is your height?',
      name: 'whatIsYourHeight',
      desc: '',
      args: [],
    );
  }

  /// `What is your goal?`
  String get whatIsYourGoal {
    return Intl.message(
      'What is your goal?',
      name: 'whatIsYourGoal',
      desc: '',
      args: [],
    );
  }

  /// `Gain Weight`
  String get gainWeight {
    return Intl.message(
      'Gain Weight',
      name: 'gainWeight',
      desc: '',
      args: [],
    );
  }

  /// `Lose Weight`
  String get loseWeight {
    return Intl.message(
      'Lose Weight',
      name: 'loseWeight',
      desc: '',
      args: [],
    );
  }

  /// `Get Fitter`
  String get getFitter {
    return Intl.message(
      'Get Fitter',
      name: 'getFitter',
      desc: '',
      args: [],
    );
  }

  /// `Gain More Flexibility`
  String get gainMoreFlexible {
    return Intl.message(
      'Gain More Flexibility',
      name: 'gainMoreFlexible',
      desc: '',
      args: [],
    );
  }

  /// `Learn the Basics`
  String get learnTheBasics {
    return Intl.message(
      'Learn the Basics',
      name: 'learnTheBasics',
      desc: '',
      args: [],
    );
  }

  /// `conifrm password`
  String get confirmPasswordHint {
    return Intl.message(
      'conifrm password',
      name: 'confirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `What is your weight?`
  String get whatIsYourWeight {
    return Intl.message(
      'What is your weight?',
      name: 'whatIsYourWeight',
      desc: '',
      args: [],
    );
  }

  /// `kg`
  String get kg {
    return Intl.message(
      'kg',
      name: 'kg',
      desc: '',
      args: [],
    );
  }

  /// `What is your activity level?`
  String get whatIsYourActivityLevel {
    return Intl.message(
      'What is your activity level?',
      name: 'whatIsYourActivityLevel',
      desc: '',
      args: [],
    );
  }

  /// `Sedentary`
  String get sedentary {
    return Intl.message(
      'Sedentary',
      name: 'sedentary',
      desc: '',
      args: [],
    );
  }

  /// `Lightly Active`
  String get lightlyActive {
    return Intl.message(
      'Lightly Active',
      name: 'lightlyActive',
      desc: '',
      args: [],
    );
  }

  /// `Moderately Active`
  String get moderatelyActive {
    return Intl.message(
      'Moderately Active',
      name: 'moderatelyActive',
      desc: '',
      args: [],
    );
  }

  /// `Very Active`
  String get veryActive {
    return Intl.message(
      'Very Active',
      name: 'veryActive',
      desc: '',
      args: [],
    );
  }

  /// `Extra Active`
  String get extraActive {
    return Intl.message(
      'Extra Active',
      name: 'extraActive',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
