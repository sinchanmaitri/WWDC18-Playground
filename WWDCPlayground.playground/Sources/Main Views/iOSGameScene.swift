import SpriteKit


public class iOSGameScene:SKScene, SKPhysicsContactDelegate{
    
    let iOSUpdatesIconArray = ["11.png","11.0.1.png","11.0.2.png","11.0.3.png","11.1.png","11.1.1.png","11.1.2.png","11.2.png","11.2.1.png","11.2.2.png","11.2.5.png","11.2.6.png","11.3.png"]
    
    var result:SKSpriteNode!
    
    var defaultPhonePos:CGPoint!
    
    var currentUpdate:Int = 0
    
    var backgroundNode:SKSpriteNode!
    
    var titleLabel:SKLabelNode!
    var iOSVersionNode:SKSpriteNode!
    var instructionLabel:SKLabelNode!
    var updateBtn:UpdateButton!
    var countDownNode:SKLabelNode!
    
    var phoneNode:SKSpriteNode!
    var actionMove:SKAction!
    
    var latestUpdate:SKSpriteNode!
    
    var gameOverLabel:SKLabelNode!
    var replayBtn:ReplayButton!
    
    var mainMenuBtn:MainMenuButton!
    
    public override func didMove(to view: SKView) {
        
        let btnSize = CGSize(width: self.frame.width/1.16, height: self.frame.height/6.172)
        
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -1.6)
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.physicsBody = borderBody
        
        let bottomColor = CIColor(red: 255/255, green: 152/255, blue: 141/255)
        let topColor = CIColor(red: 255/255, green: 227/255, blue: 148/255)
        
        let texture = SKTexture(size: CGSize(width: 200,height: 200), color1: topColor, color2: bottomColor, direction: GradientDirection.Up)
        texture.filteringMode = .nearest
        backgroundNode = SKSpriteNode(texture: texture)
        backgroundNode.position = CGPoint(x: frame.midX ,y: frame.midY)
        backgroundNode.size = self.frame.size
        backgroundNode.zPosition = 0
        addChild(backgroundNode)
        
        titleLabel = SKLabelNode(text: "Update my iPhone")
        titleLabel.fontName = "Avenir-Black"
        titleLabel.position = CGPoint(x: self.frame.width/2, y: self.frame.height-titleLabel.frame.height*2)
        titleLabel.name = "initialSceneItem"
        addChild(titleLabel)
        
        iOSVersionNode = SKSpriteNode(imageNamed: "iOSStart.png")
        iOSVersionNode.size = CGSize(width: self.frame.height/2.9585, height: self.frame.height/2.9585)
        iOSVersionNode.position = CGPoint(x: self.frame.width/3.794, y: self.frame.height-self.frame.height/2)
        iOSVersionNode.name = "initialSceneItem"
        addChild(iOSVersionNode)
        
        instructionLabel = SKLabelNode(text: "Well, I’m late. Can you\ndo me a favour ?\nUpdate my iPhone to\nthe latest iOS 11.3. Avoid\nthe malware & viruses.")
        instructionLabel.fontSize = self.frame.height/20.408
        instructionLabel.numberOfLines = 0
        instructionLabel.lineBreakMode = .byWordWrapping
        instructionLabel.fontName = "Avenir-Medium"
        instructionLabel.name = "initialSceneItem"
        instructionLabel.position = CGPoint(x: self.frame.width-self.frame.width/2.9787, y: self.frame.height-self.frame.height/1.5)
        addChild(instructionLabel)
        
        updateBtn = UpdateButton(size: btnSize, delegate: self)
        updateBtn.name = "initialSceneItem"
        updateBtn.position = CGPoint(x: titleLabel.position.x, y: updateBtn.size.height/2)
        addChild(updateBtn)
        
        
        let fadeAndScale = SKAction.group([SKAction.scale(to: 0.1, duration: 1.0),SKAction.fadeAlpha(to: 0.2, duration: 1.0)])
        
        let waitAndAct = SKAction.sequence([SKAction.wait(forDuration: 2.0),fadeAndScale])
        
        iOSVersionNode.run(waitAndAct, completion: { () -> Void in
            self.iOSVersionNode.texture = SKTexture(imageNamed: "iOSEnd.png")
            self.iOSVersionNode.run(SKAction.group([SKAction.scale(to: 1, duration: 1.0),SKAction.fadeAlpha(to: 1, duration: 1.0)]))
        })
        
        self.setupGameScene()
        
        gameOverLabel = SKLabelNode(text: "iPhone compromised")
        gameOverLabel.fontName = "Avenir-Black"
        gameOverLabel.name = "gameOverItem"
        gameOverLabel.position = CGPoint(x: frame.midX, y: frame.midY)
        
        replayBtn = ReplayButton(size: btnSize, delegate: self)
        replayBtn.name = "gameOverItem"
        replayBtn.position = CGPoint(x: titleLabel.position.x, y: replayBtn.size.height/2)
        
        mainMenuBtn = MainMenuButton(size: btnSize, delegate: self)
        mainMenuBtn.position = CGPoint(x: titleLabel.position.x, y: replayBtn.size.height/2)
        
    }
    
    func setupGameScene(){
        
        latestUpdate = SKSpriteNode()
        latestUpdate.size = CGSize(width: self.frame.height/5, height: self.frame.height/5)
        latestUpdate.position = CGPoint(x: self.frame.width/2, y: self.frame.height/2)
        latestUpdate.alpha = 0.5
        
        phoneNode = SKSpriteNode(imageNamed: "iphone.png")
        phoneNode.size = CGSize(width: self.frame.width/15, height: self.frame.width/5)
        defaultPhonePos = CGPoint(x:frame.midX, y:phoneNode.frame.height/2)
        phoneNode.position = defaultPhonePos
        phoneNode.name = "phone"
        phoneNode.zPosition = 1
        phoneNode.physicsBody = SKPhysicsBody(rectangleOf: phoneNode.size)
        phoneNode.physicsBody?.collisionBitMask = 1
        phoneNode.physicsBody?.contactTestBitMask = 1
        phoneNode.physicsBody?.categoryBitMask = 0
        phoneNode.physicsBody?.affectedByGravity = false
        phoneNode.physicsBody?.isDynamic = false
        
    }
    
    func startCountDown(){
        
        countDownNode = SKLabelNode(fontNamed: "Avenir-Black")
        countDownNode.text = ""
        countDownNode.name = "round"
        countDownNode.fontSize = 50
        countDownNode.fontColor = SKColor.black
        countDownNode.position = CGPoint(x: frame.midX , y: frame.midY)
        addChild(countDownNode)
        
        let leftIns = SKLabelNode(fontNamed: "Avenir-Medium")
        leftIns.text = "Tap here for left"
        leftIns.fontSize = 20
        leftIns.alpha = 0
        leftIns.position = CGPoint(x: frame.midX/2 , y: frame.midY)
        addChild(leftIns)
        
        let rightIns = SKLabelNode(fontNamed: "Avenir-Medium")
        rightIns.text = "Tap here for right"
        rightIns.fontSize = 20
        rightIns.alpha = 0
        rightIns.position = CGPoint(x: frame.midX*1.5 , y: frame.midY)
        addChild(rightIns)
        
        countDownNode.alpha = 0
        var fadeOutAction = SKAction.fadeIn(withDuration: 1)
        fadeOutAction.timingMode = .easeInEaseOut
        
        countDownNode.run(fadeOutAction, completion: {
            self.countDownNode.text = "3"
            self.countDownNode.alpha = 1
            leftIns.alpha = 1
            rightIns.alpha = 1
        })
        
        countDownNode.alpha = 0
        fadeOutAction = SKAction.fadeIn(withDuration: 2)
        fadeOutAction.timingMode = .easeInEaseOut
        countDownNode.run(fadeOutAction, completion: {
            self.countDownNode.text = "2"
            self.countDownNode.alpha = 1
        })
        
        countDownNode.alpha = 0
        fadeOutAction = SKAction.fadeIn(withDuration: 3)
        fadeOutAction.timingMode = .easeInEaseOut
        countDownNode.run(fadeOutAction, completion: {
            self.countDownNode.text = "1"
            self.countDownNode.alpha = 1
        })
        
        countDownNode.alpha = 0
        fadeOutAction = SKAction.fadeIn(withDuration: 4)
        fadeOutAction.timingMode = .easeInEaseOut
        countDownNode.run(fadeOutAction, completion: {
            self.countDownNode.text = "Go"
            self.countDownNode.alpha = 1
            leftIns.alpha = 0
            rightIns.alpha = 0
        })
        
        fadeOutAction = SKAction.fadeIn(withDuration: 5)
        fadeOutAction.timingMode = .easeInEaseOut
        countDownNode.run(fadeOutAction, completion: {
            self.countDownNode.text = "Go"
            self.countDownNode.alpha = 0
            self.countDownNode.removeFromParent()
            leftIns.removeFromParent()
            rightIns.removeFromParent()
            self.setupGameScene()
            self.resetValues()
            self.startGame()
        })
        
    }
    
    func resetValues(){
        currentUpdate = 0
        
        phoneNode.alpha = 1
        phoneNode.position = defaultPhonePos
        
        replayBtn.alpha = 1
        gameOverLabel.alpha = 1
    }
    
    func startGame(){
        addChild(latestUpdate)
        addChild(phoneNode)
        
        run(SKAction.repeatForever(
            SKAction.sequence([
                SKAction.run(addItem),
                SKAction.wait(forDuration: 1.0)
                ])
        ))
    }
    
    func addItem(){
        let randoma = Int(random()*(3-0)+0)
        if randoma == 1{
            result = newUpdate()
            result.name = "update"
            result.physicsBody = SKPhysicsBody(rectangleOf: result.size)
            
        }else{
            let r = Int(random()*(3-0)+0)
            if r == 1{
                result = SKSpriteNode(imageNamed: "virus.png")
            }else{
                result = SKSpriteNode(imageNamed: "malware.png")
            }
            result.name = "danger"
        }
        
        result.physicsBody = SKPhysicsBody(rectangleOf: result.size)
        result.physicsBody?.collisionBitMask = 0
        result.physicsBody?.contactTestBitMask = 0
        result.physicsBody?.categoryBitMask = 1
        result.setScale(0.5)
        let actualX = random(min: result.size.width/2, max: size.width - result.size.width/2)
        
        result.position = CGPoint(x: actualX, y: size.height + result.size.height/2)
        result.zPosition = 2
        
        addChild(result)
        
        result.run(SKAction.sequence([SKAction.wait(forDuration: 4.0),SKAction.removeFromParent()]))
        
    }
    
    public func didBegin(_ contact: SKPhysicsContact) {
        let item:SKSpriteNode!
        
        if contact.bodyA.node?.name == "update" {
            item = contact.bodyA.node as! SKSpriteNode
        }else{
            item = contact.bodyB.node as! SKSpriteNode
        }
        
        if contact.bodyA.node?.name == "update" || contact.bodyB.node?.name == "update" {
            item.removeFromParent()
            latestUpdate.texture = SKTexture(imageNamed: iOSUpdatesIconArray[currentUpdate])
            
            if currentUpdate < 12{
                currentUpdate += 1
            }else{
                updateFinished()
            }
        }
        
        if contact.bodyA.node?.name == "danger" || contact.bodyB.node?.name == "danger" {
            gameOver()
        }
    }
    
    func gameOver(){
        let action = SKAction.fadeOut(withDuration: 0.5)
        phoneNode.run(action, completion: {() -> Void in
            self.removeAllChildren()
            self.removeAllActions()
            self.phoneNode = nil
            self.latestUpdate = nil
            self.replayBtn.alpha = 0
            self.gameOverLabel.alpha = 0
            self.addChild(self.backgroundNode)
            self.addChild(self.replayBtn)
            self.addChild(self.gameOverLabel)
            self.replayBtn.run(SKAction.fadeIn(withDuration: 0.5))
            self.gameOverLabel.run(SKAction.fadeIn(withDuration: 0.5))
        })
    }
    
    func updateFinished(){
        let action = SKAction.fadeOut(withDuration: 0.5)
        phoneNode.run(action, completion: {() -> Void in
            self.removeAllChildren()
            self.removeAllActions()
            self.addChild(self.backgroundNode)
            
            self.addChild(self.iOSVersionNode)
            
            self.instructionLabel.text = "Woah ! Thanks for\nupdating my iPhone.\nFeels smooth as silk.\nExcited for iOS 12 !"
            self.addChild(self.instructionLabel)
            
            self.titleLabel.text = "Update Complete"
            self.addChild(self.titleLabel)
            
            self.mainMenuBtn.alpha = 0
            self.addChild(self.mainMenuBtn)
            
            self.iOSVersionNode.run(SKAction.fadeIn(withDuration: 0.5))
            self.instructionLabel.run(SKAction.fadeIn(withDuration: 0.5))
            self.titleLabel.run(SKAction.fadeIn(withDuration: 0.5))
            self.mainMenuBtn.run(SKAction.fadeIn(withDuration: 0.5))
            
            MyVariables.iphoneUpdated = true
        })
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if phoneNode != nil {
            let touch = touches.first?.location(in: self)
            if (touch?.x)! > self.frame.width/2 {
                actionMove = SKAction.moveBy(x: 80, y: 0, duration: 0.2)
            }else{
                actionMove = SKAction.moveBy(x: -80, y: 0, duration: 0.2)
            }
            phoneNode.run(actionMove)
        }
        
        let touch = touches.first!
        if mainMenuBtn.contains(touch.location(in: self)) {
            print("touched")
        }
    }
    
    
    func newUpdate() -> SKSpriteNode{
        
        return SKSpriteNode(imageNamed: iOSUpdatesIconArray[currentUpdate])
        
    }
    
    func random() -> CGFloat {
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    func random(min: CGFloat, max: CGFloat) -> CGFloat {
        return random() * (max - min) + min
    }
    
}



//--------------------------Button Delegates--------------------------------
protocol UpdateButtonDelegate: class {
    func didTapUpdate(sender: UpdateButton)
}

public class UpdateButton: SKSpriteNode{
    
    weak var delegate: UpdateButtonDelegate!
    
    init(size :CGSize, delegate: UpdateButtonDelegate) {
        let texture = SKTexture(imageNamed: "updateBtn")
        let color = SKColor.red
        super.init(texture: texture, color: color, size: size)
        self.delegate = delegate
        isUserInteractionEnabled = true
        zPosition = 1
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        alpha = 0.5
    }
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        performButtonAppearanceResetAnimation()
        self.delegate?.didTapUpdate(sender: self)
    }
    func performButtonAppearanceResetAnimation() {
        let alphaAction = SKAction.fadeAlpha(to: 1.0, duration: 0.10)
        alphaAction.timingMode = .easeInEaseOut
        run(alphaAction)
    }
    
}


protocol ReplayButtonDelegate: class {
    func didTapReplay(sender: ReplayButton)
}

public class ReplayButton: SKSpriteNode{
    
    weak var delegate: ReplayButtonDelegate!
    
    init(size :CGSize, delegate: ReplayButtonDelegate) {
        let texture = SKTexture(imageNamed: "replayBtn")
        let color = SKColor.red
        super.init(texture: texture, color: color, size: size)
        self.delegate = delegate
        isUserInteractionEnabled = true
        zPosition = 1
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        alpha = 0.5
    }
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        performButtonAppearanceResetAnimation()
        self.delegate?.didTapReplay(sender: self)
    }
    func performButtonAppearanceResetAnimation() {
        let alphaAction = SKAction.fadeAlpha(to: 1.0, duration: 0.10)
        alphaAction.timingMode = .easeInEaseOut
        run(alphaAction)
    }
    
}


protocol MainMenuButtonDelegate: class {
    func didTapMainMenu(sender: MainMenuButton)
}

public class MainMenuButton: SKSpriteNode{
    
    weak var delegate: MainMenuButtonDelegate!
    
    init(size :CGSize, delegate: MainMenuButtonDelegate) {
        let texture = SKTexture(imageNamed: "mainMenuBtn")
        let color = SKColor.red
        super.init(texture: texture, color: color, size: size)
        self.delegate = delegate
        isUserInteractionEnabled = true
        zPosition = 1
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        alpha = 0.5
    }
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        performButtonAppearanceResetAnimation()
        self.delegate?.didTapMainMenu(sender: self)
    }
    func performButtonAppearanceResetAnimation() {
        let alphaAction = SKAction.fadeAlpha(to: 1.0, duration: 0.10)
        alphaAction.timingMode = .easeInEaseOut
        run(alphaAction)
    }
    
}

