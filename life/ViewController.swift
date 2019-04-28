//
//  ViewController.swift
//  life
//
//  Created by Owen Worley on 04/03/2019.
//  Copyright © 2019 lifeorg. All rights reserved.
//

import UIKit

//let glider = [(1, 0), (2, 1), (0, 2), (1, 2), (2, 2)]
let initialGlider = [
    IndexPath(item: 1, section: 0),
    IndexPath(item: 6, section: 0),
    IndexPath(item: 8, section: 0),
    IndexPath(item: 9, section: 0),
    IndexPath(item: 10, section: 0),
]

//extension IndexPath {
//    func from(cell: Cell) {
//        return IndexPath(item: , section: <#T##Int#>)
//    }
//}

class ViewController: UIViewController {
    private let cells: [UIView] = []
//    private var aliveCells: [IndexPath] = Life.initialGlider
    private var aliveCells: [IndexPath] = [IndexPath(item: 0, section: 0), IndexPath(item: 1, section: 0)]
    private var collectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        view.backgroundColor = .red

        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.isMultipleTouchEnabled = true
        view.addSubview(collectionView)

        collectionView.pinToSuperViewEdges()
    }
}

extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 316 // cells.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.isSelected = false
        aliveCells.forEach {
            if $0 == indexPath {
                cell.isSelected = true
            }
        }
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let duplicate = aliveCells.firstIndex(of: indexPath) else {
            aliveCells.append(indexPath)
            collectionView.reloadItems(at: [indexPath])
            return
        }
        aliveCells.remove(at: duplicate)
        collectionView.reloadItems(at: [indexPath])
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width / 32
        return CGSize(width: width, height: width)
    }
}

extension UIView {
    func pinToSuperViewEdges() {
        guard let superview = superview else {
            assertionFailure("should have superview")
            return
        }

        NSLayoutConstraint.activate([
            widthAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.widthAnchor),
            heightAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.heightAnchor),
            leadingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.safeAreaLayoutGuide.trailingAnchor)
        ])
    }
}

