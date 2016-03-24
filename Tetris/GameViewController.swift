// www.bloc.io/tutorials/swiftris-build-your-first-ios-game-with-swift#!/chapters/675
//  GameViewController.swift
//  Tetris
//
//  Created by guitarrkurt on 23/03/16.
//  Copyright (c) 2016 guitarrkurt. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController, SwiftrisDelegate, UIGestureRecognizerDelegate {
    
    var scene: GameScene!
    var swiftris: Tetris!
    var panPointReference:CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configuramos el View.
        let skView = view as! SKView
        skView.multipleTouchEnabled = false
        
        //Creamos y configuramos la escena.
        scene = GameScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill
        
        scene.tick = didTick

        swiftris = Tetris()
        swiftris.delegate = self
        swiftris.beginGame()
        
        //Presentamos la escena
        skView.presentScene(scene)
        
//        scene.addPreviewShapeToScene(swiftris.nextShape!) {
//            self.swiftris.nextShape?.moveTo(StartingColumn, row: StartingRow)
//            self.scene.movePreviewShape(self.swiftris.nextShape!) {
//                let nextShapes = self.swiftris.newShape()
//                self.scene.startTicking()
//                self.scene.addPreviewShapeToScene(nextShapes.nextShape!) {}
//            }
//        }
    
    }
    override func prefersStatusBarHidden() -> Bool {
        return true
    
    }
    
    @IBAction func didTap(sender: UITapGestureRecognizer) {
        swiftris.rotateShape()
    }

    @IBAction func didPan(sender: UIPanGestureRecognizer) {
        let currentPoint = sender.translationInView(self.view)
        if let originalPoint = panPointReference {
            // #3
            if abs(currentPoint.x - originalPoint.x) > (BlockSize * 0.9) {
                // #4
                if sender.velocityInView(self.view).x > CGFloat(0) {
                    swiftris.moveShapeRight()
                    panPointReference = currentPoint
                } else {
                    swiftris.moveShapeLeft()
                    panPointReference = currentPoint
                }
            }
        } else if sender.state == .Began {
            panPointReference = currentPoint
        }
    }
    
    @IBAction func didSwipe(sender: UISwipeGestureRecognizer) {
        swiftris.dropShape()
    }
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    // #6
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailByGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UISwipeGestureRecognizer {
            if otherGestureRecognizer is UIPanGestureRecognizer {
                return true
            }
        } else if gestureRecognizer is UIPanGestureRecognizer {
            if otherGestureRecognizer is UITapGestureRecognizer {
                return true
            }
        }
        return false
    }
    func didTick() {
        swiftris.letShapeFall()
//        swiftris.fallingShape?.lowerShapeByOneRow()
//        scene.redrawShape(swiftris.fallingShape!, completion: {})
    }
    func nextShape() {
        let newShapes = swiftris.newShape()
        guard let fallingShape = newShapes.fallingShape else {
            return
        }
        self.scene.addPreviewShapeToScene(newShapes.nextShape!) {}
        self.scene.movePreviewShape(fallingShape) {
            // #16
            self.view.userInteractionEnabled = true
            self.scene.startTicking()
        }
    }
    
    func gameDidBegin(swiftris: Tetris) {
        // The following is false when restarting a new game
        if swiftris.nextShape != nil && swiftris.nextShape!.blocks[0].sprite == nil {
            scene.addPreviewShapeToScene(swiftris.nextShape!) {
                self.nextShape()
            }
        } else {
            nextShape()
        }
    }
    
    func gameDidEnd(swiftris: Tetris) {
        view.userInteractionEnabled = false
        scene.stopTicking()
    }
    
    func gameDidLevelUp(swiftris: Tetris) {
        
    }
    
    func gameShapeDidDrop(swiftris: Tetris) {
        scene.stopTicking()
        scene.redrawShape(swiftris.fallingShape!) {
            swiftris.letShapeFall()
        }
    }
    
    func gameShapeDidLand(swiftris: Tetris) {
        scene.stopTicking()
        nextShape()
    }
    
    // #17
    func gameShapeDidMove(swiftris: Tetris) {
        scene.redrawShape(swiftris.fallingShape!) {}
    }
}
