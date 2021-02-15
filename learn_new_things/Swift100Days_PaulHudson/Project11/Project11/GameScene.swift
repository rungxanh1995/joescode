//
//  GameScene.swift
//  Project11
//
//  Created by Joe Pham on 2021-02-13.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var scoreLabel: SKLabelNode!    // force unwrapped, this score label to be defined in didMove()
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    var editingLabel: SKLabelNode!  // allow players to edit the game scene
    var editingMode: Bool = false {
        didSet {
            if editingMode {
                editingLabel.text = "Done"  // label text hints to "Done" while in editing mode
            } else {
                editingLabel.text = "Edit"  // label text hints to "Edit" while NOT in editing mode
            }
        }
    }
    
    
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
        
        // DEFINE THE SCORE LABEL
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.text = "Score: 0"    // initial value
        scoreLabel.horizontalAlignmentMode = .right
        scoreLabel.position = CGPoint(x: 980, y: 700)
        addChild(scoreLabel)
        
        // DEFINE THE EDITING LABEL
        editingLabel = SKLabelNode(fontNamed: "Chalkduster")
        editingLabel.text = "Edit"
        editingLabel.position = CGPoint(x: 80, y: 700)
        addChild(editingLabel)
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
            
            let objects = nodes(at: location)   // get a list of objects at a specific location
            if objects.contains(editingLabel) {
                // if that location has the editing label
                editingMode.toggle()    // toggle means change to true if currently false, and vice versa
            } else {
                if editingMode {
                    // create a box
                    let size = CGSize(width: Int.random(in: 32...128), height: 16)
                    let box = SKSpriteNode(color: UIColor(red: CGFloat.random(in: 0...1), green: CGFloat.random(in: 0...1), blue: CGFloat.random(in: 0...1), alpha: 1), size: size)
                    box.zRotation = CGFloat.random(in: 0...3)   // let each box rotates randomly
                    box.position = location // create the box at that touch point
                    
                    box.physicsBody = SKPhysicsBody(rectangleOf: size)  // add a physics body to the box
                    box.physicsBody?.isDynamic = false
                    
                    addChild(box)
                } else {
                    // create the balls
                    let ball = SKSpriteNode(imageNamed: "ballRed")
                    ball.name = "ball"  // name this node
                    ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.size.width / 2.0) // add a circular physics body to the ball with radius of half the image width
                    ball.physicsBody!.contactTestBitMask = ball.physicsBody!.collisionBitMask   // let it tell about every collision that happens to the ball
                    ball.physicsBody?.restitution = 0.4 // change its bounciness within 0-1 range
                    ball.position = location // place the ball where the touch happened
                    ball.position.y = CGFloat(768)  // let the ball fall from top of the screen
                    addChild(ball)   // ball is also a node, add it to the scene
                }
            }
        }
    }
    
    
    // DEFINE A COLLISION BETWEEN THE BALL AND OTHER OBJECTS WOULD WORK
    func collisionBetween(ball: SKNode, object: SKNode) {
        if object.name == "good" {
            destroy(ball: ball) // call the destroy method defined below
            score += 1
        } else if object.name == "bad" {
            destroy(ball: ball)
            score -= 1
        }
    }
    
    
    // DEFINE HOW THE BALL IS REMOVED FROM THE NODE TREE
    func destroy(ball: SKNode) {
        ball.removeFromParent()
    }
    
    
    func didBegin(_ contact: SKPhysicsContact) {
        // WHEN PHYSICS CONTACT HAPPENS
        // ignore the case if both bodies are balls, we don't want them to disappear when they're both balls
        
        // have a guard to prevent force unwrapping an already removed ball node
        guard let nodeA = contact.bodyA.node else { return }
        guard let nodeB = contact.bodyB.node else { return }
        
        if nodeA.name == "ball" {
            collisionBetween(ball: nodeA, object: nodeB)
        } else if nodeB.name == "ball" {
            collisionBetween(ball: nodeB, object: nodeA)
        }
    }
}
