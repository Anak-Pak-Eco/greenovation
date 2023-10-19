//
//  DetailDeviceView.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 06/10/23.
//

import Foundation
import SwiftUI
import Charts

// TODO: This struct is dummy and should be move to domain model
struct NutritionHistoryModel: Identifiable {
    let id: UUID = UUID()
    let hour: String
    let ppm: Double
    
    static let nutritionHistoriesDummy = [
        NutritionHistoryModel(hour: "00.00", ppm: 700),
        NutritionHistoryModel(hour: "03.00", ppm: 800),
        NutritionHistoryModel(hour: "06.00", ppm: 900),
        NutritionHistoryModel(hour: "09.00", ppm: 400),
        NutritionHistoryModel(hour: "12.00", ppm: 500),
        NutritionHistoryModel(hour: "15.00", ppm: 600),
        NutritionHistoryModel(hour: "18.00", ppm: 300)
    ]
}

struct DetailDeviceView: View {
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject private var viewModel = DetailDeviceViewModel()
    
    private var controller: NavigatorDelegate?
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            } else if let deviceStatus = viewModel.deviceStatus {
                LazyVStack(alignment: .leading, spacing: 0) {
                    Text("caisim")
                        .font(.customTitle3Bold)
                        .foregroundStyle(.primaryAccent)
                        .padding(.horizontal)
                    
                    HStack {
                        HStack(alignment: .bottom) {
                            Image("image-anakan")
                            Text(viewModel.deviceStatus?.currentSteps ?? "")
                                .font(.body)
                                .padding(.bottom)
                        }
                        .padding(.top, 60)
                        
                        VStack(alignment: .leading, spacing: 2) {
                            Text("\(String(format: "%.2f", viewModel.deviceStatus?.currentPpm ?? 0))")
                                .foregroundStyle(.primaryAccent)
                                .font(.customTitle1Bold)
                            
                            Text("ppm")
                                .font(.title3)
                                .padding(.bottom)
                            
                            Text("\(String(format: "%.2f", viewModel.deviceStatus?.currentPh ?? 0))")
                                .foregroundStyle(.primaryAccent)
                                .font(.customTitle1Bold)
                            
                            Text("ph")
                                .font(.title3)
                                .padding(.bottom)
                        }
                        .padding(.leading, 80)
                    }
                    .padding(.horizontal)
                    .padding(.top)
                    
                    Rectangle()
                        .foregroundStyle(.surface)
                        .frame(height: 16)
                    
                    if deviceStatus.currentPpm < 4 {
                        alertItem(
                            title: "\(Image(systemName: "exclamationmark.triangle.fill")) Nilai PPM rendah",
                            message: "Tambahkan larutan nutrisi B sebanyak 100ml untuk menjaga keseimbangan nutrisi.",
                            onButtonClicked: {
                                print("Clicked Button")
                            }
                        )
                    } else if deviceStatus.currentPpm > 10 {
                        alertItem(
                            title: "\(Image(systemName: "exclamationmark.triangle.fill")) Nilai PPM terlalu tinggi",
                            message: "Kurangi larutan nutrisi.",
                            onButtonClicked: {
                                print("Clicked Button")
                            }
                        )
                    }
                    
                    if deviceStatus.currentPh < 4 {
                        alertItem(
                            title: "\(Image(systemName: "exclamationmark.triangle.fill")) Nilai PH rendah",
                            message: "Tambahkan air",
                            onButtonClicked: {
                                print("Clicked Button")
                            }
                        )
                    } else if deviceStatus.currentPh > 10 {
                        alertItem(
                            title: "\(Image(systemName: "exclamationmark.triangle.fill")) Nilai PH terlalu tinggi",
                            message: "Kurangi air.",
                            onButtonClicked: {
                                print("Clicked Button")
                            }
                        )
                    }
                    
                    if (deviceStatus.currentPh < 4 || deviceStatus.currentPh > 10) || (deviceStatus.currentPpm < 4 || deviceStatus.currentPpm > 10) {
                        Rectangle()
                            .foregroundStyle(.surface)
                            .frame(height: 16)
                            .padding(.top)
                    }
                    
                    VStack(alignment: .leading) {
                        Text("today")
                            .font(.customBodyBold)
                        
                        VStack(alignment: .leading, spacing: 14) {
                            HStack(spacing: 0) {
                                Text("nutrient-density")
                                Text(" (\(String(localized: "ppm")))")
                                    .foregroundStyle(.onSurfaceLow)
                            }
                            .font(.callout)
                            
                            Chart(NutritionHistoryModel.nutritionHistoriesDummy) {
                                LineMark(
                                    x: .value("Jam", $0.hour),
                                    y: .value("Kepekatan (PPM)", $0.ppm)
                                )
                                .foregroundStyle(.primaryAccent)
                            }
                        }
                        .padding()
                        .background(.surfaceContainerHigh)
                        .clipShape(.rect(cornerRadius: 8))
                    }
                    .padding()
                    
                    Rectangle()
                        .foregroundStyle(.surface)
                        .frame(height: 16)
                        .padding(.top)
                }
            }
        }
        .navigationTitle(viewModel.deviceStatus?.name ?? "")
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
            
            ToolbarItem(placement: .topBarTrailing) {
//                NavigationLink(destination: SettingDeviceView()) {
                    Image(systemName: "gearshape.fill")
                        .foregroundStyle(.primaryAccent)
                        .fontWeight(.semibold)
//                }
            }
        }
        .onAppear {
            viewModel.initData()
        }
    }
    
    func alertItem(title: LocalizedStringKey, message: LocalizedStringKey, onButtonClicked: @escaping () -> Void) -> some View {
        HStack {
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(title)
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text(message)
                        .font(.caption)
                    
                    Button {
                        onButtonClicked()
                    } label: {
                        Text("sollution-corrected")
                            .frame(maxWidth: .infinity)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(.primaryAccent)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(.secondaryContainer)
        .clipShape(.rect(cornerRadius: 8))
        .padding(.horizontal)
        .padding(.top)
    }
}

#Preview("Detail Device") {
    NavigationStack {
        DetailDeviceView()
    }
}
