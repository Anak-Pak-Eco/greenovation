//
//  DevicesView.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 06/10/23.
//

import Foundation
import SwiftUI

struct DevicesView: View {
    
    @ObservedObject private var viewModel: DevicesViewModel
    private var controller: NavigatorDelegate?
    
    init(controller: NavigatorDelegate?, viewModel: DevicesViewModel) {
        self.viewModel = viewModel
        self.controller = controller
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "DMSans-Bold", size: 34)!]
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 15) {
                    if let deviceStatus = viewModel.deviceStatus {
                        deviceItem(deviceStatus: deviceStatus)
                            .onTapGesture {
                                controller?.navigate(.detail)
                            }
                    }
                }
                .padding(.vertical)
            }
        }
        .background(.surface)
        .navigationTitle(String(localized: "devices"))
        .navigationBarTitleDisplayMode(.large)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "plus")
                        .foregroundStyle(.primaryAccent)
                        .fontWeight(.semibold)
                }
            }
        }
        .onAppear {
            viewModel.initData()
        }
    }
    
    func deviceItem(deviceStatus: DeviceStatusModel) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(deviceStatus.name)
                        .font(.customBody)
                    
                    Text(deviceStatus.plantId)
                        .font(.customTitle3Bold)
                        .foregroundStyle(.primaryAccent)
                        .bold()
                }
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text(String.format(deviceStatus.currentPpm, format: "%.2f"))
                            .font(.customTitle3Bold)
                            .foregroundStyle(.primaryAccent)
                        
                        Text("ppm")
                    }
                    
                    VStack(alignment: .leading) {
                        Text(String.format(deviceStatus.currentPh, format: "%.2f"))
                            .font(.customTitle3Bold)
                            .foregroundStyle(.primaryAccent)
                        
                        Text(String(localized: "ph"))
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    VStack {
                        Image("image-seedling")
                        Text(deviceStatus.currentSteps)
                            .font(.body)
                            .fontWeight(.semibold)
                    }
                }
                .padding(.bottom)
                
                if deviceStatus.currentPpm < 4 {
                    alertItem(message: "\(Image(systemName: "exclamationmark.triangle.fill")) Nilai PPM **rendah**. Tambahkan larutan nutrisi")
                } else if deviceStatus.currentPpm > 10 {
                    alertItem(message: "\(Image(systemName: "exclamationmark.triangle.fill")) Nilai PPM **tinggi**. Kurangi larutan nutrisi")
                }
                
                if deviceStatus.currentPh < 4 {
                    alertItem(message: "\(Image(systemName: "exclamationmark.triangle.fill")) Nilai pH **rendah**. Tambahkan larutan pH UP")
                } else if deviceStatus.currentPh > 10 {
                    alertItem(message: "\(Image(systemName: "exclamationmark.triangle.fill")) Nilai pH **tinggi**. Tambahkan larutan pH Down")
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
    
    func alertItem(message: LocalizedStringKey) -> some View {
        HStack {
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(message)
                        .font(.caption)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(.secondaryContainer)
        .clipShape(.rect(cornerRadius: 8))
    }
}

#Preview("Devices View") {
    NavigationStack {
        DevicesView(controller: nil, viewModel: DevicesViewModel())
    }
}
