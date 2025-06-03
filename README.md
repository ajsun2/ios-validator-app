# Validator App (ios) 

Built off Auth0 Swift Samples



## Progress report:

### Week 1 (4/1 - 4/7):
- Set up auth0 swift sample with personal tenant (kevin-chen-development)

### Week 2 (4/8-4/14):
- Built basic UI template for individual/organization sign-up

### Week 3 (4/15-4/21):
- Cleaned up app UI
- Finished building sign-up forms, with functional navigation
  - Organization sign-up form customized to each specialty 
- Manage user authorization (user must have admin role to fully sign in)

### Week 4 (4/22-4/28):
- 

### Week 5 (4/29-5/5):
- 

### Week 6 (5/6-5/12):
- Connected sign up forms to auth0, storing user metadata and creating their account

### Week 7 (5/13-5/19):
- Fixed and tested the metadata stored in auth0

### Week 8 (5/20-5/26):
- Redesigned form layout to include more instructions and feedback
- Removed admin dashboard support for mobile

### Week 9 (5/27-6/2):
- Applied consistent form design to both sign up pages (individual and orgnanization)
- Redirect user to main page after successful form submission
- TODO: Polish endpoint implementation for address validation (webapp) and test
- TODO: Check details to ensure instructions and feedback is thorough
- TODO: Update README to include app set up instructions
- TODO: Phone number validation?

###

Features TBB (to be built): 
- create local storage to track sign ups within the ios app --> unnecessary once kevin finishes his db implementation
- ~retrieve data to display in admin dashboard (individual and organization)~ admin dashboard has been removed
- integrate app with database that can be shared across all platforms (web app, android, ios)
