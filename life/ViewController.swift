import UIKit

//let glider = [(1, 0), (2, 1), (0, 2), (1, 2), (2, 2)]
let glider = Cells([Cell(3, 2), Cell(4, 3), Cell(2, 4), Cell(3, 4), Cell(4, 4)])

extension IndexPath {
    static func from(cell: Cell) -> IndexPath {
        return IndexPath(item: cell.x + (cell.y * 27), section: 0)
    }
}

class ViewController: UIViewController {
    private let life = Life()
    private let initialLiveCellsState: Cells = glider
    private let numberOfCells = 1024
    private var aliveCells: [IndexPath] = []
    private var collectionView: UICollectionView!
    private var numberOfCellsPerRow: Int = 27
    private var timer: Timer?

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        view.backgroundColor = .red

        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.register(MyCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.isMultipleTouchEnabled = true
        view.addSubview(collectionView)

        collectionView.pinToSuperViewEdges()
        var newcells = self.life.tick(cells: initialLiveCellsState)

        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
            newcells = self.life.tick(cells: newcells)
            newcells.forEach {
                let indexPath = IndexPath.from(cell: $0)
                self.collectionView.delegate?.collectionView?(self.collectionView, didSelectItemAt: indexPath)
            }
        })
    }
}


extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
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

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .zero
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
        let width = collectionView.frame.size.width / CGFloat(numberOfCellsPerRow)
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

