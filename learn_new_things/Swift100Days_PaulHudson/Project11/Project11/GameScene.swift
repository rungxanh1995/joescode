//
//  GameScene.swift
//  Project11
//
//  Created by Joe Pham on 2021-02-13.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    override func didMove(to view: SKView) {
        // ADD A PHYSICS BODY TO THE SCENE
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)    // a line on each edge
        // acting like a container for the scene
        
        physicsWorld.contactDelegate = self // assign the current scene to physics world's contact delegate
        
        // DEFINE THE GAME BACKGROUND
        let background = SKSpriteNode(imageNamed: "background.jpg")
        background.position = CGPoint(x: 512, y: 384)   // half the scene size
        background.blendMode = .replace // ignore any alpha values
        background.zPosition = -1   // place the background below everything else
        addChild(background)    // background is a node
        
        // CREATE THE SLOTS (SO IT'S BEHIND THE BOUNCERS)
        makeSlot(at: CGPoint(x: 128, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 384, y: 0), isGood: false)
        makeSlot(at: CGPoint(x: 640, y: 0), isGood: true)
        makeSlot(at: CGPoint(x: 896, y: 0), isGood: false)
        
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
    
    // DEFINE THE SLOT(s)
    func makeSlot(at position: CGPoint, isGood: Bool) {
        var slotBase: SKSpriteNode
        var slotGlow: SKSpriteNode
        
        if isGood {
            slotBase = SKSpriteNode(imageNamed: "slotBaseGood")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowGood")
            slotBase.name = "good"  // name this node the good slot
        } else {
            slotBase = SKSpriteNode(imageNamed: "slotBaseBad")
            slotGlow = SKSpriteNode(imageNamed: "slotGlowBad")
            slotBase.name = "bad"   // name this node the bad slot
        }
        
        slotBase.position = position
        slotGlow.position = position
        
        slotBase.physicsBody = SKPhysicsBody(rectangleOf: slotBase.size)    // add rectangle physics
        slotBase.physicsBody?.isDynamic = false // keep it still
        
        // Make the glow spins, forever
        let spin = SKAction.rotate(byAngle: (-CGFloat.pi), duration: 10)
        let spinForever = SKAction.repeatForever(spin)
        slotGlow.run(spinForever)
        
        addChild(slotBase)
        addChild(slotGlow)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // DEFINE A TOUCH ON THE SCREEN
        if let touch = touches.first    // pull out any screen touches from `touches` set
        {
            let location = touch.location(in: self) // find out where the screen was touched in relation to self/the game scene
            let ball = SKSpriteNode(imageNamed: "ballRed")
            ball.name = "ball"  // name this node
            ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0) // add a circular physics body to the ball with radius of half the image width
            ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask   // let it tell about every collision that happens to the ball
            ball.physicsBody?.restitution = 0.4 // change its bounciness within 0-1 range
            ball.position = location // place the ball where the touch happened
            addChild(ball)   // ball is also a node, add it to the scene
        }
    }
    
    // DEFINE A COLLISION BETWEEN THE BALL AND OTHER OBJECTS WOULD WORK
    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball) // call the destroy method defined below
        } else if object.name == "bad" {
            destroy(ball: ball)
        }
    }
    
    // DEFINE HOW THE BALL IS REMOVED FROM THE NODE TREE
    func destroy(ball: SKNode) {
        ball.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        // ignore the case if both bodies are balls, we don't want them to disappear when they're both balls
        
        // have a guard to prevent force unwrapping an already removed ball node
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball" {
//            collisionBetween(ball: contact.bodyA.node!, object: contact.bodyB.node!)
            collisionBetween(ball: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
//            collisionBetween(ball: contact.bodyB.node!, object: contact.bodyA.node!)
            collisionBetween(ball: nodeB, object: nodeA)
        }
    }
}
