//
//  TahapPertumbuhanButtomView.swift
//  Hydrospace
//
//  Created by Leonardo Jose Gunawan on 19/10/23.
//

import SwiftUI

struct TahapPertumbuhanButtomView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var model = PendaftaranPerangkatModel()
    
    let plantName: String
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.surface.edgesIgnoringSafeArea(.all)
                VStack {
                    ForEach(model.growthStages) { growth in
                        VStack {
                            NavigationLink(destination: FormulaBottomView(phaseName: growth.name, plantName: plantName)) {
                                HStack (alignment: .center, spacing: 0) {
                                    Image(growth.imageName)
                                        .resizable()
                                        .frame(width: 61, height: 61)
                                        .cornerRadius(10)
                                    VStack (alignment: .leading) {
                                        Text(LocalizedStringKey(growth.name))
                                            .font(.customCalloutSemiBold)
                                        Text(LocalizedStringKey(growth.description))
                                            .font(.customFootnoteRegular)
                                            .multilineTextAlignment(.leading)
                                    }
                                    .padding(.leading)
                                    .padding(.trailing, 2)
                                    Spacer()
                                    Image("fill-circle")
                                        .resizable()
                                        .frame(width: 25, height: 25)
                                }
                            }
                            
                        }
                        .padding(.leading)
                        .padding(.trailing)
                        Divider()
                    }
                    //            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    //            .edgesIgnoringSafeArea(.all)
                    //            .listStyle(GroupedListStyle())
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Text("tahap-pertumbuhan")
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
                                .font(.customCalloutSemiBold)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    TahapPertumbuhanButtomView(plantName: "")
}
