// Update Admin UIDS Using this method as number of Admin is Fixed and Admins are also Fixed !!!
const _adminUIDS = ["IK4BY8a94fR7OsiMIIj55WGPFCy1"];

bool isAdmin(String uid) {
  return _adminUIDS.contains(uid);
}
