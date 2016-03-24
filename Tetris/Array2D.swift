// www.bloc.io/tutorials/swiftris-build-your-first-ios-game-with-swift#!/chapters/675
//  Array2D.swift
//  Tetris
//
//  Created by guitarrkurt on 23/03/16.
//  Copyright © 2016 guitarrkurt. All rights reserved.
//

class Array2D<T> {
    let columns: Int
    let rows: Int
    
    var array: Array<T?>
    
    init(columns: Int, rows: Int){
        self.columns = columns
        self.rows = rows
        
        array = Array<T?>(count: rows * columns, repeatedValue: nil)
    }
    
    subscript(column: Int, row: Int) -> T?{
        get{
            return array[(row * columns) + column]
        }
        set(newValue){
            array[(row * columns) + column] = newValue
        }
    }
}
