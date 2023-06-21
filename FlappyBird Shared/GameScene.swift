//
//  GameScene.swift
//  FlappyBird Shared
//
//  Created by Alex on 19.06.23.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var backgroundNode: SKNode!
    var birdNode: SKSpriteNode!
    var gameOverLabel: SKLabelNode!
    
    class func newGameScene() -> GameScene {
        guard let scene = SKScene(fileNamed: "GameScene") as? GameScene else {
            print("Failed to load GameScene.sks")
            abort()
        }
        
        scene.scaleMode = .aspectFill

        return scene
    }
    
    func createBackground() {
        backgroundNode = self.childNode(withName: "background")!
        let moveBackground = SKAction.move(by: .init(dx: -2000, dy: 0), duration: 30)
        backgroundNode.run(moveBackground)

    }
    
    func createBird() {
        birdNode = self.childNode(withName: "bird") as! SKSpriteNode
        gameOverLabel = self.childNode(withName: "gameOverLabel") as! SKLabelNode
        gameOverLabel.alpha = 0
    }
    
    override func didMove(to view: SKView) {
        createBackground()
        createBird()
        self.physicsWorld.contactDelegate = self
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        birdNode.physicsBody!.applyImpulse(.init(dx: 0, dy: 3))
    }
    
    func stopGame() {
        backgroundNode.removeAllActions()
        birdNode.physicsBody?.pinned = true
        gameOverLabel.run(SKAction.fadeIn(withDuration: 0.5))
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        stopGame()
    }

}
