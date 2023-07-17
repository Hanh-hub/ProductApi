//
//  ContentView.swift
//  WatchOsDemo Watch App
//
//  Created by Hanh Vo on 6/14/23.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
   @StateObject var viewModel = LoginViewModel()
   //@State var errorMessage = ""
    
    var body: some View {
        NavigationStack{
           
                if viewModel.isLoggedIn {
                    ProductView()
                } else {
                    LoginView(viewModel: viewModel, isLoggedIn: $viewModel.isLoggedIn)
                }
//                LoginView(viewModel: viewModel, isLoggedIn: $viewModel.isLoggedIn)
//                    .fullScreenCover(isPresented: $viewModel.isLoggedIn) {
//                        ProductView()
//                    }
            
        }
    }
    

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
