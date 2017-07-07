
//
//  MainMenu.swift
//  Hot Potato
//
//  Created by Wiley Siler on 7/7/17.
//  Copyright © 2017 Wiley Siler. All rights reserved.
//

import Foundation
import SpriteKit


class MainMenu: SKScene {
    /* UI Connections */
    
    var teamButton: MSButtonNode!
    var compButton: MSButtonNode!
    
    
    override func didMove(to view: SKView) {
        /* Setup your scene here */
        
        let teamButton = childNode(withName: "teamButton") as! MSButtonNode
        let compButton = childNode(withName: "compButton") as! MSButtonNode
        
        /*Set UI connections*/
        
        teamButton.selectedHandler = {
            teamWorkMode = true
            self.loadGame()
        }
        
        compButton.selectedHandler = {
            teamWorkMode = false
            self.loadGame()
        }
        
        
        
    }
    
    func loadGame() {
        /* 1) Grab reference to our SpriteKit view */
        if let view = self.view {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
}
}
