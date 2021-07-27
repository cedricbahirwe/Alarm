//
//  LoaderView.swift
//  Alarmo
//
//  Created by Cédric Bahirwe on 27/07/2021.
//

import SwiftUI

struct LoaderView: View {
    var body: some View {
            ProgressView(value: 0.5)
                .progressViewStyle(CircularProgressViewStyle(tint: .gray))
                .scaleEffect(1.2)
    }
}

struct LoaderView_Previews: PreviewProvider {
    static var previews: some View {
        LoaderView()
            .previewLayout(.fixed(width: 50, height: 50))
    }
}
