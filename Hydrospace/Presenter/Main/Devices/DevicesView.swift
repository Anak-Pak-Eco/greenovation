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
    @ObservedObject private var viewModel: DevicesViewModel = DevicesViewModel()
    
    init(navigator: NavigatorDelegate?) {
        self.navigator = navigator
    }
    
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(spacing: 15) {
                    if let deviceStatus = viewModel.deviceStatus {
                        deviceItem(deviceStatus: deviceStatus)
                            .onTapGesture {
                                navigator?.navigateToDetailPage()
                            }
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
        .onAppear {
            viewModel.initData()
        }
    }
    
    func deviceItem(deviceStatus: DeviceStatusModel) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(deviceStatus.name)
                        .font(.body)
                    
                    Text(deviceStatus.plantId)
                        .font(.title3)
                        .bold()
                }
                
                HStack(alignment: .bottom) {
                    VStack(alignment: .leading) {
                        Text(String(format: "%.2f", deviceStatus.currentPpm))
                            .font(.title3)
                            .bold()
                        
                        Text("ppm")
                    }
                    
                    VStack(alignment: .leading) {
                        Text(String(format: "%.2f", deviceStatus.currentPh))
                            .font(.title3)
                            .bold()
                        
                        Text("ph")
                    }
                    .padding(.leading, 20)
                    
                    Spacer()
                    
                    VStack {
                        Image("ImageSeedling")
                        Text(deviceStatus.currentSteps)
                            .font(.body)
                            .fontWeight(.semibold)
                    }
                }
                
                if deviceStatus.currentPpm < 4 {
                    alertItem(message: "⚠️ Nilai PPM **rendah**. Tambahkan larutan nutrisi")
                } else if deviceStatus.currentPpm > 10 {
                    alertItem(message: "⚠️ Nilai PPM **terlalu tinggi**. Kurangi larutan nutrisi")
                }
                
                if deviceStatus.currentPh < 4 {
                    alertItem(message: "⚠️ Nilai PH **rendah**. Tambahkan air")
                } else if deviceStatus.currentPh > 10 {
                    alertItem(message: "⚠️ Nilai PH **terlalu tinggi**. Kurangi air")
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
        .background(ColorConstants.secondaryColor)
        .clipShape(.rect(cornerRadius: 8))
        .padding(.top)
    }
}

#Preview {
    DevicesView(navigator: nil)
}
