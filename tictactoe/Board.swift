//
//  Board.swift
//  tictactoe
//
//  Created by Matthew Delves on 9/7/17.
//  Copyright © 2017 reformedsoftware. All rights reserved.
//

import Foundation

class Board {
    let width: Int
    let height: Int
    var currentPlayer: Tile = .naught
    var tiles: [[Tile]]

    enum Tile: String {
        case naught = "naughts"
        case cross = "crosses"
        case unknown
    }

    enum Status {
        case inProgress
        case won
        case drawn
    }

    init(width: Int, height: Int) {
        self.width = width
        self.height = height
        tiles = (0 ..< height).map { _ -> [Tile] in
            return (0 ..< width).map { _ -> Tile in
                return .unknown
            }
        }
    }

    func move(x: Int, y: Int) {
        guard tiles[y][x] == .unknown else { return }

        tiles[y][x] = currentPlayer
        updateCurrentPlayer()
    }

    func updateCurrentPlayer() {
        guard gameStatus == .inProgress else { return }

        switch currentPlayer {
        case .naught:
            currentPlayer = .cross
        case .cross:
            currentPlayer = .naught
        case .unknown:
            break
        }
    }

    var gameStatus: Status {
        if horizontalWin() {
            return .won
        }

        if verticalWin() {
            return .won
        }

        if diagonalWin() {
            return .won
        }

        if gameDrawn() {
            return .drawn
        }

        // All failed, return in progress
        return .inProgress
    }

    func horizontalWin() -> Bool {
        // Test horizontal
        for index in 0 ..< height {
            let row = tiles[index]

            // Test naught
            if row.reduce(true, { $0 && $1 == .naught }) {
                return true
            }

            // Test cross
            if row.reduce(true, { $0 && $1 == .cross }) {
                return true
            }
        }

        return false
    }

    func verticalWin() -> Bool {
        // Test vertical
        for index in 0 ..< width {
            // Test naught
            if (0 ..< height).reduce(true, { $0 && tiles[$1][index] == .naught}) {
                return true
            }

            // Test cross
            if (0 ..< height).reduce(true, { $0 && tiles[$1][index] == .cross }) {
                return true
            }
        }

        return false
    }

    func diagonalWin() -> Bool {
        // Test diaginal
        // Test naught
        // Left to Right
        if (0 ..< width).reduce(true, { $0 && tiles[$1][$1] == .naught}) {
            return true
        }
        // Right to Left
        if (0 ..< width).reduce(true, { $0 && tiles[$1][(width - 1) - $1] == .naught}) {
            return true
        }

        // Test cross
        // Left to Right
        if (0 ..< width).reduce(true, { $0 && tiles[$1][$1] == .cross }) {
            return true
        }
        // Right to Left
        if (0 ..< width).reduce(true, { $0 && tiles[$1][(width - 1) - $1] == .cross }) {
            return true
        }

        return false
    }

    func gameDrawn() -> Bool {
        // Test drawn
        return (0 ..< height).reduce(true, { result, vertIndex -> Bool in
            result && (0 ..< width).reduce(true, { $0 && tiles[vertIndex][$1] != .unknown})
        })
    }
}
