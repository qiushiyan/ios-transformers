//
//  LoadingView.swift
//  TransformerDemo
//
//  Created by qiushi on 11/25/22.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(
                CircularProgressViewStyle(tint: Color("Info")))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
