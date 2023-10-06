//
//  DevicesView.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 06/10/23.
//

import Foundation
import SwiftUI

struct DevicesView: View {
    
    let navigator: NavigatorDelegate?
    
    init(navigator: NavigatorDelegate?) {
        self.navigator = navigator
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 15) {
                    deviceItem
                        .onTapGesture {
                            navigator?.navigateToDetailPage()
                        }
                }
                .padding(.vertical)
            }
        }
        .background(ColorConstants.backgroundColor)
        .navigationTitle("Perangkat")
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(ColorConstants.primaryAccentColor)
                        .fontWeight(.semibold)
                }
            }
        }
    }
    
    var deviceItem: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Perangkat 1")
                        .font(.body)
                    
                    Text("Sawi Manis")
                        .font(.title3)
                        .bold()
                }
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text("880")
                            .font(.title3)
                            .bold()
                        
                        Text("ppm")
                    }
                    
                    VStack(alignment: .leading) {
                        Text("6")
                            .font(.title3)
                            .bold()
                        
                        Text("ph")
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    VStack {
                        Image("ImageSeedling")
                        Text("Anakan")
                            .font(.body)
                            .fontWeight(.semibold)
                    }
                }
            }
            
            Spacer()
        }
        .padding()
        .background(.white)
        .clipShape(.rect(cornerRadius: 10))
        .shadow(color: .black.opacity(0.04), radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
        .padding(.horizontal)
    }
}

#Preview {
    DevicesView(navigator: nil)
}
