import SwiftUI

struct OrgSignUpView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var specialty: Specialty? = Specialty.healthcareFP
    @State private var orgName = ""
    @State private var npi = ""
    @State private var fein = ""
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
    
    // Org specific fields
    @State private var npiError: String?
    @State private var feinError: String?
    @State private var taxIDError: String?
    @State private var orgCodeError: String?
    @State private var bureauError: String?
    @State private var stateDeptIDError: String?

    // General fields
    @State private var orgNameError: String?
    @State private var emailError: String?
    @State private var passwordError: String?
    @State private var usernameError: String?
    @State private var addressError: String?
    @State private var cityError: String?
    @State private var stateError: String?
    @State private var zipError: String?
    @State private var phoneError: String?
    
    @State private var validationError: String?
    

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
                                .onChange(of: orgName) { newValue in
                                    orgName = formatNameInput(newValue)
                                }

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
                            .onChange(of: specialty) { _ in
                                clearFieldErrors()
                            }
                        }

                        if let selection = specialty {
                            switch selection {
                            case .healthcareFP, .healthcareNP:
                                labeledField(label: "National Provider Identifier (NPI)", isRequired: true) {
                                    TextField("", text: $npi)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .onChange(of: npi) { newValue in
                                            npi = formatNPIInput(newValue)
                                            npiError = nil
                                        }
                                }
                                if let error = npiError { errorText(error) }

                                labeledField(label: "Federal Employer Identification Number (FEIN)", isRequired: true) {
                                    TextField("", text: $fein)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .onChange(of: fein) { newValue in
                                            fein = formatFEINInput(newValue)
                                            feinError = nil
                                        }
                                }
                                if let error = feinError { errorText(error) }

                                labeledField(label: "State Tax ID", isRequired: true) {
                                    TextField("", text: $taxID)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .onChange(of: taxID) { newValue in
                                            taxID = formatTaxIDInput(newValue)
                                            taxIDError = nil
                                        }
                                }
                                if let error = taxIDError { errorText(error) }

                            case .federalAgency:
                                labeledField(label: "Organization Code", isRequired: true) {
                                    TextField("", text: $orgCode)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .onChange(of: orgCode) { newValue in
                                            orgCode = formatOrgCodeInput(newValue)
                                            orgCodeError = nil }
                                }
                                if let error = orgCodeError { errorText(error) }

                                labeledField(label: "Bureau Name", isRequired: true) {
                                    TextField("", text: $bureau)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .onChange(of: bureau) { newValue in
                                            bureau = formatBureauInput(newValue)
                                            bureauError = nil }
                                }
                                if let error = bureauError { errorText(error) }

                            case .stateAgency, .municipalAgency:
                                labeledField(label: "Federal Employer Identification Number (FEIN)", isRequired: true) {
                                    TextField("", text: $fein)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .onChange(of: fein) { newValue in
                                            fein = formatFEINInput(newValue)
                                            feinError = nil
                                        }
                                }
                                if let error = feinError { errorText(error) }

                                labeledField(label: "State Department ID", isRequired: true) {
                                    TextField("", text: $stateDeptID)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .onChange(of: stateDeptID) { _ in stateDeptIDError = nil }
                                }
                                if let error = stateDeptIDError { errorText(error) }

                            case .commercialFP, .otherNP:
                                labeledField(label: "Federal Employer Identification Number (FEIN)", isRequired: true) {
                                    TextField("", text: $fein)
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        .onChange(of: fein) { newValue in fein = formatFEINInput(newValue) }
                                    // add error notification
                                    if let error = feinError { errorText(error) }
                                }
                            }
                        }

                        labeledField(label: "Organization Email", isRequired: true) {
                            TextField("", text: $email).onChange(of: email) { _ in emailError = nil }
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .autocapitalization(.none)
                                .onChange(of: email) { newValue in
                                    email = formatEmailInput(newValue)}
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
                            
                            VStack(alignment: .leading, spacing: 4) {
                                TextField("", text: $username).onChange(of: username) { _ in usernameError = nil }
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .onChange(of: username) { newValue in
                                        username = formatUsernameInput(newValue)}
                                Text("You may use letters, numbers, and up to one _ or @.")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            

                            if let error = usernameError { errorText(error) }
                        }

                        labeledField(label: "Organization Address Line 1", isRequired: true) {
                            TextField("", text: $address).onChange(of: address) { _ in addressError = nil }
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onChange(of: address) { newValue in
                                    address = formatAddressInput(newValue)}
                            if let error = addressError { errorText(error) }
                        }

                        labeledField(label: "City", isRequired: true) {
                            TextField("", text: $city).onChange(of: city) { _ in cityError = nil }
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onChange(of: city) { newValue in
                                    city = formatCityInput(newValue)}
                            if let error = cityError { errorText(error) }
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

                        labeledField(label: "Organization Phone", isRequired: true) {
                            TextField("", text: $phone)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .onChange(of: phone) { newValue in phone = formatPhoneInput(newValue)
                                    phoneError = nil}
                            if let error = phoneError { errorText(error) }
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
        
    func clearFieldErrors() {
        orgNameError = nil
        emailError = nil
        passwordError = nil
        usernameError = nil
        addressError = nil
        cityError = nil
        stateError = nil
        zipError = nil
        phoneError = nil
        npiError = nil
        feinError = nil
        taxIDError = nil
        orgCodeError = nil
        bureauError = nil
        stateDeptIDError = nil
    }

    func formatEmailInput(_ value: String) -> String {
        let allowedChars = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.-_@")
        return String(value.unicodeScalars.filter { allowedChars.contains($0) })
    }
    
    func formatUsernameInput(_ value: String) -> String {
        let allowedChars = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_@")
        return String(value.unicodeScalars.filter { allowedChars.contains($0) })
    }
    
    func formatNameInput(_ value: String) -> String {
        let allowedChars = CharacterSet.letters.union(.decimalDigits).union(.whitespaces).union(CharacterSet(charactersIn: "-"))
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
    
    func formatOrgCodeInput(_ value: String) -> String {
        let digits = value.filter { $0.isNumber }
        return String(digits.prefix(12))
    }

    func formatTaxIDInput(_ value: String) -> String {
        let allowedChars = CharacterSet.letters.union(.decimalDigits).union(.whitespaces).union(CharacterSet(charactersIn: "-_."))
        let filtered = String(value.unicodeScalars.filter { allowedChars.contains($0) })
        return String(filtered.prefix(15))
    }

    func formatNPIInput(_ value: String) -> String {
        let digits = value.filter { $0.isNumber }
        return String(digits.prefix(10))
    }
    
    func formatBureauInput(_ value: String) -> String {
        let allowedChars = CharacterSet.letters
        return String(value.unicodeScalars.filter { allowedChars.contains($0) })
    }

    func submit() {
//        orgNameError = nil
//        emailError = nil
//        passwordError = nil
//        usernameError = nil
//        addressError = nil
//        cityError = nil
//        stateError = nil
//        zipError = nil
//        npiError = nil
//        feinError = nil
//        taxIDError = nil
//        orgCodeError = nil
//        bureauError = nil
//        stateDeptIDError = nil
        clearFieldErrors()
        
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
        if !Validator.isValidUsername(username) {
            usernameError = "Username may only contain one special character (_ and @)"
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
        if !Validator.isNonEmpty(phone) {
            phoneError = "Phone number is required."
        }
        
        if let selection = specialty {
            switch selection {
            case .healthcareFP, .healthcareNP:
                if !Validator.isNonEmpty(npi) {
                    npiError = "NPI is required."
                } else if npi.count != 10 {
                    npiError = "NPI must be 10 digits."
                }

                if !Validator.isNonEmpty(fein) {
                    feinError = "FEIN is required."
                }

                if !Validator.isNonEmpty(taxID) {
                    taxIDError = "State Tax ID is required."
                }

            case .federalAgency:
                if !Validator.isNonEmpty(orgCode) {
                    orgCodeError = "Organization Code is required."
                }

                if !Validator.isNonEmpty(bureau) {
                    bureauError = "Bureau Name is required."
                }

            case .stateAgency, .municipalAgency:
                if !Validator.isNonEmpty(fein) {
                    feinError = "FEIN is required."
                }

                if !Validator.isNonEmpty(stateDeptID) {
                    stateDeptIDError = "State Department ID is required."
                }

            case .commercialFP, .otherNP:
                if !Validator.isNonEmpty(fein) {
                    feinError = "FEIN is required."
                }
            }
        }

        let anyError = [
            orgNameError, emailError, passwordError, usernameError,
            addressError, cityError, stateError, zipError, phoneError,
            npiError, feinError, taxIDError, orgCodeError, bureauError, stateDeptIDError
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
                "state": state ?? "",
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
                    let isValidAddress = try await ValidateAddress.validate(
                        address: address,
                        city: city,
                        zipcode: zipcode,
                        state: state ?? ""
                    )

                    if isValidAddress {
                    //comment back above block back in for address validation
                        let result = try await SubmitSignup.submit(formData: payload)
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

enum Specialty: String, CaseIterable, Identifiable {
    case healthcareFP, healthcareNP, federalAgency, stateAgency, municipalAgency, commercialFP, otherNP
    var id: Self { self }
}

#Preview {
    OrgSignUpView()
}
