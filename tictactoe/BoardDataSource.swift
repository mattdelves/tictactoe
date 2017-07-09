//
//  BoardDataSource.swift
//  tictactoe
//
//  Created by Matthew Delves on 9/7/17.
//  Copyright © 2017 reformedsoftware. All rights reserved.
//

import UIKit

class BoardDataSource: NSObject, UICollectionViewDataSource {
    var board = Board(width: 3, height: 3)

    func resetGame() {
        board = Board(width: 3, height: 3)
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return board.height
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return board.width
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: "boardCell", for: indexPath)
    }
}
