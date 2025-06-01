import SwiftUI

struct OrgSignUpView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var specialty: Specialty? = Specialty.healthcareFP
    @State private var orgName = ""
    @State private var npi = ""
    @State private var fein = ""
    @State private var address = ""
    @State private var city = ""
    @State private var state = ""
    @State private var zipcode = ""
    @State private var taxID = ""
    @State private var phone = ""
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var orgCode = ""
    @State private var bureau = ""
    @State private var stateDeptID = ""
    @State private var showSuccessScreen = false

    // Field-specific errors
    @State private var orgNameError: String?
    @State private var emailError: String?
    @State private var passwordError: String?
    @State private var usernameError: String?
    @State private var addressError: String?
    @State private var cityError: String?
    @State private var stateError: String?
    @State private var zipError: String?

    var body: some View {
        ZStack {
            if showSuccessScreen {
                SignupSuccessView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                            dismiss()
                        }
                    }
            } else {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Organization Sign Up")
                            .font(.title)
                            .padding(.top, 15)

                        labeledField(label: "Organization Name", isRequired: true) {
                            TextField("", text: $orgName).onChange(of: orgName) { _ in orgNameError = nil }
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            if let error = orgNameError { errorText(error) }
                        }

                        labeledField(label: "Organization Type", isRequired: true) {
                            Picker("Select type", selection: $specialty) {
                                Text("Healthcare (For-Profit)").tag(Optional(Specialty.healthcareFP))
                                Text("Healthcare (Non-Profit)").tag(Optional(Specialty.healthcareNP))
                                Text("Federal Government Agency").tag(Optional(Specialty.federalAgency))
                                Text("State Government Agency").tag(Optional(Specialty.stateAgency))
                                Text("Municipal Agency").tag(Optional(Specialty.municipalAgency))
                                Text("Commerical (For-profit)").tag(Optional(Specialty.commercialFP))
                                Text("Other (Non-Profit)").tag(Optional(Specialty.otherNP))
                            }
                            .pickerStyle(MenuPickerStyle())
                        }

                        if let selection = specialty {
                            switch selection {
                            case .healthcareFP, .healthcareNP:
                                labeledField(label: "National Provider Identifier (NPI)", isRequired: true) {
                                    TextField("", text: $npi)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .onChange(of: npi) { newValue in npi = formatNPIInput(newValue) }
                                }
                                labeledField(label: "Federal Employer Identification Number (FEIN)", isRequired: true) {
                                    TextField("", text: $fein)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .onChange(of: fein) { newValue in fein = formatFEINInput(newValue) }
                                }
                                labeledField(label: "State Tax ID", isRequired: true) {
                                    TextField("", text: $taxID)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .onChange(of: taxID) { newValue in taxID = formatTaxIDInput(newValue) }
                                }

                            case .federalAgency:
                                labeledField(label: "Organization Code", isRequired: true) {
                                    TextField("", text: $orgCode)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }
                                labeledField(label: "Bureau Name", isRequired: true) {
                                    TextField("", text: $bureau)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }

                            case .stateAgency, .municipalAgency:
                                labeledField(label: "Federal Employer Identification Number (FEIN)", isRequired: true) {
                                    TextField("", text: $fein)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .onChange(of: fein) { newValue in fein = formatFEINInput(newValue) }
                                }
                                labeledField(label: "State Department ID", isRequired: true) {
                                    TextField("", text: $stateDeptID)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                }

                            case .commercialFP, .otherNP:
                                labeledField(label: "Federal Employer Identification Number (FEIN)", isRequired: true) {
                                    TextField("", text: $fein)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .onChange(of: fein) { newValue in fein = formatFEINInput(newValue) }
                                }
                            }
                        }

                        labeledField(label: "Organization Email", isRequired: true) {
                            TextField("", text: $email).onChange(of: email) { _ in emailError = nil }
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                            if let error = emailError { errorText(error) }
                        }

                        labeledField(label: "Password", isRequired: true) {
                            VStack(alignment: .leading, spacing: 4) {
                                SecureField("", text: $password).onChange(of: password) { _ in passwordError = nil }
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                Text("Must be at least 12 characters, include an uppercase, lowercase, number, and special character.")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            if let error = passwordError { errorText(error) }
                        }

                        labeledField(label: "Representative Username", isRequired: true) {
                            TextField("", text: $username).onChange(of: username) { _ in usernameError = nil }
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            if let error = usernameError { errorText(error) }
                        }

                        labeledField(label: "Organization Address Line 1", isRequired: true) {
                            TextField("", text: $address).onChange(of: address) { _ in addressError = nil }
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            if let error = addressError { errorText(error) }
                        }

                        labeledField(label: "City", isRequired: true) {
                            TextField("", text: $city).onChange(of: city) { _ in cityError = nil }
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            if let error = cityError { errorText(error) }
                        }

                        labeledField(label: "State", isRequired: true) {
                            TextField("", text: $state).onChange(of: state) { _ in stateError = nil }
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            if let error = stateError { errorText(error) }
                        }

                        labeledField(label: "Zipcode", isRequired: true) {
                            TextField("", text: $zipcode)
                                .keyboardType(.numberPad)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onChange(of: zipcode) { newValue in
                                    zipcode = formatZipcodeInput(newValue)
                                    zipError = nil
                                }
                            if let error = zipError { errorText(error) }
                        }

                        labeledField(label: "Organization Phone", isRequired: false) {
                            TextField("", text: $phone)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onChange(of: phone) { newValue in phone = formatPhoneInput(newValue) }
                        }

                        HStack {
                            Button("Homepage") { dismiss() }
                                .frame(width: 200)
                            Button(action: submit) {
                                Text("Submit").frame(maxWidth: 75)
                            }
                        }
                        .padding(.vertical)
                    }
                    .padding()
                }
                .background(Color(.systemGray6).ignoresSafeArea())
                .navigationBarBackButtonHidden(true)
            }
        }
    }

    func labeledField<Content: View>(label: String, isRequired: Bool, @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("\(label)\(isRequired ? " *" : "")")
                .font(.body)
                .fontWeight(.regular)
            content()
        }
    }

    func errorText(_ message: String) -> some View {
        Text(message)
            .font(.caption)
            .foregroundColor(.red)
    }

    func formatZipcodeInput(_ value: String) -> String {
        let digits = value.filter { $0.isNumber }
        return String(digits.prefix(5))
    }

    func formatPhoneInput(_ value: String) -> String {
        let digits = value.filter { $0.isNumber }
        let limited = String(digits.prefix(10))
        var result = ""
        for (index, char) in limited.enumerated() {
            if index == 3 || index == 6 {
                result.append("-")
            }
            result.append(char)
        }
        return result
    }

    func formatFEINInput(_ value: String) -> String {
        let digits = value.filter { $0.isNumber }
        let limited = String(digits.prefix(9))
        var result = ""
        for (index, char) in limited.enumerated() {
            if index == 2 {
                result.append("-")
            }
            result.append(char)
        }
        return result
    }

    func formatTaxIDInput(_ value: String) -> String {
        let digits = value.filter { $0.isNumber }
        return String(digits.prefix(9))
    }

    func formatNPIInput(_ value: String) -> String {
        let digits = value.filter { $0.isNumber }
        return String(digits.prefix(10))
    }

    func submit() {
        orgNameError = nil
        emailError = nil
        passwordError = nil
        usernameError = nil
        addressError = nil
        cityError = nil
        stateError = nil
        zipError = nil

        if !Validator.isNonEmpty(orgName) {
            orgNameError = "Organization Name is required."
        }
        if !Validator.isNonEmpty(email) {
            emailError = "Email is required."
        } else if !Validator.isValidEmail(email) {
            emailError = "Email format is invalid."
        }
        if !Validator.isNonEmpty(password) {
            passwordError = "Password is required."
        } else if !Validator.isValidPassword(password) {
            passwordError = "Password must be at least 12 characters and include upper/lowercase, number, and special character."
        }
        if !Validator.isNonEmpty(username) {
            usernameError = "Representative Username is required."
        }
        if !Validator.isNonEmpty(address) {
            addressError = "Organization Address is required."
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

        let anyError = [
            orgNameError, emailError, passwordError, usernameError,
            addressError, cityError, stateError, zipError
        ].contains { $0 != nil }

        if !anyError {
            var formData: [String: String] = [
                "org_name": orgName,
                "org_type": specialty?.rawValue ?? "",
                "phone": phone,
                "username": username,
                "email": email,
                "password": password,
                "address_line_1": address,
                "city": city,
                "state": state,
                "zipcode": zipcode
            ]

            if let selection = specialty {
                switch selection {
                case .healthcareFP, .healthcareNP:
                    formData["npi"] = npi
                    formData["fein"] = fein
                    formData["state_tax_id"] = taxID
                case .federalAgency:
                    formData["org_code"] = orgCode
                    formData["bureau"] = bureau
                case .stateAgency, .municipalAgency:
                    formData["fein"] = fein
                    formData["state_dept_id"] = stateDeptID
                case .commercialFP, .otherNP:
                    formData["fein"] = fein
                }
            }

            let payload = formData

            Task {
                do {
                    let result = try await SubmitSignup.submit(formData: payload)
                    print(result)
                    showSuccessScreen = true
                } catch {
                    emailError = "Unable to sign up – \(error.localizedDescription)"
                }
            }
        }
    }
}

enum Specialty: String, CaseIterable, Identifiable {
    case healthcareFP, healthcareNP, federalAgency, stateAgency, municipalAgency, commercialFP, otherNP
    var id: Self { self }
}

#Preview {
    OrgSignUpView()
}
