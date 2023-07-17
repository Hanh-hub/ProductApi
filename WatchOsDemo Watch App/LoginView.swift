//
//  LoginView.swift
//  WatchOsDemo Watch App
//
//  Created by Hanh Vo on 6/15/23.
//

import SwiftUI

struct LoginView: View {
    @StateObject var viewModel: LoginViewModel
    
    @State var showErrorAlert: Bool = false
    @State private var alertMessage = ""
    @Binding var isLoggedIn: Bool
    
    
    var body: some View {
        VStack{
            TextField("Username", text: $viewModel.username)
                 .textContentType(.username)
             
             SecureField("Password", text: $viewModel.password)
                 .textContentType(.password)
            
            if viewModel.isLoading {
                ProgressView()
            }
            Button("Log in") {
                
                viewModel.login { result in
                    switch result {
                    case .success(_):
                        //viewModel.user = user
                        
                        viewModel.isLoggedIn = true
                    case .failure(let error):
                        alertMessage = error.localizedDescription
                        showErrorAlert = true
                    }
                }
            }
            .foregroundColor(.blue)

        }
        .alert(isPresented: $showErrorAlert) {
            Alert(title: Text("Login Error"),
                  message: Text(alertMessage),
                  dismissButton: .default(Text("OK")))
        }
    }
        
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(viewModel: LoginViewModel(), isLoggedIn: .constant(true))
    }
}
