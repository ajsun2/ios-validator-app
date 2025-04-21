//
//  AdminDashboardView.swift
//  SwiftSample (iOS)
//
//  Created by Adrianne Sun on 4/21/25.
//

import SwiftUI

struct AdminDashboardView: View {
    @Environment(\.dismiss) private var dismiss
//    let user: User
    var body: some View {
//        NavigationView {
            ZStack (alignment: .top) {
                Color(.systemGray6)
                        .ignoresSafeArea()
                VStack {
                    Text ("Welcome, Admin")
                        .font(.title)
//                    NavigationLink(destination: MainView()) {
//                        Text("Homepage")
////                            .padding()
//                            .frame(width: 200)
////                            .padding(.all, 10)
////                            .background(Color.blue)
////                            .foregroundColor(.white)
////                            .cornerRadius(8)
////                            .overlay(
////                                RoundedRectangle(cornerRadius: 8)
////                                    .stroke(Color.gray, lineWidth: 1)
////                            )
//                    }
                    NavigationLink(destination: IndvDashboardView()) {
                        Text("Individual Dashboard")
                            .frame(width: 200)
//                            .padding()
//                            .frame(maxWidth: 200)
//                            .padding(.all, 10)
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(8)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 8)
//                                    .stroke(Color.gray, lineWidth: 1)
//                            )
                    }
                    NavigationLink(destination: OrgDashboardView()) {
                        Text("Organization Dashboard")
                            .frame(width: 200)
//                            .padding()
//                            .frame(maxWidth: 200)
//                            .padding(.all, 10)
//                            .background(Color.blue)
//                            .foregroundColor(.white)
//                            .cornerRadius(8)
//                            .overlay(
//                                RoundedRectangle(cornerRadius: 8)
//                                    .stroke(Color.gray, lineWidth: 1)
//                            )
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
//        }
    }
}

#Preview {
    AdminDashboardView()
}
