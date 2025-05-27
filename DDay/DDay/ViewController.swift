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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EventTableViewCell.self), for: indexPath) as! EventTableViewCell

        let target = events[indexPath.row]
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
