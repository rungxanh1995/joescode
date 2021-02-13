//
//  GameScene.swift
//  Project11
//
//  Created by Joe Pham on 2021-02-13.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    override func didMove(to view: SKView) {
        
        // DEFINE THE GAME BACKGROUND
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: 512, y: 384)   // half the scene size
        background.blendMode = .replace // ignore any alpha values
        background.zPosition = -1   // place the background below everything else
        addChild(background)    // background is a node
        
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)    // add a physics body to the whole scene that's a line on each edge
        // acting like a container for the scene
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // DEFINE A TOUCH ON THE SCREEN
        if let touch = touches.first    // pull out any screen touches from `touches` set
        {
            let location = touch.location(in: self) // find out where the screen was touched in relation to self/the game scene
            let box = SKSpriteNode(color: UIColor.red, size: CGSize(width: 64, height: 64))
            box.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 64, height: 64)) // add a physics body to the box of same size
            box.position = location // place the box where the touch happened
            addChild(box)   // box is also a node, add it to the scene
        }
    }
}
