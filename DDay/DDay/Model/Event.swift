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
}
