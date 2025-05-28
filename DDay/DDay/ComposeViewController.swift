//
//  ComposeViewController.swift
//  DDay
//
//  Created by 박동언 on 5/27/25.
//

import UIKit

extension Notification.Name {
    static let eventDidInsert = Notification.Name("eventDidInsert")
}

class ComposeViewController: UIViewController {

    var data: ComposeData?

    var selectedBackgroundColorIndexPath: IndexPath?
    var selectedTextColorIndexPath: IndexPath?

    @IBOutlet weak var backgroundColorCollectionView: UICollectionView!
    @IBOutlet weak var textColorCollectionView: UICollectionView!
    @IBOutlet weak var titleField: UITextField!


    @IBAction func save(_ sender: Any) {
        guard let text = titleField.text else {
            return
        }

        data?.title = text
        // 데이터 검증
        // TODO: 경고창 등 입력값 없을 때 처리

        if let data {
            let event = Event(data: data)
            events.append(event)
        }

        NotificationCenter.default.post(name: .eventDidInsert, object: nil)
        dismiss(animated: true)
    }

    let colors: [UIColor] = [
        .systemRed,
        .systemOrange,
        .systemYellow,
        .systemGreen,
        .systemBlue,
        .systemPurple,
        .systemPink,
        .systemTeal,
        .systemIndigo,
        .systemGray,
        .black,
        .white
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // TODO: date picker를 선택하면 그선택한 색을 보여주는 방법 고민해보고 적용
    // TODO: 랜덤 컬러가 아니라 마지막에 선택했던 컬러가 선택되도록 수정
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        var item = Int.random(in: 0 ..< colors.count)
        selectedBackgroundColorIndexPath = IndexPath(item: item, section: 0)
        backgroundColorCollectionView.reloadData()

        item = Int.random(in: 0 ..< colors.count)
        selectedTextColorIndexPath = IndexPath(item: item, section: 0)
        textColorCollectionView.reloadData()
    }
}

extension ComposeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: ColorCollectionViewCell.self), for: indexPath) as! ColorCollectionViewCell

        if colors.count == indexPath.item {
            cell.colorImageView.image = UIImage(named: "color-picker")
            cell.colorImageView.tintColor = nil
        } else {
            // TODO: 템플릿 이미지 조사해보기
            cell.colorImageView.image = UIImage(named: "color-picker")?.withRenderingMode(.alwaysTemplate)
            cell.colorImageView.tintColor = colors[indexPath.item]
        }

        cell.checkmarkImageView.isHidden = true

        if let selectedBackgroundColorIndexPath, selectedBackgroundColorIndexPath == indexPath, collectionView == backgroundColorCollectionView {
            cell.checkmarkImageView.isHidden = false
        } else if let selectedTextColorIndexPath, selectedTextColorIndexPath == indexPath, collectionView == textColorCollectionView {
            cell.checkmarkImageView.isHidden = false
        }

        return cell
    }
}

extension ComposeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == colors.count {
            let colorPicker = UIColorPickerViewController()
            colorPicker.title = collectionView == backgroundColorCollectionView ? "배경색" : "글자색"
            colorPicker.supportsAlpha = false
            colorPicker.delegate = self

            present(colorPicker, animated: true)
        } else {
            let selectedColor = colors[indexPath.item]

            if collectionView == backgroundColorCollectionView {
                data?.backgroundColor = selectedColor
            } else {
                data?.textColor = selectedColor
            }

            dump(data)
        }

        if collectionView == backgroundColorCollectionView {
            if let selectedBackgroundColorIndexPath, selectedBackgroundColorIndexPath != indexPath {
                if let cell = collectionView.cellForItem(at: selectedBackgroundColorIndexPath) as? ColorCollectionViewCell {
                    cell.checkmarkImageView.isHidden = true
                }
            }

            selectedBackgroundColorIndexPath = indexPath
        } else {
            if let selectedTextColorIndexPath, selectedTextColorIndexPath != indexPath {
                if let cell = collectionView.cellForItem(at: selectedTextColorIndexPath) as? ColorCollectionViewCell {
                    cell.checkmarkImageView.isHidden = true
                }
            }

            selectedTextColorIndexPath = indexPath
        }

        if let cell = collectionView.cellForItem(at: indexPath) as? ColorCollectionViewCell {
            cell.checkmarkImageView.isHidden = false
        }
    }
}

extension ComposeViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
//        print(#function) // 나중에
    }

    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
//        print(#function, color, continuously) // 나중에
        if !continuously {
            if viewController.title == "배경색" {
                data?.backgroundColor = color
            } else {
                data?.textColor = color
            }

            print(data?.backgroundColor)
            print(data?.textColor)
        }
    }
}
