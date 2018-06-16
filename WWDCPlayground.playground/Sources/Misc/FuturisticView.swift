import UIKit

public class FuturisticView:UIView{
    public init(rFrame: CGRect) {
        super.init(frame: rFrame)
        self.backgroundColor = UIColor.clear
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func draw(_ rect: CGRect) {
        let mainPath = UIBezierPath(arcCenter: self.center, radius: self.frame.width/2-(self.frame.width/7)/4, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi*1.5, clockwise: true).cgPath
        let mainCircle = CAShapeLayer()
        mainCircle.path = mainPath
        mainCircle.strokeColor = UIColor.white.cgColor
        mainCircle.lineWidth = (self.frame.width/7)/2
        mainCircle.fillColor = UIColor.clear.cgColor
        
        self.layer.addSublayer(mainCircle)
        
        let arcColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.6).cgColor
        let arcRadius = self.frame.width/4
        let arcLineWidth:CGFloat = arcRadius/4
        
        let path1 = UIBezierPath(arcCenter: self.center, radius: arcRadius, startAngle: CGFloat.pi*1.5, endAngle: 0, clockwise: true).cgPath
        let arc1 = CAShapeLayer()
        arc1.path = path1
        arc1.strokeColor = arcColor
        arc1.lineWidth = arcLineWidth
        arc1.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(arc1)
        
        let path2 = UIBezierPath(arcCenter: self.center, radius: arcRadius, startAngle: CGFloat.pi/2, endAngle: CGFloat.pi, clockwise: true).cgPath
        let arc2 = CAShapeLayer()
        arc2.path = path2
        arc2.strokeColor = arcColor
        arc2.fillColor = UIColor.clear.cgColor
        
        arc2.lineWidth = arcLineWidth
        self.layer.addSublayer(arc2)
        
        let path3 = UIBezierPath(arcCenter: self.center, radius: self.frame.width/8, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi, clockwise: true).cgPath
        let arc3 = CAShapeLayer()
        arc3.path = path3
        arc3.strokeColor = UIColor.black.cgColor
        arc3.lineWidth = self.frame.width/20
        arc3.fillColor = UIColor.clear.cgColor
        
        self.layer.addSublayer(arc3)
        
        let path4 = UIBezierPath(arcCenter: self.center, radius: self.frame.width/16, startAngle: -CGFloat.pi/2, endAngle: CGFloat.pi*1.5, clockwise: true).cgPath
        let smallCircle = CAShapeLayer()
        smallCircle.path = path4
        smallCircle.fillColor = UIColor(red: 251/255, green: 107/255, blue: 131/255, alpha: 1).cgColor
        self.layer.addSublayer(smallCircle)
    }
}


