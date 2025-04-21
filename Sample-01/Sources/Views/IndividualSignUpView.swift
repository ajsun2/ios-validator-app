import SwiftUI

struct IndividualSignUpView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var middleName = ""
    @State private var lastName = ""
    @State private var phone = ""
    @State private var ssn = ""
    @State private var birthday = Date()
    @State private var address = ""
    @State private var city = ""
    @State private var state = ""
    @State private var zipcode = ""

    var body: some View {
//        NavigationView {
            ZStack (alignment: .top){
                Color(.systemGray6)
                        .ignoresSafeArea()
                VStack {
                    Text("Individual Sign Up")
                        .padding(.top, 15)
//                        .padding(.bottom, 5)
                        .font(.title)
                    Form {
//                        Section(header: Text("")) {
                            TextField("Email", text: $email)
                                .textContentType(.emailAddress)
                                .autocorrectionDisabled()

                            SecureField("Password", text: $password)
                                .textContentType(.password)
                            TextField("First name", text: $firstName)
                                .textContentType(.givenName)

                            TextField("Middle name", text: $middleName)
                                .textContentType(.middleName)

                            TextField("Last name", text: $lastName)
                                .textContentType(.familyName)

                            TextField("Phone number", text: $phone)
                                .textContentType(.telephoneNumber)

                            TextField("SSN", text: $ssn)

                            DatePicker("Date of Birth", selection: $birthday, displayedComponents: .date)
                                .datePickerStyle(.compact)
                            TextField("Street Address", text: $address)
                                .textContentType(.streetAddressLine1)

                            TextField("City", text: $city)
                                .textContentType(.addressCity)

                            TextField("State", text: $state)
                                .textContentType(.addressState)

                            TextField("Zipcode", text: $zipcode)
                                .keyboardType(.numberPad)
                                .textContentType(.postalCode)
//                            }
                        }
                    HStack {
//                        NavigationLink(destination: MainView()) {
//                            Text("Homepage")
//                                .frame(width: 100)
////                                .padding()
////                                .frame(maxWidth: .infinity)
////                                .background(Color.gray)
////                                .foregroundColor(.white)
////                                .cornerRadius(8)
////                                .overlay(
////                                    RoundedRectangle(cornerRadius: 8)
////                                        .stroke(Color.gray, lineWidth: 1)
////                                )
//                        }
//                        .transition(.move(edge: .trailing))
                        Button("Homepage") {
                            dismiss()
                        }
                        .frame(width: 200)
                        Button(action: submit) {
                            Text("Submit")
//                                .padding()
                                .frame(maxWidth: 75)
//                                .frame(maxWidth: .infinity)
//                                .background(Color.blue)
//                                .foregroundColor(.white)
//                                .cornerRadius(8)
//                                .overlay(
//                                    RoundedRectangle(cornerRadius: 8)
//                                        .stroke(Color.blue, lineWidth: 1)
//                                )
                        }

                    }
                    .padding(.horizontal)
//                    .title("Individual Sign Up")
//                    .padding(.top, 10)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
//        .frame(maxHeight: .infinity, alignment: .top)
//    }
}

func submit() {
    print("Submit form...")
}

#Preview {
    IndividualSignUpView()
}
