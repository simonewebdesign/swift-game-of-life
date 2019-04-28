typealias Cells = Set<Cell>

struct Cell: Hashable {
    let x: Int
    let y: Int

    init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

struct Life {
    // these are the numbers to add/subtract from a coordinate in order
    // to get the relative neighbour
    static let offsets: Cells = [Cell(-1, -1), Cell(-1, 0), Cell(-1, 1), Cell(0, -1), Cell(0, 1), Cell(1, -1), Cell(1, 0), Cell(1, 1)]
    static let offsetsIncludingOwn: Cells = [Cell(-1, -1), Cell(-1, 0), Cell(-1, 1), Cell(0, -1), Cell(0, 0), Cell(0, 1), Cell(1, -1), Cell(1, 0), Cell(1, 1)]

    static let initialGlider: Cells = []

    func tick(cells: Cells) -> Cells {
        return aliveCellAndNeighbors(cells).reduce(Set<Cell>()) { acc, cell in
            let isAlive = cells.contains(cell)
            let numOfNeighbors = neighborsCount(cells, cell)

            if (shouldLive(isAlive: isAlive, numOfNeighbors: numOfNeighbors)) {
                var set = acc
                set.insert(cell)
                return set
            } else {
                return acc
            }
        }
    }

    private func aliveCellAndNeighbors(_ cells: Cells) -> Cells {
        return cells.reduce([]) { cells2, c1 in
            return Life.offsets.reduce(cells2) { cells3, c2 in
                var set = cells3
                let newCell = Cell(c1.x + c2.x, c1.y + c2.y)
                set.insert(newCell)
                return set
            }
        }
    }

    private func shouldLive(isAlive: Bool, numOfNeighbors: Int) -> Bool {
        return (numOfNeighbors == 2 && isAlive) || numOfNeighbors == 3
    }

    private func neighborsCount(_ cells: Cells, _ cell: Cell) -> Int {
        return Life.offsets.reduce(0) { acc, c in
            let x = cell.x + c.x
            let y = cell.y + c.y
            let myCell = Cell(x, y)

            if cells.contains(myCell) {
                return acc + 1
            } else {
                return acc
            }
        }
    }
}
