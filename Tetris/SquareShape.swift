// www.bloc.io/tutorials/swiftris-build-your-first-ios-game-with-swift#!/chapters/675
//  SquareShape.swift
//  Tetris
//
//  Created by guitarrkurt on 23/03/16.
//  Copyright © 2016 guitarrkurt. All rights reserved.
//

import SpriteKit

class SquareShape: Shape {
    /*
        | 0·| 1 |
        | 2 | 3 |
    ·mark the row/cloumn indicator for the shape
    */
    
    // The square shape will not rotate
    override var blockRowColumnPositions: [Orientation: Array<(columnDiff: Int, rowDiff: Int)>]{
        return [
            Orientation.Zero: [(0,0), (1,0), (0,1), (1,1)],
            Orientation.OneEighty: [(0,0), (1,0), (0,1), (1,1)],
            Orientation.Ninety: [(0,0), (1,0), (0,1), (1,1)],
            Orientation.TwoSeventy: [(0,0), (1,0), (0,1), (1,1)]
        ]
    
    }
    override var bottomBlocksForOrientations: [Orientation: Array<Block>]{
        return [
            Orientation.Zero:       [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.OneEighty:  [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.Ninety:     [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]],
            Orientation.TwoSeventy: [blocks[ThirdBlockIdx], blocks[FourthBlockIdx]]
        ]
    }
}
