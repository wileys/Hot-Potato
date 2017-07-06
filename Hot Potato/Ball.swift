//
//  Ball.swift
//  Hot Potato
//
//  Created by Wiley Siler on 7/6/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//


var tapCount = 0

var impulse = 300
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
        
    
        switch tapCount {
        case 1:
            impulseDown = -3
        case 5:
            impulse = 400
            impulseDown = -5
        case 10:
            impulse = 500
            impulseDown = -7
        case 15:
            impulse = 600
            impulseDown = -9
        case 20:
            impulse = 700
            impulseDown = -12
        default: break
        }
        
//        
//        let touch = touches.first!
//        
//        
//        /* Get touch position in scene */
//        let location = touch.location(in:self)
        
        
        /* Was touch on left/right hand of screen? */
        
        if tapCount >= 1 {
        
            if position.y > height/2 {
                physicsBody?.velocity = CGVector(dx:0, dy:0)
                
                
                /* Apply vertical impulse */
                physicsBody?.applyImpulse(CGVector(dx: 100, dy: -impulse))
                tapCount += 1
                
            } else if position.y < height/2 {
                physicsBody?.velocity = CGVector(dx:0, dy:0)
                
                /* Apply vertical impulse */
                physicsBody?.applyImpulse(CGVector(dx: 100, dy: impulse))
                tapCount += 1
            }
            
        }
        
    }

    
}
