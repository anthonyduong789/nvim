# SolutionUnified Notes

## TODO other?

- [] make a way to retrieve data / s3 getObject

### MembersPage

- [x] work on the view with example data using the ones previsously used
- [x] routes link to the adding a new page
- [] pass in example data to work in the Member Details

### new membersPage

- make a route for a put request to the server to add a new member
- make a route for rendring the page

### Login credintials

- Login: 12341234
- ps: 123412341234

### Operation / scan view

- when you scan it will essential as a operator
- start with the operator page that will add hello

- example of making a lot of promises at once.

```typescript
let imageHash: { [key: string]: any } = {};

await Promise.all(
  items.map(async (member) => {
    if (member.ImageS3Key?.length != 0 && member.ImageS3Key) {
      console.log("key used", member.ImageS3Key);
      const result = await getImageBody(member.ImageS3Key);
      if (member.ImageS3Key) {
        imageHash[member.ImageS3Key] = result;
      }
    }
  }),
);
```

    // Important
    const { Password, LoginId, ConfirmPassword, ...rest } = member;


### Naming Standards

- make sure naming conventions are inline with whats correctly being used camelCase, PascalCase, kebab-case, snake_case, etc.
- make things more concise and readable
- check typos
- check ints
- good name for what the code is doing
- Enums used in a certain way appended with Types
- Minimal naming Conventions

### Match with specs

- check line by line if things are matching
-

### Edge Cases

- for every possible edge case, check if the code is handling it correctly
- think of all of possible edge cases in code

### Remove Unused Code

- comments need to be removed
-

### functioning code

- write tests to check if the code is functioning correctly
- outline what the code is supposed to do and check if it is doing that
- make sure test are passing after making any changes
