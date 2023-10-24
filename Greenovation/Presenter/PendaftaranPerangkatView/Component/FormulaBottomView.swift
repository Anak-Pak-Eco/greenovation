//
//  FormulaBottomView.swift
//  Hydrospace
//
//  Created by Leonardo Jose Gunawan on 20/10/23.
//

import SwiftUI

struct FormulaBottomView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var selectedFormulation = 0
    
    @State private var ppmMinString: String = ""
    @State private var ppmMaxString: String = ""
    @State private var phMinString: String = ""
    @State private var phMaxString: String = ""
    
    let phaseName: String
    let plantName: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.surface.ignoresSafeArea(.all)
                VStack (alignment: .leading, spacing: 0) {
                    
                    VStack (alignment: .center, spacing: 0) {
                        Picker("FormulationPicker", selection: $selectedFormulation) {
                            Text("formula-saya").tag(0)
                            Text("rekomendasi").tag(1)
                        }
                        .pickerStyle(.segmented)
                        .listRowBackground(Color.onSecondaryContainer)
                    }
                    .padding(.bottom)
                    
                    VStack (alignment: .leading) {
                        if selectedFormulation == 0 {
                            Text("Formula di bawah ini merupakan formula yang kamu buat untuk **\(plantName)** pada **\(Text(LocalizedStringKey(phaseName)))**")
                                .multilineTextAlignment(.leading)
                                .font(.customCaption1)
                                .padding(.bottom)
                            FormulaFieldView(ppmMinString: $ppmMinString, ppmMaxString: $ppmMaxString, phMinString: $phMinString, phMaxString: $phMaxString)
                        } else {
                            Text("Berikut merupakan rekomendasi dari **Hydrospace** untuk **\(plantName)** pada **\(Text(LocalizedStringKey(phaseName)))**")
                                .multilineTextAlignment(.leading)
                                .font(.customCaption1)
                                .padding(.bottom)
                            FormulaFieldRecommendationView(ppmMinString: $ppmMinString, ppmMaxString: $ppmMaxString, phMinString: $phMinString, phMaxString: $phMaxString)
                        }
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        dismiss()
                        dismiss()
                    }, label: {
                        Text("simpan-pilihan")
                            .frame(maxWidth: .infinity)
                            .font(.customBodyBold)
                            .foregroundStyle(.white)
                    })
                    .padding(.all)
                    .buttonStyle(.borderedProminent)
                    .tint(.primaryAccent)
                }
                .padding()
                .navigationBarBackButtonHidden()
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("pilih-satu-formula")
                            .font(.customTitle3Bold)
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            dismiss()
                            dismiss()
                        } label: {
                            Image(systemName: "x.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundStyle(.primaryAccent)
                                .font(.customCalloutSemiBold)
                        }
                    }
                }
            }
        }
    }
}

struct FormulaFieldView: View {
    
    @State var formulation: Bool = false
    
    @Binding var ppmMinString: String
    @Binding var ppmMaxString: String
    @Binding var phMinString: String
    @Binding var phMaxString: String
    
    var body: some View {
        VStack {
            if formulation {
                HStack {
                    Text("**kepekatan-nutrisi** (ppm)")
                        .font(.customSubheadline)
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
            } else {
                HStack {
                    Text("**kepekatan-nutrisi** (ppm)")
                        .font(.customSubheadline)
                    Spacer()
                    TextField("min", text: $ppmMinString)
                        .multilineTextAlignment(.center)
                        .frame(width: 65, height: 34)
                        .background(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.primaryAccent, lineWidth: 2)
                            )
                    Text("-")
                    TextField("max", text: $ppmMaxString)
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
                    TextField("min", text: $ppmMinString)
                        .multilineTextAlignment(.center)
                        .frame(width: 65, height: 34)
                        .background(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.primaryAccent, lineWidth: 2)
                            )
                    Text("-")
                    TextField("max", text: $ppmMaxString)
                        .multilineTextAlignment(.center)
                        .frame(width: 65, height: 34)
                        .background(.white)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .strokeBorder(Color.primaryAccent, lineWidth: 2)
                            )
                }
            }
        }
        
    }
}

struct FormulaFieldRecommendationView: View {
    
    @State var formulation: Bool = true
    
    @Binding var ppmMinString: String
    @Binding var ppmMaxString: String
    @Binding var phMinString: String
    @Binding var phMaxString: String
    
    var body: some View {
        VStack {
            HStack {
                Text("**kepekatan-nutrisi** (ppm)")
                    .font(.customSubheadline)
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
    }
}

#Preview {
    FormulaBottomView(phaseName: "", plantName: "")
}
