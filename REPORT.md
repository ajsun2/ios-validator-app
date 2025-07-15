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
- (Not documented)

### Week 5 (4/29-5/5):
- (Not documented)

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
- Created address validation endpoint in webapp

### Week 10 (6/3-6/9):
- Implemented error message for org unique fields
- Reset error messages when new org type is selected, but retains previous field data
- Implemented address validation (mobile app calls web app endpoint)
- Note: Double check state id field requirements (format varies by state, should permit alphanumeric up to 12 chars (?) [https://help.fingercheck.com/en/articles/6865999-state-tax-jurisdictions-and-proper-formats] )
- Note: Missing format requirements:
  - **State department id** in munipical and state org
  - **Organization code** and **bureau name** in federal org
 
### Week 11 (6/10-6/16):
- Created requirements doc for form fields to ensure consistency across all platforms
- Implemented input limitations for all fields (ie. only accepting valid characters, up to max length) and auto formatting (for fein, ssn, phone)
- Final detail check to ensure instructions and feedback is thorough
- TODO: Update README to include app set up instructions

TODO: Ensure data is stored correctly in the shared database between all validator app platforms

###
