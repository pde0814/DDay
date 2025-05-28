//
//  SortType.swift
//  DDay
//
//  Created by 박동언 on 5/28/25.
//

import Foundation

enum SortType: Int {
    case futureFirst
    case pastFirst

    func toggle() {
        switch self {
        case .futureFirst:
            UserDefaults.standard.set(SortType.pastFirst.rawValue, forKey: "sort")
        case .pastFirst:
            UserDefaults.standard.set(SortType.futureFirst.rawValue, forKey: "sort")
        }
    }
}
