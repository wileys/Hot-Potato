//
//  GameScene.swift
//  Catch
//
//  Created by Wiley Siler on 7/5/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//

import Foundation

import SpriteKit
import GameplayKit


enum GameState {
    case playing, gameOver
}

var height: CGFloat = 1334
var width: CGFloat = 750

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball: Ball!
    var deathBar: SKSpriteNode!
    var timer: CFTimeInterval = 0
    var paddleTimer: CFTimeInterval = 0
    let fixedDelta: CFTimeInterval = 1.0 / 60.0
    var topWin: SKLabelNode!
    var bottomWin: SKLabelNode!
    var countDown: SKSpriteNode!
    var gameState: GameState = .playing
    var restartButton: MSButtonNode!

    
    
    override func didMove(to view: SKView) {
        ball = childNode(withName: "ball") as! Ball
        deathBar = childNode(withName: "deathBar") as! SKSpriteNode
        topWin = childNode(withName:"topWin") as! SKLabelNode
        bottomWin = childNode(withName:"bottomWin") as! SKLabelNode
        countDown = childNode(withName: "countDown") as! SKSpriteNode
        restartButton = childNode(withName: "restartButton") as! MSButtonNode
        
        topWin.isHidden = true
        bottomWin.isHidden = true
        
        physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx:0, dy:0)
        
        ball.isUserInteractionEnabled = true

        
        restartButton.selectedHandler = {
            print("Workin")
            self.gameState = .playing
            let skView = self.view as SKView!
            
            /* Load Game scene */
            guard let scene = GameScene(fileNamed:"GameScene") as GameScene! else {
                return
            }
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .aspectFill
            
            /* Restart GameScene */
            skView?.presentScene(scene)
            
        }
        
        restartButton.state = .MSButtonNodeStateHidden

        
        let count = SKAction(named: "Count")!
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([count,remove])
        countDown.run(sequence)
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        if tapCount == 0 && timer >= 3 {
            
            let rand = arc4random_uniform(100)
            
            
            if rand < 50 {
                /* 50 chance of top */
                
                ball.position.y = CGFloat(1234)
                tapCount += 1
                print(rand)
                
            } else if rand > 50 {
                /* 50 chance of bottom */
                
                ball.position.y = CGFloat(100)
                tapCount += 1
                print(rand)

            }

//            if location.y > size.height/2 {
//                ball.physicsBody?.velocity = CGVector(dx:0, dy:0)
//                
//                
//                /* Apply vertical impulse */
//                ball.physicsBody?.applyImpulse(CGVector(dx: 100, dy: -impulse))
//                tapCount += 1
//                
//            } else if location.y < size.height/2 {
//                ball.physicsBody?.velocity = CGVector(dx:0, dy:0)
//                
//                /* Apply vertical impulse */
//                ball.physicsBody?.applyImpulse(CGVector(dx: 100, dy: impulse))
//                tapCount += 1
//            }
        }
    
    
    
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
        timer += fixedDelta
        checkGravity()
    }
    
    func didBegin (_ contact: SKPhysicsContact) {
        

        let pulse:SKAction = SKAction.init(named: "Pulse")!
        
        
        /* Get references to bodies involved */
        let contactA = contact.bodyA
        let contactB = contact.bodyB
        
        /* Get references to the physics bodies */
        let nodeA = contactA.node!
        let nodeB = contactB.node!
        
        
        
        
        if nodeA.name == "deathBar" || nodeB.name == "deathBar" {
            
            ball.physicsBody?.velocity = CGVector(dx:0, dy:0)
            self.physicsWorld.gravity = CGVector(dx:0, dy:0)
            ball.physicsBody?.angularVelocity = 0
            ball.run(pulse)
            
            
            
            if ball.position.y > size.height/2 {
                bottomWin.isHidden = false
                gameState = .gameOver
                restartButton.state = .MSButtonNodeStateActive
                impulseDown = 0
                tapCount = 0
                

                
                
            } else if ball.position.y < size.height/2 {
                topWin.isHidden = false
                gameState = .gameOver
                restartButton.state = .MSButtonNodeStateActive

                impulseDown = 0
                tapCount = 0
                
            }
            
            
            return
            
            
        }
    }
    
    func checkGravity() {
        self.physicsWorld.gravity = CGVector(dx:impulseDown, dy:0)
        
        
    }
    
    
}
