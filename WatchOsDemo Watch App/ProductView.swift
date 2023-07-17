//
//  ProductView.swift
//  WatchOsDemo Watch App
//
//  Created by Hanh Vo on 6/15/23.
//

import SwiftUI

struct ProductView: View {
    
   @StateObject var viewModel = ProductListViewModel()
   @State var errorMessage = ""
    
    var body: some View {
        VStack {
            if !errorMessage.isEmpty {
                Text(errorMessage)
            }
            else {
                List(viewModel.products, id: \.self) { product in
                    VStack(alignment: .leading) {
                        if let thumbnailURL = product.thumbnail, let url = URL(string: thumbnailURL) {
                            AsyncImage(
                                url: url,
                                content: { image in
                                    image
                                        .resizable()
                                        .scaledToFit()
                                }, placeholder: { Text("Loading...") }
                            )
                            .frame(width: 70, height: 70)
                        }
                        
                        Text(product.title ?? "NA")
                        Text("$ \(product.price ?? 0)")
                    }
                }
            }
        }
        .onAppear{
                getData()
        }
        .navigationBarBackButtonHidden()
    }
    
    func getData(){
        viewModel.fetchProducts { error in
            if let error = error {
                print(error.localizedDescription)
                errorMessage = error.localizedDescription
            }
        }
    }
}

struct ProductView_Previews: PreviewProvider {
    static var previews: some View {
        ProductView()
    }
}
