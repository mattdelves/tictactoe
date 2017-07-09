//
//  boardTests.swift
//  tictactoe
//
//  Created by Matthew Delves on 9/7/17.
//  Copyright © 2017 reformedsoftware. All rights reserved.
//

import XCTest
@testable import tictactoe

class boardTests: XCTestCase {
    var board: Board!

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        board = Board(width: 3, height: 3)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNaughtsTurn() {
        board.move(x: 0, y: 0)
        board.move(x: 0, y: 1)

        XCTAssert(board.currentPlayer == .naught, "Should be naughts turn")
    }

    func testCrossesTurn() {
        board.move(x: 0, y: 0)
        board.move(x: 0, y: 1)
        board.move(x: 0, y: 2)

        XCTAssert(board.currentPlayer == .cross, "Should be crosses turn")
    }

    func testInProgress() {
        board.move(x: 0, y: 0)
        board.move(x: 0, y: 1)

        let status = board.gameStatus
        XCTAssert(status == .inProgress, "Expected inProgress got \(status)")
    }

    func testDrawnGame() {
/*      [
            [O, X, O]
            [O, X, O]
            [X, O, X]
        ]
 */
        board.move(x: 0, y: 0) // naughts
        board.move(x: 0, y: 1) // crosses
        board.move(x: 0, y: 2) // naughts
        board.move(x: 1, y: 1) // crosses
        board.move(x: 1, y: 0) // naughts
        board.move(x: 2, y: 0) // crosses
        board.move(x: 2, y: 1) // naughts
        board.move(x: 2, y: 2) // crosses
        board.move(x: 1, y: 2) // naughts

        let status = board.gameStatus
        XCTAssert(status == .drawn, "Expected drawn, got \(status)")
    }

    func testHorizontalWin() {
        board.move(x: 0, y: 0) // naughts
        board.move(x: 1, y: 1) // crosses
        board.move(x: 1, y: 0) // naughts
        board.move(x: 1, y: 2) // crosses
        board.move(x: 2, y: 0) // naughts

        let horizontalWin = board.horizontalWin()
        XCTAssert(horizontalWin, "Expected win to be horizontal")

        let status = board.gameStatus
        XCTAssert(status == .won, "Expected won got \(status)")
    }

    func testVerticalWin() {
        board.move(x: 0, y: 0) // naughts
        board.move(x: 1, y: 1) // crosses
        board.move(x: 0, y: 1) // naughts
        board.move(x: 1, y: 2) // crosses
        board.move(x: 0, y: 2) // naughts

        let verticalWin = board.verticalWin()
        XCTAssert(verticalWin, "Expected win to be vertical")

        let status = board.gameStatus
        XCTAssert(status == .won, "Expected won got \(status)")
    }

    func testDiagonalLeftRightWin() {
        board.move(x: 0, y: 0) // naughts
        board.move(x: 0, y: 2) // crosses
        board.move(x: 1, y: 1) // naughts
        board.move(x: 0, y: 1) // crosses
        board.move(x: 2, y: 2) // naughts

        let diagonalWin = board.diagonalWin()
        XCTAssert(diagonalWin, "Expected win to be diagonal")

        let status = board.gameStatus
        XCTAssert(status == .won, "Expected won got \(status)")
    }

    func testDiagonalRightLeftWin() {
        board.move(x: 0, y: 2) // naughts
        board.move(x: 0, y: 0) // crosses
        board.move(x: 1, y: 1) // naughts
        board.move(x: 0, y: 1) // crosses
        board.move(x: 2, y: 0) // naughts

        let diagonalWin = board.diagonalWin()
        XCTAssert(diagonalWin, "Expected win to be diagonal")

        let status = board.gameStatus
        XCTAssert(status == .won, "Expected won got \(status)")
    }
}
