//
//  BoardCollectionViewController.swift
//  tictactoe
//
//  Created by Matthew Delves on 9/7/17.
//  Copyright © 2017 reformedsoftware. All rights reserved.
//

import UIKit

class BoardCollectionViewController: UICollectionViewController {
    let boardData = BoardDataSource()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        collectionView?.dataSource = boardData
    }
}

extension BoardCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let boardCell = cell as? BoardCollectionViewCell else { return }

        let tile = boardData.board.tiles[indexPath.section][indexPath.item]

        switch tile {
        case .naught:
            boardCell.label.text = "O"
        case .cross:
            boardCell.label.text = "X"
        case .unknown:
            boardCell.label.text = ""
        }
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        boardData.board.move(x: indexPath.item, y: indexPath.section)

        collectionView.reloadData()

        switch boardData.board.gameStatus {
        case .inProgress:
            break
        case .won:
            alertWin()
        case .drawn:
            alertDrawn()
        }
    }

    func alertWin() {
        let player = boardData.board.currentPlayer.rawValue

        let alert = UIAlertController(
            title: "Tic Tac Toe",
            message: "The game has been won by \(player)",
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { [weak self] _ in
                self?.boardData.resetGame()
                self?.collectionView?.reloadData()
            }
        )

        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }

    func alertDrawn() {
        let alert = UIAlertController(
            title: "Tic Tac Toe",
            message: "The game has ended in a draw",
            preferredStyle: .alert
        )

        let okAction = UIAlertAction(
            title: "OK",
            style: .default,
            handler: { [weak self] _ in
                self?.boardData.resetGame()
                self?.collectionView?.reloadData()
            }
        )

        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
