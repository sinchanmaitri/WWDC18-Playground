import UIKit

public class EndScreen:UIView{
    
    var me:UIImageView!
    var theEndLabel:UILabel!
    
    override public init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 700, height: 500))
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func draw(_ rect: CGRect) {
        
        setupBackground()
        setupView()
        
    }
    
    func setupBackground(){
        let gradient = CAGradientLayer()
        let firstColor = UIColor(red: 11/255, green: 34/255, blue: 63/255, alpha: 1).cgColor
        let secondColor = UIColor(red: 84/255, green: 118/255, blue: 147/255, alpha: 1).cgColor
        gradient.frame = self.bounds
        gradient.colors = [secondColor, firstColor]
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func setupView(){
        theEndLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width/8+self.frame.width/20))
        theEndLabel.font = UIFont(name: "Avenir-Black", size: self.frame.width/20)
        theEndLabel.textAlignment = .center
        theEndLabel.textColor = .white
        theEndLabel.alpha = 0
        theEndLabel.center.y -= self.frame.height
        theEndLabel.text = "Thats it !"
        addSubview(theEndLabel)
        
        me = UIImageView(frame: CGRect(x: self.frame.width/8, y: self.frame.width/8+self.frame.width/20, width: self.frame.width-self.frame.width/4, height: self.frame.height-self.frame.width/4))
        me.image = UIImage(named: "me.png")
        me.contentMode = .scaleAspectFill
        me.center.y += self.frame.height
        me.alpha = 0
        self.addSubview(me)
        
        UIView.animate(withDuration: 1.5, animations: {
            self.me.alpha = 1
            self.me.center.y -= self.frame.height
            self.theEndLabel.alpha = 1
            self.theEndLabel.center.y += self.frame.height
        })
    }
    
}
