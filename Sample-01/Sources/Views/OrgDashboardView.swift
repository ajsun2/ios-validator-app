//
//  OrgDashboardView.swift
//  SwiftSample (iOS)
//
//  Created by Adrianne Sun on 4/21/25.
//

import SwiftUI

struct OrgDashboardView: View {
    @Environment(\.dismiss) private var dismiss
    var body: some View {
        ZStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Text("Org Dashboard")
            Button("Homepage") {
                dismiss()
            }
            .frame(width: 200)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OrgDashboardView()
}
