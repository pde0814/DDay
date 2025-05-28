//
//  ViewController.swift
//  DDay
//
//  Created by 박동언 on 5/27/25.
//

import UIKit

// 셀에 있는 뷰와 아웃렛을 연결할 때에는 셀 클래스와 연결해야한다.
// 테이블 뷰는 샐의 높이를 자동으로 계산하고 필요한 높이로 표시해준다. Self-sizing
// 셀을 디자인 할 때는, (제약을 추가할 때는) 반드시 높이가 정상적으로 계산되도록 추가해야한다

class ViewController: UIViewController {

    @IBOutlet weak var eventTableView: UITableView!

    var sortedEvents = [Event]()
    // 사용자가 입력한거 저장해놓아야하고
    // userdefault를 사용
    // file이나 큰데이터는 저장 x
    var sortType: SortType {
        let type = UserDefaults.standard.integer(forKey: "sort")
        return SortType(rawValue: type) ?? .futureFirst
    }

    @IBAction func toggleSort(_ sender: Any) {
        sortType.toggle()

        switch sortType {
        case .futureFirst:
            sortedEvents = events.sorted { $0.daysLeft > $1.daysLeft }
        case .pastFirst:
            sortedEvents = events.sorted { $0.daysLeft < $1.daysLeft }
        }

        eventTableView.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        switch sortType {
        case .futureFirst:
            sortedEvents = events.sorted { $0.daysLeft > $1.daysLeft }
        case .pastFirst:
            sortedEvents = events.sorted { $0.daysLeft < $1.daysLeft }
        }

        eventTableView.reloadData()

        NotificationCenter.default.addObserver(forName: .eventDidInsert, object: nil, queue: .main) { [weak self] _ in
            self?.eventTableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedEvents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventTableViewCell.self), for: indexPath) as! EventTableViewCell

        let target = sortedEvents[indexPath.row]
        cell.iconImageView.image = target.iconImage
        cell.titleLabel.text = target.title
        cell.dateLabel.text = target.dateString
        cell.daysLabel.text = target.dayString
        cell.containerView.backgroundColor = target.backgroundColor
        cell.titleLabel.textColor = target.textColor
        cell.dateLabel.textColor = cell.titleLabel.textColor
        cell.daysLabel.textColor = cell.titleLabel.textColor

        return cell
    }
    

}
