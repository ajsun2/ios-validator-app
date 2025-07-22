import SwiftUI

struct IndividualSignUpView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var email = ""
    @State private var password = ""
    @State private var firstName = ""
    @State private var middleName = ""
    @State private var lastName = ""
    @State private var specialAuth: String? = nil
    @State private var phone = ""
    @State private var ssn = ""
    @State private var birthday = Date()
    @State private var address = ""
    @State private var city = ""
    @State private var internalState: String = ""
    @State private var state: String? = nil
    
    let states = [
            "AL", "AK", "AZ", "AR", "CA", "CO", "CT", "DE", "FL", "GA",
            "HI", "ID", "IL", "IN", "IA", "KS", "KY", "LA", "ME", "MD",
            "MA", "MI", "MN", "MS", "MO", "MT", "NE", "NV", "NH", "NJ",
            "NM", "NY", "NC", "ND", "OH", "OK", "OR", "PA", "RI", "SC",
            "SD", "TN", "TX", "UT", "VT", "VA", "WA", "WV", "WI", "WY"
        ]
    
    let specialties = ["Healthcare", "Government", "Commerical"]
    
    @State private var zipcode = ""

    @State private var emailError: String?
    @State private var passwordError: String?
    @State private var firstNameError: String?
    @State private var lastNameError: String?
    @State private var specialAuthError: String?
    @State private var addressError: String?
    @State private var cityError: String?
    @State private var stateError: String?
    @State private var zipError: String?
    @State private var phoneError: String?
    @State private var ssnError: String?

    @State private var validationError: String?
    @State private var showSuccessScreen = false

    var body: some View {
        if showSuccessScreen {
            SignupSuccessView().onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    dismiss()
                }
            }
        } else {
            ZStack(alignment: .top) {
                Color(.systemGray6).ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Individual Sign Up")
                            .font(.title)
                            .padding(.top, 15)
                        Group {
                            labeledField(label: "Email", isRequired: true) {
                                TextField("", text: $email)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .autocapitalization(.none)
                                    .onChange(of: email) { newValue in
                                        email = formatEmailInput(newValue)
                                    }
                            }
                            if let error = emailError {
                                errorText(error)
                            }

                            labeledField(label: "Password", isRequired: true) {
                                VStack(alignment: .leading, spacing: 4) {
                                    SecureField("", text: $password)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                    Text("Must be at least 12 characters, include an uppercase, lowercase, number, and special character.")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            if let error = passwordError {
                                errorText(error)
                            }

                            labeledField(label: "First name", isRequired: true) {
                                TextField("", text: $firstName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .onChange(of: firstName) { newValue in
                                        firstName = formatNameInput(newValue)
                                    }
                            }
                            if let error = firstNameError {
                                errorText(error)
                            }

                            labeledField(label: "Middle name", isRequired: false) {
                                TextField("", text: $middleName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .onChange(of: middleName) { newValue in
                                        middleName = formatNameInput(newValue)
                                    }
                            }

                            labeledField(label: "Last name", isRequired: true) {
                                TextField("", text: $lastName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .onChange(of: lastName) { newValue in
                                        lastName = formatNameInput(newValue)
                                    }
                            }
                            if let error = lastNameError {
                                errorText(error)
                            }
                            
                            labeledField(label: "Specialty authorization", isRequired: false) {
                                Picker("Select your specialty", selection: $specialAuth) {
                                    Text("Select a specialty").tag(Optional<String>.none) // placeholder
                                    ForEach(specialties, id: \.self) { stateOption in
                                        Text(stateOption).tag(Optional(stateOption))
                                    }
                                }
                                .pickerStyle(.menu)
                                .foregroundColor(state == nil ? .gray : .primary)
                                .onChange(of: state) { _ in
                                    stateError = nil
                                }
                                    

                                if let error = specialAuthError {
                                    errorText(error)
                                }
//                            }
//                            labeledField(label: "State", isRequired: true) {
//                                TextField("", text: $state)
//                                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                            }
//                            if let error = stateError {
//                                errorText(error)
                            }


                            labeledField(label: "Phone number", isRequired: true) {
                                //not required on web app, but get backend error if set to false
                                TextField("", text: $phone)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .onChange(of: phone) { newValue in
                                        phone = formatPhoneInput(newValue)
                                    }
                            }
                            if let error = phoneError {
                                errorText(error)
                            }

                            labeledField(label: "SSN", isRequired: false) {
                                TextField("", text: $ssn)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .onChange(of: ssn) { newValue in
                                        ssn = formatSSNInput(newValue)
                                    }
                            }
                            if let error = ssnError {
                                errorText(error)
                            }

                            labeledField(label: "Date of Birth", isRequired: true) {
                                DatePicker("", selection: $birthday, displayedComponents: .date)
                                    .datePickerStyle(.compact)
                            }

                            labeledField(label: "Street Address", isRequired: true) {
                                TextField("", text: $address)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .onChange(of: address) { newValue in
                                        address = formatAddressInput(newValue)
                                    }
                            }
                            if let error = addressError {
                                errorText(error)
                            }

                            labeledField(label: "City", isRequired: true) {
                                TextField("", text: $city)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .onChange(of: city) { newValue in
                                        city = formatCityInput(newValue)
                                    }
                            }
                            if let error = cityError {
                                errorText(error)
                            }

                            labeledField(label: "State", isRequired: true) {
                                Picker("Select your state", selection: $state) {
                                    Text("Select a state").tag(Optional<String>.none) // placeholder
                                    ForEach(states, id: \.self) { stateOption in
                                        Text(stateOption).tag(Optional(stateOption))
                                    }
                                }
                                .pickerStyle(.menu)
                                .foregroundColor(state == nil ? .gray : .primary)
                                .onChange(of: state) { _ in
                                    stateError = nil
                                }
                                    

                                if let error = stateError {
                                    errorText(error)
                                }
//                            }
//                            labeledField(label: "State", isRequired: true) {
//                                TextField("", text: $state)
//                                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                            }
//                            if let error = stateError {
//                                errorText(error)
                            }

                            labeledField(label: "Zipcode", isRequired: true) {
                                TextField("", text: $zipcode)
                                    .keyboardType(.numberPad)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .onChange(of: zipcode) { newValue in
                                        zipcode = formatZipcodeInput(newValue)
                                    }
                            }
                            if let error = zipError {
                                errorText(error)
                            }
                        }

                        if let error = validationError {
                            Text(error)
                                .foregroundColor(.red)
                                .padding()
                        }

                        HStack {
                            Button("Homepage") { dismiss() }
                                .frame(width: 200)
                            Button(action: submit) {
                                Text("Submit").frame(maxWidth: 75)
                            }
                        }.padding(.vertical)
                    }
                    .padding()
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }

    func labeledField<Content: View>(label: String, isRequired: Bool, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(label)\(isRequired ? " *" : "")")
                .font(.body)
            content()
        }
    }

    func errorText(_ message: String) -> some View {
        Text(message)
            .font(.caption)
            .foregroundColor(.red)
    }
    
    func formatEmailInput(_ value: String) -> String {
        let allowedChars = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-_@")
        return String(value.unicodeScalars.filter { allowedChars.contains($0) })
    }
    
    func formatNameInput(_ value: String) -> String {
        let allowedChars = CharacterSet.letters.union(.whitespaces).union(CharacterSet(charactersIn: "-'\u{2019}"))
        return String(value.unicodeScalars.filter { allowedChars.contains($0) })
    }

    func formatZipcodeInput(_ value: String) -> String {
        let digits = value.filter { $0.isNumber }
        return String(digits.prefix(5))
    }

    func formatPhoneInput(_ value: String) -> String {
        let digits = value.filter { $0.isNumber }
        let limited = String(digits.prefix(10))
        
        switch limited.count {
        case 0:
            return ""
        case 1...3:
            return "(\(limited)"
        case 4...6:
            let area = limited.prefix(3)
            let middle = limited.dropFirst(3)
            return "(\(area)) \(middle)"
        default:
            let area = limited.prefix(3)
            let middle = limited.dropFirst(3).prefix(3)
            let last = limited.dropFirst(6)
            return "(\(area)) \(middle)-\(last)"
        }
    }
    
    func formatAddressInput(_ value: String) -> String {
        let allowedChars = CharacterSet.letters.union(.decimalDigits).union(.whitespaces).union(CharacterSet(charactersIn: "-"))
        return String(value.unicodeScalars.filter { allowedChars.contains($0) })
    }
    
    func formatCityInput(_ value: String) -> String {
        let allowedChars = CharacterSet.letters.union(.whitespaces).union(CharacterSet(charactersIn: "-"))
        return String(value.unicodeScalars.filter { allowedChars.contains($0) })
    }

    func formatSSNInput(_ value: String) -> String {
        let digits = value.filter { $0.isNumber }
        let limited = String(digits.prefix(9))
        var result = ""
        for (index, char) in limited.enumerated() {
            if index == 3 || index == 5 { result.append("-") }
            result.append(char)
        }
        return result
    }
    
//    struct ValidationResponse: Decodable {
//        let valid: Bool
//    }

    func submit() {
        emailError = nil; passwordError = nil; firstNameError = nil
        lastNameError = nil; specialAuthError = nil; addressError = nil; cityError = nil
        stateError = nil; zipError = nil; phoneError = nil; ssnError = nil

        if !Validator.isNonEmpty(email) {
            emailError = "Email is required."
        } else if !Validator.isValidEmail(email) {
            emailError = "Email format is invalid."
        }

        if !Validator.isNonEmpty(password) {
            passwordError = "Password is required."
        } else if !Validator.isValidPassword(password) {
            passwordError = "Password does not meet requirements."
        }

        if !Validator.isNonEmpty(firstName) {
            firstNameError = "First name is required."
        }

        if !Validator.isNonEmpty(lastName) {
            lastNameError = "Last name is required."
        }

        if !Validator.isNonEmpty(address) {
            addressError = "Address is required."
        }

        if !Validator.isNonEmpty(city) {
            cityError = "City is required."
        }

        if !Validator.isNonEmpty(state) {
            stateError = "State is required."
        }

        if !Validator.isNonEmpty(zipcode) {
            zipError = "Zipcode is required."
        } else if !Validator.isValidZipCode(zipcode) {
            zipError = "Zipcode must be 5 digits."
        }

        if Validator.isNonEmpty(phone) && !Validator.isValidPhone(phone) {
            phoneError = "Phone number must be 10 digits."
        }

        if Validator.isNonEmpty(ssn) && !Validator.isValidSSN(ssn) {
            ssnError = "SSN must be exactly 10 digits."
        }

        let anyError = [
            emailError, passwordError, firstNameError, lastNameError,
            addressError, cityError, stateError, zipError, phoneError, ssnError
        ].contains { $0 != nil }

        if !anyError {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM-dd-yyyy"
            let birthdayString = dateFormatter.string(from: birthday)

            let formData: [String: String] = [
                "first_name": firstName,
                "middle_name": middleName,
                "last_name": lastName,
                "specialty_auth": specialAuth ?? "",
                "phone": phone,
                "ssn": ssn,
                "date_of_birth": birthdayString,
                "email": email,
                "password": password,
                "address_line_1": address,
                "city": city,
                "state": state ?? "",
                "zipcode": zipcode
            ]

            Task {
                do {
                    let isValidAddress = try await ValidateAddress.validate(
                        address: address,
                        city: city,
                        zipcode: zipcode,
                        state: state ?? ""
                    )

                    if isValidAddress {
                    //comment back above block back in for address validation
                        let result = try await SubmitSignup.submit(formData: formData)
                        print(result)
                        showSuccessScreen = true
                    } else {
                        addressError = "Invalid address"
                        cityError = "Invalid city"
                        zipError = "Invalid zipcode"
//                        validationError = "Please correct the address fields."
                    }
                    //comment back above block back in for address validation
                } catch {
                    validationError = "Unable to sign up - \(error.localizedDescription)"
                }
            }
        } else {
            validationError = "Please correct the highlighted fields."
        }
    }
}

#Preview {
    IndividualSignUpView()
}
