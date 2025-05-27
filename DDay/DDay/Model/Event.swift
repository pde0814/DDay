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

    var dayString: String?
    var dateString: String?
    var iconImage: UIImage?

    init(date: Date, title: String, backgroundColor: UIColor, textColor: UIColor, icon: String) {
        self.date = date
        self.title = title
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.icon = icon

        if let day = date.days(from: Date.today) {
            dayString = if day >= 0 { "D-\(abs(day))" } else { "D+\(abs(day))" }
        } else {
            dayString = nil
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        dateString = formatter.string(from: date)

        iconImage = UIImage(named: icon)
    }
}

var events = [
    Event(date: Date(year: 2002, month: 5, day: 31), title: "한일 월드컵", backgroundColor: .systemBlue, textColor: .white, icon: "football"),
    Event(date: Date(year: 2022, month: 11, day: 20), title: "카타르 월드컵", backgroundColor: .brown, textColor: .white, icon: "football"),
    Event(date: Date(year: 2026, month: 6, day: 11), title: "북중미 월드컵", backgroundColor: .green, textColor: .black, icon: "football"),
    Event(date: Date(year: 2025, month: 8, day: 14), title: "내 생일", backgroundColor: .yellow, textColor: .red, icon: "birthday")
]
