import SwiftUI
import Auth0
import JWTDecode


struct MainView: View {
    @State var user: User?

    var body: some View {
        if let user = self.user {
                NavigationView {
                    VStack {
                        AdminDashboardView()
                        Button("Logout", action: self.logout)
                    }
                }
                .navigationBarBackButtonHidden(true)
        } else {
                NavigationView {
                    VStack {
                        HeroView()
//                        Button("Admin Login", action: self.login)
                        
                        NavigationLink(destination: IndividualSignUpView()) {
                            Text("Individual Sign Up")
                        }
                        
                        NavigationLink(destination: OrgSignUpView()) {
                            Text("Organization Sign Up")
                        }
                    }
                }
                .navigationBarBackButtonHidden(true)
        }
    }
}

extension MainView {
    func login() {
        Auth0
            .webAuth()
            .start { result in
                switch result {
                case .success(let credentials):
                    do {
//                        let idToken = credentials.idToken
                        let jwt = try decode(jwt: credentials.idToken)

                        let roles = jwt.claim(name: "custom_roles").array ?? []
                        let userID = jwt.claim(name: "sub").string ?? "unknown"

                        print("Auth: Roles: \(roles)")
                        print("Auth: User ID: \(userID)")

                        if roles.contains("Central Application Admin") {
                            print("Auth: User has admin role")
//                            AdminDashboardView()
                            self.user = User(from: credentials.idToken)
                        } else {
                            print("Auth: User is missing admin role")
                            logout()
                        }
                    } catch {
                        print("Failed to decode token: \(error)")
                        logout()
                    }
                case .failure(let error):
                    print("Login failed with: \(error)")
                }
            }
    }


    func logout() {
        Auth0
            .webAuth()
//            .useHTTPS() // Use a Universal Link logout URL on iOS 17.4+ / macOS 14.4+
            .clearSession { result in
                switch result {
                case .success:
                    self.user = nil
                case .failure(let error):
                    print("Failed with: \(error)")
                }
            }
    }
    
}

#Preview {
    MainView()
}
