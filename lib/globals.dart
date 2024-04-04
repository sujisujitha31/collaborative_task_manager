import 'constant.dart' as c;

String userMail = "";
List collabUsers = [];

makeCollabPayloadGetRead(Map<String, String> data) {
  collabUsers.add(data);
  return {c.Constants.kListOfCollab: collabUsers};
}
