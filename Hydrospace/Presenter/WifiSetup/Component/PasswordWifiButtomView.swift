//
//  PasswordWifiButtomView.swift
//  Hydrospace
//
//  Created by Leonardo Jose Gunawan on 23/10/23.
//

import SwiftUI

struct PasswordWifiButtomView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var isWifiSetupDoneViewPresented = false
    
    private var wifiName = "Pak Melon"
    @State private var wifiPassword = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.surface.ignoresSafeArea(.all)
                VStack {
                    // MARK: Text Password
                    Text("Masukkan kata sandi untuk Wifi **\"\(wifiName)\"**")
                        .padding(.bottom)
                    
                    // MARK: Password field
                    TextField("kata-sandi", text: $wifiPassword)
                        .padding(.all, 12)
                        .background(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.secondaryAccent, lineWidth: 1)
                        )
                    
                    // MARK: Button
                    Button {
                        
                    } label: {
                        Text("gabung")
                            .padding(.vertical, 3)
                            .frame(maxWidth: .infinity)
                            .font(.customCalloutRegular)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                    .padding(.top)
                    .buttonStyle(.borderedProminent)
                    .tint(.primaryAccent)

                }
                .padding()
                .background(.surface)
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("kata-sandi")
                            .font(.customTitle3Bold)
                    }
                    
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.primaryAccent)
                                .font(.customCalloutSemibold)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PasswordWifiButtomView()
}
