# Admin Page tasks

## fix Role Users change

- [] add in for Members / Sites to Select from
  > for this the training list will be
  > under Site Role.ts TrainingModules

# TODO

- add a manifest also to allow people to add pdf files
- [] add a way to make sure necessary fields are note empty
- [] remove console.log
- [] We need a route in members to query based on URL Params so that we can query
  users using site, department, lines, stations and then that result can be used in
  Line, Stations, Site, Department page.
- [] add necessary fields and making sure the User fills theses out
  > [!NOTE]
  > if not put will automatically have this inactive
  > dont't need to add Training List/ Modules

## UI

# DONE

siteRoles backend done for updating the Site
Roles

- delete fields
- delete site
- delete siteRoles
- delete department
- delete departmentRoles
- add the CheckBoxes for Sites and Departments Primary Site and Deparment

  - [x] add the CheckBoxes for Sites
  - [x] add the CheckBoxes for Departments

- clear the input after adding
  x. query to list all version of Site
  x. based on this you can then get the Site Role list from it
  x. Primary Site Role boolean
  x. Based on the Site use the list Departments on the Site

- [x] Reports to should only me the Members with Admin and Supervisor
- [x] loginid shouldn't need to be hashed
- [x] ensureAdmin hardware
- [x] empty fields when first making an entry
- [x] fix the MembercreatePage prop and admin inconsitency
- [x] fixed Edit Member Error when no Picture to submit
- [x] when adding an entry put request will automatically add certain fields
      fix Role Users change
      make a way to filter by Admin Users in my Dao

# NOTE

- bug with update Site? only on the first One isn't updating Update Phonienix Site
- Adding Ids to the Department list
- [] contain uncessary fields
- don't need to add fields that pertain to trainingj
<!--- someone else is handling this [] fix the test related to the Environment Server-->

### Save

// const sitePromises = sites.map(async (sites) => {
// const newRolesAdded: string[] = [];
// const OldSite = await siteDao.getCurrentActiveBySiteId(sites.Id);
// const oldSiteRoles = OldSite?.SiteRoles;
// let uniqueSiteRoles = new Set<string>(
// oldSiteRoles
// ?.map((role) => role?.Name)
// .filter((name): name is string => name !== undefined),
// );
// sites.SiteRoles?.map((role) => {
// if (role?.Name && !uniqueSiteRoles.has(role?.Name)) {
// newRolesAdded.push(role.Name);
// uniqueSiteRoles.add(role.Name);
// }
// });
// if (OldSite) {
// OldSite.SiteRoles = Array.from(uniqueSiteRoles).map((role) => {
// return { Name: role };
// });
//
// console.log("siteRoles-------", OldSite.SiteRoles);
// OldSite.CreationNote = "Updated Site Roles";
// OldSite.Author = (req.user as Member).EmployeeID;
// OldSite.TimeCreated = new Date().valueOf();
// console.log("Old Site Version", OldSite.Version);
// let newVersion = OldSite.Version + 1;
// console.log("New Version", newVersion);
// await siteDao.updateWithNewVersion(OldSite, newVersion).then((res) => {
// console.log("Site Updated");
// });
// }
// sites.Departments?.map(async (department) => {
// const OldDepartment = await departmentDao.getCurrentActiveByDepartmentId(
// department.Id,
// );
// const oldDepartmentRoles = OldDepartment?.DepartmentRoles;
// let uniqueDepartmentRoles = new Set<string>(
// oldDepartmentRoles
// ?.map((role) => role?.Name) // Extract `Name` from each role
// .filter((name): name is string => name !== undefined), // Filter out `undefined` values
// );
//
// department.DepartmentRoles?.map((role) => {
// if (role?.Name && !uniqueDepartmentRoles.has(role?.Name)) {
// newRolesAdded.push(role.Name);
// uniqueDepartmentRoles.add(role.Name);
// }
// });
// console.log("Unique Department Roles", uniqueDepartmentRoles);
// if (OldDepartment) {
// OldDepartment.DepartmentRoles = Array.from(uniqueDepartmentRoles).map(
// (role) => {
// return { Name: role };
// },
// );
// OldDepartment.CreationNote = "Updated Department Roles";
// OldDepartment.Author = (req.user as Member).EmployeeID;
// OldDepartment.TimeCreated = new Date().valueOf();
// const newVersion = OldDepartment.Version + 1;
// await departmentDao
// .updateWithNewVersion(OldDepartment, newVersion)
// .then(() => {
// console.trace("Department Updated");
// });
// }
//
// await siteRoledao.listBySiteId(sites.Id);
// newRolesAdded.map(async (value) => {
// const exist = await siteRoledao.listBySiteIdRoleName(sites.Id, value);
// if (exist.items.length !== 0) {
// console.log("has been made already exist");
// } else {
// const newSiteRole: SiteRole = {
// Author: (req.user as Member).EmployeeID,
// CreationNote: "New Role added",
// Version: 1,
// SUStatus: "ACTIVE",
// TimeCreated: 0,
// RoleId: uuidv4(),
// SiteId: sites.Id,
// RoleName: value,
// TrainingModules: [],
// TrainingItems: [],
// };
// await siteRoledao.put(newSiteRole).then(() => {
// console.log("New role was added");
// });
// }
// });
// });
// });
// await Promise.all(sitePromises);
