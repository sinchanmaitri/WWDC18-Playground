import Foundation
import UIKit
import SpriteKit

public class iOSGameView:UIView{
    
    var mainScreen:MainScreen!
    
    override public init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 700, height: 500))
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func draw(_ rect: CGRect) {
        
        let scene = iOSGameScene(size: self.bounds.size)
        let skView = SKView(frame: self.frame)
        //        skView.showsFPS = true
        //        skView.showsNodeCount = true
        //        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        addSubview(skView)
        
        skView.presentScene(scene)
        
    }
    
    public func backToMainScreen(){
        mainScreen = MainScreen()
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]

        UIView.transition(with: self.superview!, duration: 1.0, options: transitionOptions, animations: {
            self.isHidden = true
            self.superview?.addSubview(self.mainScreen)
            self.mainScreen.isHidden = false
            
        })
    }
    
}
