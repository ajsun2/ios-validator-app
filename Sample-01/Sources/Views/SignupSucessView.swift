//
//  SignupSucessView.swift
//  SwiftSample (iOS)
//
//  Created by Adrianne Sun on 5/20/25.
//

import SwiftUI

struct SignupSuccessView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Signup successful")
                .font(.title2)
            Text("You will be redirected shortly.").foregroundColor(.gray)

            .padding()
        }
    }
}

#Preview {
    SignupSuccessView()
}

