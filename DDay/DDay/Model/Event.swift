//
//  Event.swift
//  DDay
//
//  Created by 박동언 on 5/27/25.
//

import UIKit

struct Event {
    let date: Date
    let title: String
    let backgroundColor: UIColor
    let textColor: UIColor
    let icon: String
}

extension Event {
    var dayString: String? {
        guard let day = date.days(from: Date.today) else { return nil }

        if day >= 0 {
            return "D-\(abs(day))"
        } else {
            return "D+\(abs(day))"
        }
    }

    var dateString: String? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }

    var iconImage: UIImage? {
        return UIImage(named: icon)
    }
    
}


var events = [
    Event(date: Date(year: 2002, month: 5, day: 31), title: "한일 월드컴", backgroundColor: .systemBlue, textColor: .white, icon: "football"),
    Event(date: Date(year: 2022, month: 11, day: 20), title: "카타르 월드컴", backgroundColor: .brown, textColor: .white, icon: "football"),
    Event(date: Date(year: 2026, month: 6, day: 11), title: "북중미 월드컴", backgroundColor: .green, textColor: .black, icon: "football"),
    Event(date: Date(year: 2025, month: 8, day: 14), title: "내 생일", backgroundColor: .yellow, textColor: .red, icon: "birthday")
]
