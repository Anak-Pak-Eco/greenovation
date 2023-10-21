//
//  PendaftaranPerangkatView.swift
//  Hydrospace
//
//  Created by Leonardo Jose Gunawan on 19/10/23.
//

import SwiftUI

struct PendaftaranPerangkatView: View {
    @Environment(\.dismiss) var dismiss
    @State private var isOverlayVisible = false
    @State private var showingSheets = false
    
    @State private var deviceName = ""
    @State private var plantName = ""
    @State private var growthStage = ""
    
    @State private var ppmMinString: String = ""
    @State private var ppmMaxString: String = ""
    @State private var phMinString: String = ""
    @State private var phMaxString: String = ""
    
    private var model = PendaftaranPerangkatModel()
    
    var isSaved = false
    
    @State private var emptyPlants: [Plant] = []
    
    var filteredPlants: [Plant] {
        if plantName.isEmpty {
            return emptyPlants
        } else {
            return model.plants.filter { $0.name.lowercased().contains(plantName.lowercased()) }
        }
    }
    
    var body: some View {
        VStack {
            
            // MARK: DEVICE NAME FIELD
            VStack (alignment: .leading, content: {
                VStack (alignment: .leading, content: {
                    Text("nama-perangkat")
                        .font(.customCalloutSemiBold)
                        .foregroundStyle(.primaryAccent)
                    TextField("", text: $deviceName)
                        .padding(.all, 12)
                        .background(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.secondaryAccent, lineWidth: 2)
                            )
                })
                
                // MARK: SEARCH FOR PLANT FIELD
                VStack {
                    VStack(alignment: .leading, content: {
                        Text("cari-tanaman")
                            .font(.customCalloutSemiBold)
                            .foregroundStyle(.primaryAccent)
                        HStack {
                            TextField("jenis-tanaman", text: $plantName)
                                .onChange(of: plantName) {
                                    self.isOverlayVisible = true
                                }
                                .padding(.all, 12)
                                .background(.white)
                                .overlay(
                                    Image(systemName: "magnifyingglass")
                                        .foregroundStyle(Color.secondaryAccent)
                                        .fontWeight(.semibold)
                                        .padding(.trailing)
                                    , alignment: .trailing

                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(Color.secondaryAccent, lineWidth: 2)
                                    )
                        }
                    })
                    .padding(.top)

                }
//                .onTapGesture {
//                    self.isOverlayVisible.toggle()
//                }
                ZStack {
                    
                    VStack {
                        if isOverlayVisible {
                            if filteredPlants.isEmpty {
                                VStack(alignment: .leading) {
                                    Text("tanaman-tidak-ditemukan")
                                    Button(action: {
                                        self.isOverlayVisible = false
                                    }) {
                                        Text("tambah-pengaturan-baru")
                                            .frame(maxWidth: .infinity)
                                            .font(.customBodyBold)
                                            .foregroundStyle(.white)
                                    }
                                    .buttonStyle(.borderedProminent)
                                    .tint(.primaryAccent)
                                }
                                .padding(.all)
                                .background(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .strokeBorder(Color.secondaryAccent, lineWidth: 2)
                                )
                            } else {
//                                ScrollView {
                                    ForEach(filteredPlants) { plant in
                                        HStack {
                                            Image("\(plant.imageName)")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .cornerRadius(10)
                                            Text("\(plant.name)")
                                            Spacer()
                                        }
                                        .padding(.all)
                                        .background(.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 10)
                                                .strokeBorder(Color.secondaryAccent, lineWidth: 2)
                                        )
                                        .onTapGesture {
                                            self.plantName = plant.name
                                            self.isOverlayVisible = false
                                        }
                                    }
                                    .listStyle(PlainListStyle())
                                    .background(Color.clear)
//                                }
                            }
                        }
                    }
                    .zIndex(1)
                    
                    // MARK: GROWTH STEP FIELD
                    VStack (alignment: .leading, content: {
                        Text("tahap-pertumbuhan")
                            .font(.customCalloutSemiBold)
                            .foregroundStyle(.primaryAccent)
                        TextField("fase-anakan", text: $growthStage)
                            .tint(Color.clear)
                            .padding(.all, 12)
                            .background(.white)
                            .overlay(
                                Image(systemName: "chevron.down")
                                    .foregroundStyle(Color.secondaryAccent)
                                    .fontWeight(.semibold)
                                    .padding(.trailing)
                                , alignment: .trailing

                            )
                            .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .strokeBorder(Color.secondaryAccent, lineWidth: 2)
                                )
                            .onTapGesture {
                                self.showingSheets = true
                            }
                    })
                    .padding(.top)
                    .sheet(isPresented: $showingSheets) {
                        TahapPertumbuhanButtomView(plantName: plantName)
                            .presentationDetents([.height(360)])
                    }
                    
                }
                
                if isSaved == true {
                    formulaView(plantName: plantName, phaseName: growthStage, ppmMinString: $ppmMinString, ppmMaxString: $ppmMaxString, phMinString: $phMinString, phMaxString: $phMaxString)
                }
                
            })
            .padding()
            Spacer()
            Button(action: {
                
            }, label: {
                Text("simpan")
                    .frame(maxWidth: .infinity)
                    .font(.customBodyBold)
                    .foregroundStyle(.white)
            })
            .padding(.all)
            .buttonStyle(.borderedProminent)
            .tint(.primaryAccent)
        }
        .background(Color.surface)
        .navigationTitle("pendaftaran-perangkat")
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
    }
}

struct formulaView: View {
    var plantName: String
    var phaseName: String
    
    @Binding var ppmMinString: String
    @Binding var ppmMaxString: String
    @Binding var phMinString: String
    @Binding var phMaxString: String
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            VStack (alignment: .leading, spacing: 0) {
                Text("pilihan-saya")
                    .font(.customSubheadlineBold)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(.secondaryContainer)
            
            VStack (alignment: .leading, spacing: 0) {
                Text("rekomendasi")
                    .font(.customFootnoteRegular)
                    .padding(.bottom)
                Text("Berikut merupakan rekomendasi dari **Hydrospace** untuk **\(plantName)** pada **\(Text(LocalizedStringKey(phaseName)))**")
                    .multilineTextAlignment(.leading)
                    .font(.customCaption1)
                    .padding(.bottom)
                HStack {
                    Text("**kepekatan-nutrisi** (ppm)")
                        .font(.customSubheadline)
                        .multilineTextAlignment(.leading)
                    Spacer()
                    TextField("750.00", text: $ppmMinString)
                        .multilineTextAlignment(.center)
                        .frame(width: 65, height: 34)
                        .background(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.primaryAccent, lineWidth: 2)
                            )
                    Text("-")
                    TextField("1200.00", text: $ppmMaxString)
                        .multilineTextAlignment(.center)
                        .frame(width: 65, height: 34)
                        .background(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.primaryAccent, lineWidth: 2)
                            )
                }
                .padding(.bottom)
                HStack {
                    Text("**tingkat-ph**")
                        .font(.customSubheadline)
                    Spacer()
                    TextField("5.5", text: $ppmMinString)
                        .multilineTextAlignment(.center)
                        .frame(width: 65, height: 34)
                        .background(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.primaryAccent, lineWidth: 2)
                            )
                    Text("-")
                    TextField("7.5", text: $ppmMaxString)
                        .multilineTextAlignment(.center)
                        .frame(width: 65, height: 34)
                        .background(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.primaryAccent, lineWidth: 2)
                            )
                }
            }
            .padding()
            .background(Color.white)
        }
        .cornerRadius(8)
    }
}


#Preview {
    PendaftaranPerangkatView()
}
