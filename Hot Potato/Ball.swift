//
//  Ball.swift
//  Hot Potato
//
//  Created by Wiley Siler on 7/6/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//


var tapCount = 0

var impulse = 0
var impulseDown = 0


import Foundation
import SpriteKit

class Ball: SKSpriteNode {
  
    
    
    override init(texture: SKTexture?, color:UIColor, size: CGSize) {
        super.init(texture:texture, color: color, size: size)
        isUserInteractionEnabled = true
        

    }
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    /* Scaling for each milestone reached */
       /* Make easier for team work mode, more ralleys */
        if teamWorkMode == false {
            switch tapCount {
            case 1:
                impulse = 300
                impulseDown = -3
            case 5:
                impulse = 400
                impulseDown = -5
            case 10:
                impulse = 500
                impulseDown = -7
            case 15:
                impulse = 600
                impulseDown = -8
            case 20:
                impulse = 650
                impulseDown = -9
            case 25:
                impulse = 700
                impulseDown = -10
            default: break
            }
            
        } else {
            switch tapCount {
            case 1:
                impulse = 300
                impulseDown = -3
            case 10:
                impulse = 350
                impulseDown = -5
            case 15:
                impulse = 400
                impulseDown = -7
            case 20:
                impulse = 450
                impulseDown = -8
            case 25:
                impulse = 500
                impulseDown = -9
            case 30:
                impulse = 550
                impulseDown = -10
            default: break
            }
        
        }

/* If user taps for the first time, after the animation and countdown, randomly spawn on one side of the screen */
        
        if tapCount == 0 && timer >= 3 {
            
            let rand = arc4random_uniform(100)
            
            
            if rand < 50 {
                /* 50 chance of top */
                
                position.y = CGFloat(1234)
//                tapCount += 1
                print(rand)
                
            } else if rand > 50 {
                /* 50 chance of bottom */
                
                position.y = CGFloat(100)
//                tapCount += 1
                print(rand)
                
            }
            
            
        }
        
        /* Was touch on left/right hand of screen? */
        
        if tapCount >= 1 {
            let sound = SKAction.playSoundFileNamed("blop.mp3", waitForCompletion: false)

            if position.y > height/2 {
                physicsBody?.velocity = CGVector(dx:0, dy:0)
                
                
                /* Apply vertical impulse */
                physicsBody?.applyImpulse(CGVector(dx: 100, dy: -impulse))
//                tapCount += 1
                self.run(sound)
                changeColorTop = true
                
            } else if position.y < height/2 {
                physicsBody?.velocity = CGVector(dx:0, dy:0)
                
                /* Apply vertical impulse */
                physicsBody?.applyImpulse(CGVector(dx: 100, dy: impulse))
//                tapCount += 1
                self.run(sound)

                
                changeColorBottom = true
            }
            
            
        }
        
        tapCount += 1
        
        

        
    }

    
    
}
