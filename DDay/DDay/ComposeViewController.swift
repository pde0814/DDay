//
//  ComposeViewController.swift
//  DDay
//
//  Created by 박동언 on 5/27/25.
//

import UIKit

class ComposeViewController: UIViewController {

    @IBOutlet weak var backgroundColorCollectionView: UICollectionView!
    @IBOutlet weak var textColorCollectionView: UICollectionView!
    @IBOutlet weak var titleField: UITextField!


    @IBAction func save(_ sender: Any) {

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

        return cell
    }
    

}

