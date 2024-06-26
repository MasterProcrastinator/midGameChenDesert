//
//  GameScene.swift
//  midGameChen
//
//  Created by ALVIN CHEN on 3/5/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    var player: SKSpriteNode!
    var car: SKSpriteNode!
    var car2: SKSpriteNode!
    var car3: SKSpriteNode!
    var car4: SKSpriteNode!
    var car5: SKSpriteNode!
    var car6: SKSpriteNode!
    var car7: SKSpriteNode!
    var car8: SKSpriteNode!
    var pbcar: SKSpriteNode!
    var penguin: SKSpriteNode!
    var mammoth: SKSpriteNode!
    var whiteFox: SKSpriteNode!
    var snowmobile: SKSpriteNode!
    var iceTrain: SKSpriteNode!
    var armadillo: SKSpriteNode!
    var spider: SKSpriteNode!
    var camel: SKSpriteNode!
    var scorpion: SKSpriteNode!
    var tortoise: SKSpriteNode!
    var desertScourge: SKSpriteNode!
    var sandShark: SKSpriteNode!
    var spider2: SKSpriteNode!
    var test = Vehicle(image: "car", width: 0, height: 0, dx: 0, dy: 0, x: 0)
        
    
   
   // left = positive x and -dx
    //going right = -x and positive dx
    var list = [Vehicle(image: "car", width: 80, height: 60, dx: -350, dy: 0, x: 480),
                Vehicle(image: "car2", width: 60, height: 60, dx: 350, dy: 0, x: -480),
                Vehicle(image: "car3", width: 141, height: 90, dx: 400, dy: 0, x: -480),
                Vehicle(image: "car4", width: 175, height: 100, dx: 450, dy: 0, x: -480),
                Vehicle(image: "car5", width: 114, height: 60, dx: -500, dy: 0, x: 480),
                Vehicle(image: "car6", width: 80, height: 60, dx: 1000, dy: 0, x: -480),
                Vehicle(image: "car7", width: 305, height: 185, dx: -800, dy: 0, x: 900),
                Vehicle(image: "car8", width: 1000, height: 127, dx: 100, dy: 0, x: -700),
                Vehicle(image: "penguin", width: 60, height: 60, dx: 50, dy: 0, x: -600),
                Vehicle(image: "pbcar", width: 250, height: 180, dx: 80, dy: 0, x: -480),
                Vehicle(image: "whiteFox", width: 160, height: 50, dx: -300, dy: 0, x: 480),
                Vehicle(image: "snowmobile", width: 175, height: 90, dx: 400, dy: 0, x: -480),
                Vehicle(image: "iceTrain", width: 2000, height: 190, dx: -50, dy: 0, x: 750),
                Vehicle(image: "mammoth", width: 730, height: 480, dx: 90, dy: 0, x: -700),
                Vehicle(image: "armadillo", width: 80, height: 75, dx: 200, dy: 0, x: -400),
                Vehicle(image: "camel", width: 110, height: 90, dx: -200, dy: 0, x: 400),
                Vehicle(image: "scorpion", width: 80, height: 65, dx: -170, dy: 0, x: 400),
                Vehicle(image: "tortoise", width: 90, height: 75, dx: 170, dy: 0, x: -400),
                Vehicle(image: "spider", width: 80, height: 70, dx: 150, dy: 0, x: -400),
                Vehicle(image: "desertScourge", width: 400, height: 80, dx: -300, dy: 0, x: 400),
                Vehicle(image: "sandShark", width: 200, height: 80, dx: -250, dy: 0, x: 400),
                Vehicle(image: "spider2", width: 80, height: 70, dx: -200, dy: 0, x: 400)
    ]
    

    
    
    
    
    
    
    let cam = SKCameraNode()
    var gameOver = false
    var winLoseOutlet: SKLabelNode!
    var timeLabel: SKLabelNode!
    var gameTimer = 0
    var timer = Timer()
    var debugTeleport = 0.0
    var farthestDistance = 0

    var invisFollower: SKSpriteNode!
    
    override func didMove(to view: SKView) {
        let backgroundmusic = SKAudioNode(fileNamed: "bensound-goodmood")
        addChild(backgroundmusic)
        startTimer()
        timeLabel = (self.childNode(withName: "timeLabel") as! SKLabelNode)
        timeLabel.fontSize = 30
        winLoseOutlet = (self.childNode(withName: "statusLabel") as! SKLabelNode)
        winLoseOutlet.fontSize = 100
        winLoseOutlet.text = ""
        player = (self.childNode(withName: "player") as! SKSpriteNode)
        invisFollower = (self.childNode(withName: "follower") as! SKSpriteNode)
        self.camera = cam
        self.physicsWorld.contactDelegate = self
        invisFollower.position.x = player.position.x
        invisFollower.position.y = player.position.y
        winLoseOutlet.position.x = player.position.x
        
        
        if ((Int)(player.position.y) > farthestDistance){
            
            farthestDistance = Int(player.position.y)
            
        }
        
        
        
        let count = list.count
        
        

        
        var testList = [car, car2, car3 ,car4, car5, car6, car7, car8, penguin, pbcar, mammoth, whiteFox, snowmobile, iceTrain, armadillo, camel, scorpion, tortoise, spider, desertScourge, sandShark, spider2]

        
        for i in 0...count-1{
            
            enumerateChildNodes(withName: list[i].image) { [self]
                             (node, _) in
                car = node as? SKSpriteNode
                
                testList[i] = node as? SKSpriteNode
                
                testList[i]!.texture = SKTexture(imageNamed: list[i].image)
                testList[i]!.size.width = CGFloat(list[i].width)
                testList[i]!.size.height = CGFloat(list[i].height)
                testList[i]!.physicsBody?.mass = 100000
            }
            
            enumerateChildNodes(withName: "penguin") { [self]
                             (node, _) in
                penguin = node as? SKSpriteNode
                
                
                penguin.physicsBody?.mass = 0.0001
            }
           


            
            
        }

        
        
        
    }
        
    override func update(_ currentTime: TimeInterval) {
        timeLabel.text = "Time: \(gameTimer)"
        timeLabel.position.y = cam.position.y + 550
        timeLabel.position.x = cam.position.x
        cam.position.x = invisFollower.position.x
        cam.position.y = invisFollower.position.y + 300
        winLoseOutlet.position.y = cam.position.y
        
        if (player.position.y >= invisFollower.position.y + 600){
            let moveFollower = SKAction.moveTo(y: player.position.y, duration: 1)
            invisFollower.run(moveFollower)

        }
        
        if (player.position.y <= invisFollower.position.y - 50){
            let moveFollower = SKAction.moveTo(y: player.position.y, duration: 0.3)
            invisFollower.run(moveFollower)
        }
        
        

        let count = list.count
        
        

        
        var testList = [car, car2, car3 ,car4, car5, car6, car7, car8, penguin, pbcar, mammoth, whiteFox, snowmobile, iceTrain, armadillo, camel, scorpion, tortoise, spider, desertScourge, sandShark, spider2]
        
               for i in 0...count-1{
                   
                   
                   
                   enumerateChildNodes(withName: list[i].image) { [self]
                                    (node, _) in
                       testList[i] = node as? SKSpriteNode
                       testList[i]!.physicsBody?.velocity.dx = CGFloat(list[i].dx)
                       testList[i]!.physicsBody?.velocity.dy = CGFloat(list[i].dy)
                       
                       //add special feature for car6
                       
                       
                       
                       
                       
                       if (list[i].x <= 1) {
                           //right
                           if (Int(((testList[i]?.position.x)!)) > -1 * list[i].x){
                               testList[i]?.position.x = CGFloat((list[i].x))
                               //cars going right dont work
                               //left negative // right positive
                               
                               
                               
                           }
                       }
                       else if (list[i].x > 1){
                           //left
                           if (Int((testList[i]?.position.x)!) < -1 * list[i].x){
                               testList[i]?.position.x = CGFloat(list[i].x)
                            }
                       }
                       
                       
                       
                       
                       
                       
                   } //end func
                   
                   
                   
               }

        
        
        
        
        
       
      
        
        



        
        
        
    }  //end update
    
    func crash(){
        winLoseOutlet.text = "You Died"
        player.physicsBody?.allowsRotation = true
        player.physicsBody?.friction = 0.5
        player.removeAllActions()
        gameOver = true
        GameOver()
    }

    func didBegin(_ contact: SKPhysicsContact) {
        
        let count = list.count
             for i in 0...count-1{
                 
             
                 if (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == list[i].image) || (contact.bodyB.node?.name == "player" && contact.bodyA.node?.name == list[i].image){
                     
                     if (contact.bodyA.node?.name == "player" && contact.bodyB.node?.name == "penguin") || (contact.bodyB.node?.name == "player" && contact.bodyA.node?.name == "penguin"){
                         break
                     }
                     
                     else{
                         crash()
                     }
                     
                     
                     //special feature later for car6
                     
                     }
                 
                 
                 
                 
             }

        
        

        
        
        
    }
    
    
    
    
    func startTimer()  {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        gameTimer += 1
    }
    
    //add keys for the movements below
    
        func jumpUp(){
        if gameOver == false{
            if(player.position.y >= 6900 && player.position.y < 16000){
                let slowedJumpAction = SKAction.moveBy(x: 0, y: 100, duration: 0.6)
                player.run(slowedJumpAction)
            }
            else if(player.position.y >= 16000 && player.position.y < 19000){
                let fastJumpAction = SKAction.moveBy(x: 0, y: 100, duration: 0.15)
                player.run(fastJumpAction)
            }
            else{
                let jumpAction = SKAction.moveBy(x: 0, y: 100, duration: 0.3)
                player.run(jumpAction)
            }
        }
    }
    
    func jumpDown(){
        if gameOver == false{
            if(player.position.y >= 6900 && player.position.y < 16000){
                let slowedJumpAction = SKAction.moveBy(x: 0, y: -100, duration: 0.6)
                player.run(slowedJumpAction)
            }
            else if(player.position.y >= 16000 && player.position.y < 19000){
                let fastJumpAction = SKAction.moveBy(x: 0, y: -100, duration: 0.15)
                player.run(fastJumpAction)
            }
            else{
                let jumpAction = SKAction.moveBy(x: 0, y: -100, duration: 0.3)
                player.run(jumpAction)
            }
        }
    }
    
    func jumpLeft(){
        if gameOver == false{
            if(player.position.y >= 6900 && player.position.y < 16000){
                let slowedJumpAction = SKAction.moveBy(x: -100, y: 0, duration: 0.35)
                player.run(slowedJumpAction)
            }
            else if(player.position.y >= 16000 && player.position.y < 19000){
                let fastJumpAction = SKAction.moveBy(x: -100, y: 0, duration: 0.075)
                player.run(fastJumpAction)
            }
            else {
                let jumpAction = SKAction.moveBy(x: -100, y: 0, duration: 0.15)
                player.run(jumpAction)
            }
        }
    }
    
    func jumpRight(){
        if gameOver == false{
            if(player.position.y >= 6900 && player.position.y < 16000){
                let slowedJumpAction = SKAction.moveBy(x: 100, y: 0, duration: 0.35)
                player.run(slowedJumpAction)
            }
            else if(player.position.y >= 16000 && player.position.y < 19000){
                    let fastJumpAction = SKAction.moveBy(x: 100, y: 0, duration: 0.075)
                    player.run(fastJumpAction)
            }
            else{
                let jumpAction = SKAction.moveBy(x: 100, y: 0, duration: 0.15)
                player.run(jumpAction)
            }
        }
    }
    
    
    
    
    
    func GameOver(){
        player.physicsBody?.velocity.dy = 0

    
    }
    
    func restart(){
        player.physicsBody?.velocity.dx = 0
        player.physicsBody?.velocity.dy = 0
        gameOver = false
        winLoseOutlet.text = ""
        player.physicsBody?.friction = 0
        player.zPosition = 0
        player.zRotation = 0
        player.physicsBody?.allowsRotation = false
        player.position.y = -795.332
        player.position.x = 1.456
        invisFollower.position.y = player.position.y
        player.removeAllActions()
        let rotateAction = SKAction.rotate(toAngle: 0, duration: 0)
        player.run(rotateAction)
        player.physicsBody?.allowsRotation = false
        invisFollower.removeAllActions()
        gameTimer = 0
        
    }
    
    func debugTeleportation(){
        player.physicsBody?.velocity.dx = 0
        player.physicsBody?.velocity.dy = 0
        gameOver = false
        winLoseOutlet.text = ""
        player.physicsBody?.friction = 0
        player.zPosition = 0
        player.zRotation = 0
        player.physicsBody?.allowsRotation = false
        player.position.y = debugTeleport
        player.position.x = 1.456
        invisFollower.position.y = player.position.y
        player.removeAllActions()
        let rotateAction = SKAction.rotate(toAngle: 0, duration: 0)
        player.run(rotateAction)
        invisFollower.removeAllActions()
        gameTimer = 0
    }

    
    
}
