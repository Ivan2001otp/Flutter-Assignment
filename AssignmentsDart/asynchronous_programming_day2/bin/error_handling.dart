void main() async {
  // print('error h');
  try {
    print(await getFullName(firstName: 'Immanuel', lastName: 'Robin'));
    print(await getFullName(firstName: '', lastName: 'Robin'));
  } on FirstOrLastNameBugIdentifiedException {
    print('First or last name is missing!');
  }
}

Future<String> getFullName(
    {required String firstName, required String lastName}) {
  if (firstName.isEmpty || lastName.isEmpty) {
    throw FirstOrLastNameBugIdentifiedException();
  } else {
    return Future.value('$firstName - $lastName');
  }
}

class FirstOrLastNameBugIdentifiedException implements Exception {
  const FirstOrLastNameBugIdentifiedException();
}
