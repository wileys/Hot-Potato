//
//  BasketBall.swift
//  Hot Potato
//
//  Created by Wiley Siler on 7/7/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//

import Foundation
import SpriteKit

class BasketBall: Ball {
    
    let ballTexture = SKTexture(imageNamed:"Untitled-1")

    override init(texture: SKTexture?, color:UIColor, size: CGSize) {
        super.init(texture:ballTexture, color: color, size: size)
        isUserInteractionEnabled = true
        physicsBody?.mass = 2
        

        
        
    }
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
        
    }
    
}
