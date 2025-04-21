//
//  OrgSignUp.swift
//  SwiftSample (iOS)
//
//  Created by Adrianne Sun on 4/14/25.
//

import SwiftUI

struct OrgSignUpView: View {
//    @State private var specialty = ""
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

    var body: some View {
//        NavigationView {
            ZStack{
                Color(.systemGray6)
                        .ignoresSafeArea()
                VStack{
                    Text("Organization Sign Up")
                        .padding(.top, 15)
                        .font(.title)
                    Form {
//                        Section(header: Text("")) {
                            List {
                                Picker("Specialty", selection: $specialty) {
//                                    Text("Select a specialty").tag(nil as Specialty?)
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
                            TextField("Organization Name", text: $orgName)
                            
                            if let selection = specialty {
//                                Section(header: Text("")) {
                                    switch selection {
                                    case .healthcareFP:
                                        TextField("National Provider Identifier (NPI)", text: $npi)
                                        TextField("Federal Employer Identification Number (FEIN)", text: $fein)
                                        TextField("State Tax ID", text: $taxID)
                                        
                                    case .healthcareNP:
                                        TextField("National Provider Identifier (NPI)", text: $npi)
                                        TextField("Federal Employer Identification Number (FEIN)", text: $fein)
                                        TextField("State Tax ID", text: $taxID)

                                    case .federalAgency:
//                                        Text("Federal Agency Form")
                                        TextField("Organization Code", text: $orgCode)
                                        TextField("Bureau Name", text: $bureau)
                                    case .stateAgency:
                                        TextField("Federal Employer Identification Number (FEIN)", text: $fein)
                                        TextField("State Department ID", text: $stateDeptID)
                                    case .municipalAgency:
                                        TextField("Federal Employer Identification Number (FEIN)", text: $fein)
                                        TextField("State Department ID", text: $stateDeptID)

                                    case .commercialFP:
                                        TextField("Federal Employer Identification Number (FEIN)", text: $fein)
                                    
                                    case .otherNP:
                                        TextField("Federal Employer Identification Number (FEIN)", text: $fein)
//                                    default:
//                                        Text("Please select specialty")
                                    }
//                                }
                            }

//                            TextField("National Provider Identifier (NPI)", text: $npi)

//                            TextField("State Tax ID", text: $taxID)
                            
                            TextField("Organization Address Line 1", text: $address)
                                .textContentType(.streetAddressLine1)

                            TextField("City", text: $city)
                                .textContentType(.addressCity)

                            TextField("State", text: $state)
                                .textContentType(.addressState)

                            TextField("Zipcode", text: $zipcode)
                                .keyboardType(.numberPad)
                                .textContentType(.postalCode)
                            
                            TextField("Organization Phone", text: $phone)
                                .textContentType(.telephoneNumber)
                            
                            TextField("Organization Email", text: $email)
                                .textContentType(.emailAddress)
                            
                            TextField("Representative Username", text: $username)
                            
                            SecureField("Password", text: $password)
                                .textContentType(.password)
//                            }
                        }
                    HStack {
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
//                    .navigationTitle("Organization Sign Up")
//                    .padding(.top, 10)
                }
            }
            .navigationBarBackButtonHidden(true)
        }
    }
//}

enum Specialty: String, CaseIterable, Identifiable {
    case healthcareFP, healthcareNP, federalAgency, stateAgency, municipalAgency, commercialFP, otherNP
    var id: Self { self }
}


#Preview {
    OrgSignUpView()
}
