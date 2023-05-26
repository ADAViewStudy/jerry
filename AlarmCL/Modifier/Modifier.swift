//
//  Modifier.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/26.
//

import Foundation
import SwiftUI

let alphabet: [String] = {
    (65...90).map { String(UnicodeScalar($0)!) }
  }()

struct VerticalIndex: ViewModifier {
    let indexableList: [String]
    func body(content: Content) -> some View {
        var body: some View {
            ScrollViewReader { scrollProxy in
                ZStack {
                    content
                    VStack {
                        ForEach(indexableList, id: \.self) { letter in
                            HStack {
                                Spacer()
                                Button(action: {
                                    withAnimation {
                                        scrollProxy.scrollTo(letter)
                                    }
                                }, label: {
                                    Text(letter)
                                        .font(.system(size: 12))
                                        .padding(.trailing, 7)
                                })
                            }
                        }
                    }
                }
            }
        }
        return body
    }
}
