import UIKit
import SpriteKit


public struct MyVariables {
    static public var ticketsBooked:Bool = false
    static public var codeCompleted:Bool = false
    static public var iphoneUpdated:Bool = false
}

public extension UILabel {
    
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // Line spacing attribute
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
}


public extension UIImage {
    func imageWithInsets(insets: UIEdgeInsets) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(
            CGSize(width: self.size.width + insets.left + insets.right,
                   height: self.size.height + insets.top + insets.bottom), false, self.scale)
        let _ = UIGraphicsGetCurrentContext()
        let origin = CGPoint(x: insets.left, y: insets.top)
        self.draw(at: origin)
        let imageWithInsets = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageWithInsets
    }
}


//-------------------iOSGameScene Extensions-----------------
extension iOSGameScene: UpdateButtonDelegate {
    
    func didTapUpdate(sender: UpdateButton) {
        
        self.enumerateChildNodes(withName: "initialSceneItem") { (node, stop) in
            let fadeOutAction = SKAction.fadeOut(withDuration: 1)
            fadeOutAction.timingMode = .easeInEaseOut
            node.run(fadeOutAction, completion: {
                node.removeFromParent()
                self.removeAllActions()
            })
        }
        self.startCountDown()
    }
}

extension iOSGameScene: ReplayButtonDelegate {
    
    func didTapReplay(sender: ReplayButton) {
  
        self.enumerateChildNodes(withName: "gameOverItem") { (node, stop) in
            let fadeOutAction = SKAction.fadeOut(withDuration: 1)
            fadeOutAction.timingMode = .easeInEaseOut
            node.run(fadeOutAction, completion: {
                node.removeFromParent()
                self.removeAllActions()
            })
        }
        self.startCountDown()
    }
}

extension iOSGameScene: MainMenuButtonDelegate {
    
    func didTapMainMenu(sender: MainMenuButton) {
        let view = self.view?.superview as! iOSGameView!
        view?.backToMainScreen()
    }
}

//Gradient
public enum GradientDirection {
    case Up
    case Left
    case UpLeft
    case UpRight
}

public extension SKTexture {
    
    convenience init(size: CGSize, color1: CIColor, color2: CIColor, direction: GradientDirection = .Up) {
        
        let context = CIContext(options: nil)
        let filter = CIFilter(name: "CILinearGradient")
        var startVector: CIVector
        var endVector: CIVector
        
        filter!.setDefaults()
        
        switch direction {
        case .Up:
            startVector = CIVector(x: size.width * 0.5, y: 0)
            endVector = CIVector(x: size.width * 0.5, y: size.height)
        case .Left:
            startVector = CIVector(x: size.width, y: size.height * 0.5)
            endVector = CIVector(x: 0, y: size.height * 0.5)
        case .UpLeft:
            startVector = CIVector(x: size.width, y: 0)
            endVector = CIVector(x: 0, y: size.height)
        case .UpRight:
            startVector = CIVector(x: 0, y: 0)
            endVector = CIVector(x: size.width, y: size.height)
        }
        
        filter!.setValue(startVector, forKey: "inputPoint0")
        filter!.setValue(endVector, forKey: "inputPoint1")
        filter!.setValue(color1, forKey: "inputColor0")
        filter!.setValue(color2, forKey: "inputColor1")
        
        let image = context.createCGImage(filter!.outputImage!, from: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        self.init(cgImage: image!)
    }
}



public extension UIButton{
    func vibrate(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10.0, y: self.center.y))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10.0, y: self.center.y))
        self.layer.add(animation, forKey: "position")
    }
}

