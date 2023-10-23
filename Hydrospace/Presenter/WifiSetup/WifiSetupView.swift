//
//  WifiSetupView.swift
//  Hydrospace
//
//  Created by Leonardo Jose Gunawan on 23/10/23.
//

import SwiftUI

struct WifiSetupView: View {
    @Environment(\.dismiss) var dismiss
    
    @State var isShowBottomView = false
    
    var body: some View {
        VStack {
            
            // MARK: Wifi Image
            Image(systemName: "wifi")
                .resizable()
                .frame(width: 85, height: 65)
                .padding(.top, 30)
                .padding(.bottom, 10)
                .foregroundStyle(.primaryAccent)
            
            // MARK: Connecting Text
            Text("Sambungkan **Hydro's Device** Ke Wifi")
                .font(.customCalloutRegular)
                .padding(.bottom)
            
            // MARK: Wifi List
            List() {
                wifiComponent(wifiName: "Iphone14ProMaxPlus")
                    .onTapGesture {
                        isShowBottomView.toggle()
                    }
                wifiComponent(wifiName: "Iphone13ProPlusMax")
                    .onTapGesture {
                        isShowBottomView.toggle()
                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scrollContentBackground(.hidden)
            
            Spacer()
            
        }
        .background(.surface)
        .navigationTitle("Wifi")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(.primaryAccent)
                        .fontWeight(.semibold)
                }
            }
        }
        .sheet(isPresented: $isShowBottomView) {
            PasswordWifiButtomView()
                .presentationDetents([.height(294)])
        }
    }
}

struct wifiComponent: View {
    
    var wifiName: String
    
    var body: some View {
        VStack {
            HStack {
                Text("\(wifiName)")
                Spacer()
                Image(systemName: "lock.fill")
                    .resizable()
                    .frame(width: 18, height: 22)
                    .foregroundStyle(.primaryAccent)
                Image(systemName: "wifi")
                    .resizable()
                    .frame(width: 23, height: 22)
                    .foregroundStyle(.primaryAccent)
            }
            .padding()
        }
    }
}

#Preview {
    WifiSetupView()
}
