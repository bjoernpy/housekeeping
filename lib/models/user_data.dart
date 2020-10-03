class UserData {
  String id;
  String firstName;
  String lastName;
  String email;
  String householdName;

  UserData(this.firstName, this.lastName, this.email);

  UserData.fromData(String id, Map<String, dynamic> data, String householdName) {
    this.id = id;
    this.firstName = data["firstName"];
    this.lastName = data["lastName"];
    this.email = data["email"];
    this.householdName = householdName;
  }
}
