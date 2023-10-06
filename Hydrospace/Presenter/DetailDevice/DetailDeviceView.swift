//
//  DetailDeviceView.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 06/10/23.
//

import Foundation
import SwiftUI
import Charts

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
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 0) {
                Text("Terakhir diperbarui: 12.00")
                    .font(.subheadline)
                    .padding(.horizontal)
                
                HStack {
                    HStack(alignment: .bottom) {
                        Image("ImageSeedlingBig")
                        Text("Anakan")
                            .font(.body)
                            .fontWeight(.semibold)
                            .padding(.bottom)
                    }
                    .padding(.trailing, 80)
                    .padding(.top, 60)
                    
                    VStack(alignment: .leading, spacing: 2) {
                        Text("880")
                            .foregroundStyle(ColorConstants.primaryAccentColor)
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Text("ppm")
                        
                        Text("6")
                            .foregroundStyle(ColorConstants.primaryAccentColor)
                            .font(.title)
                            .fontWeight(.semibold)
                            .padding(.top, 14)
                        
                        Text("ph")
                    }
                }
                .padding(.horizontal)
                .padding(.top)
                
                Rectangle()
                    .foregroundStyle(ColorConstants.backgroundColor)
                    .frame(height: 16)
                
                alertItem
                alertItem
                
                Rectangle()
                    .foregroundStyle(ColorConstants.backgroundColor)
                    .frame(height: 16)
                    .padding(.top)
                
                VStack(alignment: .leading) {
                    Text("Hari Ini")
                        .font(.body)
                        .fontWeight(.semibold)
                    
                    VStack(alignment: .leading, spacing: 14) {
                        HStack(spacing: 0) {
                            Text("Kepekatan Nutrisi ")
                            Text("(ppm)")
                                .foregroundStyle(ColorConstants.onSurfaceLowColor)
                        }
                        .font(.callout)
                        
                        Chart(NutritionHistoryModel.nutritionHistoriesDummy) {
                            LineMark(
                                x: .value("Jam", $0.hour),
                                y: .value("Kepekatan (PPM)", $0.ppm)
                            )
                            .foregroundStyle(ColorConstants.primaryAccentColor)
                        }
                    }
                    .padding()
                    .background(ColorConstants.surfaceContainerHighColor)
                    .clipShape(.rect(cornerRadius: 8))
                }
                .padding()
                
                Rectangle()
                    .foregroundStyle(ColorConstants.backgroundColor)
                    .frame(height: 16)
                    .padding(.top)
            }
        }
        .navigationTitle("Perangkat 1")
        .navigationBarTitleDisplayMode(.large)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "chevron.left")
                        .foregroundStyle(ColorConstants.primaryAccentColor)
                        .fontWeight(.semibold)
                }
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "gearshape.fill")
                    .foregroundStyle(ColorConstants.primaryAccentColor)
                    .fontWeight(.semibold)
            }
        }
    }
    
    var alertItem: some View {
        HStack {
            VStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text("􀇿 Nilai PPM rendah")
                        .font(.caption)
                        .fontWeight(.semibold)
                    
                    Text("Tambahkan larutan nutrisi B sebanyak 100ml untuk menjaga keseimbangan nutrisi")
                        .font(.caption)
                    
                    Button {
                        
                    } label: {
                        Text("Sudah Perbaiki Larutan")
                            .frame(maxWidth: .infinity)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(ColorConstants.primaryAccentColor)
                }
            }
            
            Spacer()
        }
        .padding()
        .background(ColorConstants.secondaryColor)
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
