//
//  NotificationView.swift
//  Hydrospace
//
//  Created by Naufal Fawwaz Andriawan on 06/10/23.
//

import Foundation
import SwiftUI

struct NotificationView: View {
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(1...100, id: \.self) { _ in
                    Text("notification-view-title")
                }
            }
        }
        .background(.surface)
    }
}

#Preview {
    NotificationView()
}
