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

var gameState: GameState = .playing

var teamWorkMode = true

var changeColorBottom = false
var changeColorTop = false

var height: CGFloat = 1334
var width: CGFloat = 750

var timer: CFTimeInterval = 0
let fixedDelta: CFTimeInterval = 1.0 / 60.0

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var ball: Ball!
    var deathBar: SKSpriteNode!
    var paddleTimer: CFTimeInterval = 0
    var topWin: SKLabelNode!
    var bottomWin: SKLabelNode!
    var countDown: SKSpriteNode!
    var restartButton: MSButtonNode!
    var menuButton: MSButtonNode!
    var pointsLabel: SKLabelNode!
    var topWon = true
    var colorList = [UIColor]()
    var bottomHalf: SKSpriteNode!
    var topHalf: SKSpriteNode!
    let turquoise = UIColor(red:0.54, green:0.69, blue:0.67, alpha:1.0)
    let pink = UIColor(red:0.67, green:0.39, blue:0.45, alpha:1.0)
    let green = UIColor(red:0.71, green:0.73, blue:0.45, alpha:1.0)
    let darkPurple = UIColor(red:0.22, green:0.13, blue:0.38, alpha:1.0)
    let lightPurple = UIColor(red:0.49, green:0.44, blue:0.53, alpha:1.0)
    let blue = UIColor(red:0.18, green:0.59, blue:0.76, alpha:1.0)
    
    
    override func didMove(to view: SKView) {
        ball = childNode(withName: "ball") as! Ball
        deathBar = childNode(withName: "deathBar") as! SKSpriteNode
        topWin = childNode(withName:"topWin") as! SKLabelNode
        bottomWin = childNode(withName:"bottomWin") as! SKLabelNode
        countDown = childNode(withName: "countDown") as! SKSpriteNode
        restartButton = childNode(withName: "restartButton") as! MSButtonNode
        menuButton = childNode(withName: "menuButton") as! MSButtonNode
        
        pointsLabel = childNode(withName: "pointsLabel") as! SKLabelNode
        
        bottomHalf = childNode(withName: "bottomHalf") as! SKSpriteNode
        topHalf = childNode(withName: "topHalf") as! SKSpriteNode
        
        topWin.isHidden = true
        bottomWin.isHidden = true
        
        physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx:0, dy:0)
        
        ball.isUserInteractionEnabled = true

        colorList.append(turquoise)
        
        colorList.append(pink)
        
        colorList.append(green)
        
        pointsLabel.isHidden = true
        
       

        
        restartButton.selectedHandler = {
            
            
           
            gameState = .playing
            
            let skView = self.view as SKView!
            
            /* Load Game scene */
            guard let scene = GameScene(fileNamed:"GameScene") as GameScene! else {
                return
            }
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .aspectFill
            
            /* Restart GameScene */
            skView?.presentScene(scene)
            self.ball.isUserInteractionEnabled = true


            
        }
        
        menuButton.selectedHandler = {
            
            
           
            gameState = .playing
            
            let skView = self.view as SKView!
            
            /* Load Game scene */
            guard let scene = GameScene(fileNamed:"MainMenu") as GameScene! else {
                return
            }
            
            /* Ensure correct aspect mode */
            scene.scaleMode = .aspectFill
            
            /* Restart GameScene */
            skView?.presentScene(scene)
            self.ball.isUserInteractionEnabled = true
            
            
            
        }
        
        restartButton.state = .MSButtonNodeStateHidden
        menuButton.state = .MSButtonNodeStateHidden

        
        let count = SKAction(named: "Count")!
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([count,remove])
        countDown.run(sequence)
        

        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        if gameState != .playing { return }

        
    
    
    
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        
        timer += fixedDelta
        checkGravity()
        updateBall()
        changeColors()
        displayPoints()
        
        
    }
    
    func didBegin (_ contact: SKPhysicsContact) {
        

        
        
        /* Get references to bodies involved */
        let contactA = contact.bodyA
        let contactB = contact.bodyB
        
        /* Get references to the physics bodies */
        let nodeA = contactA.node!
        let nodeB = contactB.node!
        
        
        
        
        if nodeA.name == "deathBar" || nodeB.name == "deathBar" {
            let pulse:SKAction = SKAction.init(named: "Pulse")!

            ball.physicsBody?.velocity = CGVector(dx:0, dy:0)
            self.physicsWorld.gravity = CGVector(dx:0, dy:0)
            ball.physicsBody?.angularVelocity = 0
            ball.run(pulse)

                /* Let bokeh fly if you hit the ground*/
                if let particles = SKEmitterNode(fileNamed: "Bokeh.sks") {
                    particles.position = CGPoint(x: ball.position.x + 90, y: ball.position.y)
                    addChild(particles)
                    
                }

                /* if ball hits the ground, do this */
            
            if ball.position.y > size.height/2 {
                gameState = .gameOver
                restartButton.state = .MSButtonNodeStateActive
                menuButton.state = .MSButtonNodeStateActive
                topWon = false
                impulse = 0
                impulseDown = 0
                tapCount = 0
                ball.isUserInteractionEnabled = false
                animate()

            } else if ball.position.y < size.height/2 {
                gameState = .gameOver
                restartButton.state = .MSButtonNodeStateActive
                menuButton.state = .MSButtonNodeStateActive
                topWon = true
                impulse = 0
                impulseDown = 0
                tapCount = 0
                ball.isUserInteractionEnabled = false
                
                animate()
                
                /* Let bokeh fly if you hit the ground*/
                if let particles = SKEmitterNode(fileNamed: "Bokeh.sks") {
                    particles.position = CGPoint(x: ball.position.x + 90, y: ball.position.y)
                    addChild(particles)
                    print("asasd")
                }
                
               pointsLabel.isHidden = true
                
            }
            
            
            
            
            
            
        }
    }
    
    func checkGravity() {
        self.physicsWorld.gravity = CGVector(dx:impulseDown, dy:0)
        
        
    }
    
    func changeColors() {
        if changeColorBottom == true {
            let randomNumber = arc4random_uniform(3)
            if randomNumber == 1 {
                bottomHalf.color = lightPurple
            } else if randomNumber == 2 {
                bottomHalf.color = green
            } else {
                bottomHalf.color = turquoise
            }
            
            
            changeColorBottom = false
        } else if changeColorTop == true {
            let randomNumber = arc4random_uniform(3)
            if randomNumber == 1 {
                topHalf.color = blue
            } else if randomNumber == 2 {
                topHalf.color = pink
            } else {
                topHalf.color = darkPurple
            }
            
            
            changeColorTop = false

        }
        
        
    }
    
    func animate() {
        
        /* Sets pulse and scale animations when game over */
        
        
        
        let scale:SKAction = SKAction.init(named: "Scale")!
        let sequence = SKAction.sequence([scale])
        if teamWorkMode == false {
            if topWon == false {
                bottomWin.isHidden = false
                bottomWin.run(sequence)
                return
                
            } else if topWon == true {
                topWin.isHidden = false
                topWin.run(sequence)
                return
                 
            }
        }
        
        
    }
    
    func updateBall() {
        ball.physicsBody?.mass = 0.3
        if tapCount > 10 {
            ball.texture = SKTexture(imageNamed:"Untitled-1")
            ball.physicsBody?.mass = 0.35
            
        }
        
        if tapCount > 15 {
            ball.texture = SKTexture(imageNamed:"baseball")
            ball.physicsBody?.mass = 0.28
        }
        
        if tapCount > 20 {
            ball.texture = SKTexture(imageNamed:"soccerball")
            ball.physicsBody?.mass = 0.3
        }
        
    }
    
    func displayPoints() {
        if teamWorkMode == true && tapCount >= 1 {
            pointsLabel.isHidden = false
         pointsLabel.text = String(tapCount - 1)
        }
    }
    
}
