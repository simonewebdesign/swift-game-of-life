typealias Cells = [Cell]

//struct Cell: Hashable {
//    let x: Int
//    let y: Int
//}

typealias Cell = (x: Int, y: Int)

struct Life {
    // these are the numbers to add/subtract from a coordinate in order
    // to get the relative neighbour
    static let offsets =             [(-1, -1), (-1, 0), (-1, 1), (0, -1),         (0, 1), (1, -1), (1, 0), (1, 1)]
    static let offsetsIncludingOwn = [(-1, -1), (-1, 0), (-1, 1), (0, -1), (0, 0), (0, 1), (1, -1), (1, 0), (1, 1)]

//    private func aliveCellAndNeighbors(_cells: Cells) ->

    private func shouldLive(isAlive: Bool, numOfNeighbors: Int) -> Bool {
        return (numOfNeighbors == 2 && isAlive) || numOfNeighbors == 3
    }

    private func neighborsCount(_cells: Cells, _cell: Cell) -> Int {
        return Life.offsets.reduce(0) { _acc, _c in
            let x = _cell.0 + _c.0
            let y = _cell.1 + _c.1

            if _cells.contains(where: { $0.x == x && $0.y == y }) {
                return _acc + 1
            } else {
                return _acc
            }
        }
    }
}
