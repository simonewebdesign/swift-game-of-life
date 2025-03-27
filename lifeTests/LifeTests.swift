import XCTest
@testable import life

class LifeTests: XCTestCase {
    var life: Life!

    override func setUp() {
        super.setUp()
        life = Life()
    }

    override func tearDown() {
        life = nil
        super.tearDown()
    }

    func testSingleCellDies() {
        // A single cell should die in the next generation
        let initialCells: Cells = [Cell(0, 0)]
        let nextGeneration = life.tick(cells: initialCells)
        XCTAssertTrue(nextGeneration.isEmpty)
    }

    func testBlockPatternStaysStable() {
        // A 2x2 block should remain unchanged
        let block: Cells = [
            Cell(0, 0), Cell(0, 1),
            Cell(1, 0), Cell(1, 1)
        ]
        let nextGeneration = life.tick(cells: block)
        XCTAssertEqual(nextGeneration, block)
    }

    func testBlinkerPatternOscillates() {
        // A blinker (3 cells in a row) should oscillate between horizontal and vertical
        let horizontalBlinker: Cells = [
            Cell(0, 0), Cell(0, 1), Cell(0, 2)
        ]

        let nextGeneration = life.tick(cells: horizontalBlinker)
        let expectedVerticalBlinker: Cells = [
            Cell(-1, 1), Cell(0, 1), Cell(1, 1)
        ]
        XCTAssertEqual(nextGeneration, expectedVerticalBlinker)

        // And back to horizontal
        let backToHorizontal = life.tick(cells: nextGeneration)
        XCTAssertEqual(backToHorizontal, horizontalBlinker)
    }

    func testEmptyGridStaysEmpty() {
        let emptyGrid: Cells = []
        let nextGeneration = life.tick(cells: emptyGrid)
        XCTAssertTrue(nextGeneration.isEmpty)
    }
}
