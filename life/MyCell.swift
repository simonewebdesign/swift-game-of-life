import UIKit

class MyCell: UICollectionViewCell {
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? UIColor.white : UIColor.black
        }
    }
}
