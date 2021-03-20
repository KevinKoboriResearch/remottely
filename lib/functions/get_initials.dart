String getInitials(String bankAccountName) {
  List<String> names = bankAccountName.split(" ");
  String initials = "";
  int numWords = 1;

  if (numWords < names.length) {
    numWords = names.length;
  } else {
    return '';
  }
  for (var i = 0; i < numWords; i++) {
    initials += '${names[i][0]}';
  }
  return initials;
}
