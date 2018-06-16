import UIKit

public class BootView:UIView{
    
    var centreCircle:CAShapeLayer!
    var firstCircle:CAShapeLayer!
    var secondCircle:CAShapeLayer!
    var loadComplete:Bool = false
    
    override public init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 700, height: 500))
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     public override func draw(_ rect: CGRect) {
        setupLayers()
    }
    
    func setupLayers(){
        
        let blayer = CAShapeLayer()
        let path = UIBezierPath(arcCenter: self.center, radius: 60, startAngle: -(CGFloat.pi/2), endAngle: CGFloat.pi*1.5, clockwise: true).cgPath
        blayer.path = path
        blayer.strokeColor = UIColor.white.cgColor
        blayer.opacity = 0.3
        blayer.lineWidth = 20
        
        firstCircle = CAShapeLayer()
        firstCircle.path = path
        firstCircle.strokeColor = UIColor(red: 98/255, green: 191/255, blue: 233/255, alpha: 1).cgColor
        firstCircle.lineWidth = 20
        firstCircle.strokeEnd = 0
        
        secondCircle = CAShapeLayer()
        secondCircle.path = UIBezierPath(arcCenter: self.center, radius: 30, startAngle: CGFloat.pi*1.5, endAngle: -(CGFloat.pi/2), clockwise: false).cgPath
        secondCircle.strokeColor = UIColor.white.cgColor
        secondCircle.opacity = 0.6
        secondCircle.lineWidth = 10
        secondCircle.strokeEnd = 0
    
        self.layer.addSublayer(blayer)
        self.layer.addSublayer(firstCircle)
        self.layer.addSublayer(secondCircle)
        
    }
    
    public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        animate()
    }
    
    public override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        reverseAnimate()
        if loadComplete == true{
                let mainScreen = MainScreen()
                let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromTop, .showHideTransitionViews]
                UIView.transition(with: self.superview!, duration: 1.0, options: transitionOptions, animations: {
                    self.isHidden = true
                    self.superview?.addSubview(mainScreen)
                    mainScreen.isHidden = false
                })
        }
    }
    
    func animate(){
        CATransaction.begin()
        let pathAnimation = CABasicAnimation(keyPath: "strokeEnd")
        pathAnimation.duration = 3.0
        pathAnimation.fromValue = 0.0
        pathAnimation.toValue = 1.0
        pathAnimation.fillMode = kCAFillModeForwards
        pathAnimation.isRemovedOnCompletion = false
        loadComplete = false
        CATransaction.setCompletionBlock {
            self.loadComplete = true
        }
        
        firstCircle.add(pathAnimation, forKey: "strokeEnd")
        secondCircle.add(pathAnimation, forKey: "strokeEnd")
        CATransaction.commit()
    }
    
    func reverseAnimate(){
        if loadComplete == false{
            let revAnimation = CABasicAnimation(keyPath: "strokeEnd")
            revAnimation.duration = 1.0
            revAnimation.fromValue = firstCircle.presentation()?.strokeEnd
            revAnimation.toValue = 0.0
            firstCircle.removeAllAnimations()
            firstCircle.add(revAnimation, forKey: "strokeEnd")
            secondCircle.removeAllAnimations()
            secondCircle.add(revAnimation, forKey: "strokeEnd")
        }else{
            
        }
    }
    
}

