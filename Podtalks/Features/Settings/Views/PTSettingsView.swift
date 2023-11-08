//
//  PTSettingsView.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 08/11/23.
//

import SwiftUI

struct PTSettingsView: View {
    
    let viewModel: SettingsViewModel
    
    init(viewModel: SettingsViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.settings) { setting in
            HStack {
                if let image = setting.image {
                    Image(uiImage: image)
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(Color.white)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color.red)
                        .padding(8)
                        .background(Color(setting.iconContainerColor))
                        .cornerRadius(6)
                }
                Text(setting.title)
                    .padding(.leading, 10)
                
                Spacer()
            }
            .padding(.bottom, 3)
            .onTapGesture {
                setting.onTapHandler(setting.type)
            }
        }
    }
}

struct PTSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PTSettingsView(
            viewModel: .init(settings: PTSettingsOption.allCases.compactMap({
                PTSettings(type: $0) { _ in }
            }))
        )
    }
}
