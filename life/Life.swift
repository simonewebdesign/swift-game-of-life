typealias Cells = [Cell]

//struct Cell: Hashable {
//    let x: Int
//    let y: Int
//}

typealias Cell = (x: Int, y: Int)

struct Life {
    // these are the numbers to add/subtract from a coordinate in order
    // to get the relative neighbour
    static let offsets: Cells =             [(-1, -1), (-1, 0), (-1, 1), (0, -1),         (0, 1), (1, -1), (1, 0), (1, 1)]
    static let offsetsIncludingOwn: Cells = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 0), (0, 1), (1, -1), (1, 0), (1, 1)]


    private func aliveCellAndNeighbors(_ cells: Cells) -> Cells {
        return cells.reduce([]) { cells2, c1 in
            return Life.offsets.reduce(cells2) { cells3, c2 in
                let newCell = (c1.x + c2.x, c1.y + c2.y)
                return cells3 + [newCell]
            }
        }
    }

    private func shouldLive(isAlive: Bool, numOfNeighbors: Int) -> Bool {
        return (numOfNeighbors == 2 && isAlive) || numOfNeighbors == 3
    }

    private func neighborsCount(_ cells: Cells, _ cell: Cell) -> Int {
        return Life.offsets.reduce(0) { acc, c in
            let x = cell.0 + c.0
            let y = cell.1 + c.1
            let myCell = Cell(x: x, y: y)

            if cells.contains(cell: myCell) {
                return acc + 1
            } else {
                return acc
            }
        }
    }
}

extension Array where Element == Cell {
    func contains(cell: Cell) -> Bool {
        return contains(where: { $0.x == cell.x && $0.y == cell.y })
    }
}
