import 'constant.dart' as c;

String userMail = "";
List collabUsers = [];

storeCollaborators(List collabs) {
  collabUsers = collabs;
}

makeCollabPayloadGetRead(Map<String, String> data) {
  collabUsers.add(data);
  return {c.Constants.kListOfCollab: collabUsers};
}

setAuthDetails(String user) {
  userMail = user;
}
