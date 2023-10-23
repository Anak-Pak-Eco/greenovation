//
//  WifiSetupDoneView.swift
//  Hydrospace
//
//  Created by Leonardo Jose Gunawan on 23/10/23.
//

import SwiftUI

struct WifiSetupDoneView: View {
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
            Text("Kamu berhasil tersambung dengan **\"Pak Melon\"**")
                .font(.customCalloutRegular)
                .padding(.bottom)
            
            // MARK: Wifi List
            List() {
                wifiComponent(wifiName: "Iphone14ProMaxPlus")
                    .onTapGesture {
                        isShowBottomView.toggle()
                    }
//                wifiComponent(wifiName: "Iphone13ProPlusMax")
//                    .onTapGesture {
//                        isShowBottomView.toggle()
//                    }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .scrollContentBackground(.hidden)
            
            Spacer()
            
            // MARK: Continue Button
            Button {
                
            } label: {
                Text("lanjut-pendaftaran-perangkat")
                    .padding(.vertical, 3)
                    .frame(maxWidth: .infinity)
                    .font(.customCalloutRegular)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
            }
            .padding()
            .buttonStyle(.borderedProminent)
            .tint(.primaryAccent)
            
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

#Preview {
    WifiSetupDoneView()
}
