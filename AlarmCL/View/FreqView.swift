//
//  FreqView.swift
//  AlarmCL
//
//  Created by 주환 on 2023/05/20.
//

import SwiftUI

struct FreqView: View {
    
    var daysOfWeek = ["일", "월", "화", "수", "목", "금", "토"]
    @State private var selectedDays = Set<String>()
    @Binding var freq: String
    
    var body: some View {
        List(daysOfWeek, id: \.self) { day in
            Button(action: {
                if selectedDays.contains(day) {
                    selectedDays.remove(day)
                } else {
                    selectedDays.insert(day)
                }
            }) {
                HStack {
                    Text(day+"요일마다")
                    Spacer()
                    if selectedDays.contains(day) {
                        Image(systemName: "checkmark")
                    }
                }
            }
            .foregroundColor(.primary)
        }
        .onDisappear() {
            selectedDays.remove("")
            freq = weekdayToString(arr: selectedDays)
            print()
        }
        .onAppear() {
            let new = freq
            if let new = filterStringPattern(new) {
                selectedDays = stringToWeekday(st: new)
            } else {
                selectedDays = stringToWeekday(st: new)
            }
        }
        
    }
    func weekdayToString(arr: Set<String>) ->String {
        if arr.count == 1 {
            return arrayToString(array: Array(arr)) + "요일마다"
        }
        let result = arrayToString(array: sortWeek(cycle: Array(arr)))
        switch result {
        case "월 화 수 목 금":
            return "주중"
        case "토 일":
            return "주말"
        case "월 화 수 목 금 토 일":
            return "매일"
        default:
            return result
        }
    }
    
    func stringToWeekday(st: String) ->Set<String> {
        switch st {
        case "주중":
            return Set(stringToArray(string: "월 화 수 목 금"))
        case "주말":
            return Set(stringToArray(string: "토 일"))
        case "매일":
            return Set(stringToArray(string: "월 화 수 목 금 토 일"))
        default:
            return Set(stringToArray(string: st))
        }
    }
    
    func filterStringPattern(_ input: String) -> String? {
        let pattern = #"([일월화수목금토]+)요일마다"#
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: input.utf16.count)

        if let match = regex.firstMatch(in: input, options: [], range: range) {
            let matchedString = (input as NSString).substring(with: match.range(at: 1))
            return matchedString
        }
        
        return nil
    }




}




//struct FreqView_Previews: PreviewProvider {
//    static var previews: some View {
//        FreqView()
//            .environment(\.colorScheme, .dark) // here you can switch between .light and .dark
//            .accentColor(Color.orange) // here you can set your custom color
//    }
//}
