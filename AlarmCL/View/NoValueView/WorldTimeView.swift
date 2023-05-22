//
//  WorldTimeView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/16.
//

import SwiftUI

struct WorldTimeView: View {
    var body: some View {
        VStack {
            Text("WorldTimeView")
        }
    }
}

struct WorldTimeView_Previews: PreviewProvider {
    static var previews: some View {
        WorldTimeView()
            .environment(\.colorScheme, .dark)
            .accentColor(Color.orange)
    }
}
