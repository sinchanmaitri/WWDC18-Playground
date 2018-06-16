import UIKit
import AVFoundation

public class MainScreen:UIView{
    
    var firstOption:OptionView!
    var secondOption:OptionView!
    var thirdOption:OptionView!
    var wwdcTitle:UILabel!
    var instructionLabel:UILabel!
    var futuristicView:FuturisticView!
    var secondView:UIView!
    
    var clickSound = URL(fileURLWithPath: Bundle.main.path(forResource: "click", ofType: "wav")!)
    var audioPlayer = AVAudioPlayer()
    
    override public init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 700, height: 500))
        self.backgroundColor = UIColor(red: 41/255, green: 43/255, blue: 54/255, alpha: 1)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func draw(_ rect: CGRect) {
        
        let padding = self.frame.width/20
        
        let gradient = CAGradientLayer()
        let firstColor = UIColor(red: 11/255, green: 34/255, blue: 63/255, alpha: 1).cgColor
        let secondColor = UIColor(red: 84/255, green: 118/255, blue: 147/255, alpha: 1).cgColor
        gradient.frame = self.bounds
        gradient.colors = [secondColor, firstColor]
        self.layer.insertSublayer(gradient, at: 0)
        
        firstOption = OptionView(withSuperviewSize: self.frame.size, horizontalSpacing: padding, padding: padding, titleName: "Complete Code", coverImageName: "code.jpg")
        addShadow(option: firstOption)
        firstOption.tag = 0
        firstOption.addTarget(self, action: #selector(transit(_:)), for: .touchUpInside)
        if MyVariables.codeCompleted == true {
            firstOption.backgroundColor = UIColor(red: 79/255, green: 206/255, blue: 178/255, alpha: 1)
            firstOption.isEnabled = false
        }
        firstOption.center.y += self.frame.height
        self.addSubview(firstOption)
        
        secondOption = OptionView(withSuperviewSize: self.frame.size, horizontalSpacing: firstOption.frame.width+2*(padding), padding: padding, titleName: "Update iPhone", coverImageName: "game.jpg")
        addShadow(option: secondOption)
        secondOption.tag = 1
        secondOption.addTarget(self, action: #selector(transit(_:)), for: .touchUpInside)
        if MyVariables.iphoneUpdated == true {
            secondOption.backgroundColor = UIColor(red: 79/255, green: 206/255, blue: 178/255, alpha: 1)
            secondOption.isEnabled = false
        }
        secondOption.center.y += self.frame.height
        self.addSubview(secondOption)
        
        thirdOption = OptionView(withSuperviewSize: self.frame.size, horizontalSpacing: 2*(firstOption.frame.width)+3*(padding), padding: padding, titleName: "Book Tickets", coverImageName: "flight.jpg")
        addShadow(option: thirdOption)
        thirdOption.tag = 2
        thirdOption.addTarget(self, action: #selector(transit(_:)), for: .touchUpInside)
        if MyVariables.codeCompleted == false || MyVariables.iphoneUpdated == false{
            thirdOption.alpha = 0.5
            thirdOption.isEnabled = false
        }
        thirdOption.center.y += self.frame.height
        self.addSubview(thirdOption)
        
        UIView.animate(withDuration: 0.5, delay: 0.7, options: .curveEaseInOut, animations: {
            self.firstOption.center.y -= self.frame.height
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 1, options: .curveEaseInOut, animations: {
            self.secondOption.center.y -= self.frame.height
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 1.3, options: .curveEaseInOut, animations: {
            self.thirdOption.center.y -= self.frame.height
        }, completion: nil)
        
        wwdcTitle = UILabel(frame: CGRect(x: padding, y: self.frame.width/40, width: self.frame.width-firstOption.frame.width-padding, height: firstOption.frame.height))
        wwdcTitle.contentMode = .top
        wwdcTitle.text = "WWDC\n2018"
        wwdcTitle.font = UIFont(name: "Avenir-Black", size: wwdcTitle.frame.height/2)
        wwdcTitle.numberOfLines = 0
        wwdcTitle.sizeToFit()
        wwdcTitle.setLineSpacing(lineSpacing: 0, lineHeightMultiple: 0.7)
        wwdcTitle.textColor = .white
        self.addSubview(wwdcTitle)
        
        futuristicView = FuturisticView(rFrame: CGRect(x: self.frame.width/2-thirdOption.frame.width/2-self.frame.width/40, y: wwdcTitle.frame.origin.y, width: thirdOption.frame.width, height: thirdOption.frame.width))
        futuristicView.layer.shadowColor = UIColor.black.cgColor
        futuristicView.layer.shadowOffset = CGSize(width: 0, height: 0)
        futuristicView.layer.shadowRadius = 10
        futuristicView.layer.shadowOpacity = 0.7
        futuristicView.layer.masksToBounds = false
        self.addSubview(futuristicView)
        
        let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotationAnimation.fromValue = 0.0
        rotationAnimation.toValue = CGFloat.pi*2.0
        rotationAnimation.duration = 3
        rotationAnimation.repeatCount = Float.infinity
        //futuristicView.layer.add(rotationAnimation, forKey: "rotationanim")
        //Couldn't figure out a proper way to rotate the layer of futuristicView as Anchor Point dislocates along with the it's frame's origin. Can't manually set it either
        
        instructionLabel = UILabel(frame: CGRect(x: padding, y: firstOption.frame.origin.y-padding*1.5, width: self.frame.width-2*padding, height: padding*1.5))
        instructionLabel.text = "Hey there ! Can you help me with these tasks so that I can attend Dub Dub ?"
        instructionLabel.font = UIFont(name: "Avenir-Medium", size: padding/2.5)
        instructionLabel.textColor = UIColor.white
        self.addSubview(instructionLabel)
        
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: clickSound)
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
        }
        catch{
            print(error)
        }
    
    }
    
    @objc func transit(_ sender: Any){
        let tag = (sender as AnyObject).tag
        if tag == 0 {
            secondView = XcodeView()
            let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
            UIView.transition(with: self.superview!, duration: 1.0, options: transitionOptions, animations: {
                self.isHidden = true
                self.superview?.addSubview(self.secondView)
                self.secondView.isHidden = false
            })
        }else if tag == 1 {
            secondView = iOSGameView()
            let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
            UIView.transition(with: self.superview!, duration: 1.0, options: transitionOptions, animations: {
                self.isHidden = true
                self.superview?.addSubview(self.secondView)
                self.secondView.isHidden = false
            })
        }else{
            secondView = BookTicketsView()
            let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
            UIView.transition(with: self.superview!, duration: 1.0, options: transitionOptions, animations: {
                self.isHidden = true
                self.superview?.addSubview(self.secondView)
                self.secondView.isHidden = false
            })
        }
        audioPlayer.play()
        
    }
    
    func addShadow(option:OptionView){
        let shadowLayer = UIView(frame: option.frame)
        shadowLayer.layer.shadowPath = UIBezierPath(roundedRect: option.bounds, cornerRadius: (self.frame.width/20)/3).cgPath
        shadowLayer.backgroundColor = UIColor.clear
        shadowLayer.layer.shadowColor = UIColor.black.cgColor
        shadowLayer.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowLayer.layer.shadowRadius = 10
        shadowLayer.layer.shadowOpacity = 0.7
        shadowLayer.layer.masksToBounds = false
        self.addSubview(shadowLayer)
    }
}

