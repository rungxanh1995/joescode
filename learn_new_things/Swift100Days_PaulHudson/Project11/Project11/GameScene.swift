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
        
        // CREATE THE BOUNCERS
        makeBouncer(at: CGPoint(x: 0, y: 0))
        makeBouncer(at: CGPoint(x: 256, y: 0))
        makeBouncer(at: CGPoint(x: 512, y: 0))
        makeBouncer(at: CGPoint(x: 768, y: 0))
        makeBouncer(at: CGPoint(x: 1024, y: 0))
    }
    
    // DEFINE THE BOUNCER(s)
    func makeBouncer(at position: CGPoint) {
        let bouncer = SKSpriteNode(imageNamed: "bouncer.jpg")
        bouncer.position = position    // pass the x,y coords to the position property of the bouncer
        bouncer.physicsBody = SKPhysicsBody(circleOfRadius: bouncer.size.width / 2.0)
        bouncer.physicsBody?.isDynamic = false  // being false means it's gonna stay in place, not moving
        addChild(bouncer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // DEFINE A TOUCH ON THE SCREEN
        if let touch = touches.first    // pull out any screen touches from `touches` set
        {
            let location = touch.location(in: self) // find out where the screen was touched in relation to self/the game scene
            let ball = SKSpriteNode(imageNamed: "ballRed")
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0) // add a circular physics body to the ball with radius of half the image width
            ball.physicsBody?.restitution = 0.4 // change its bounciness within 0-1 range
            ball.position = location // place the ball where the touch happened
            addChild(ball)   // ball is also a node, add it to the scene
        }
    }
}
