import UIKit

public class OptionView:UIButton{
    
    var titleText:String!
    var titleLbl:UILabel!
    var coverImageName:String!
    var coverImageView:UIImageView!
    var overlayView:UIView!
    
    public init(withSuperviewSize superViewSize: CGSize, horizontalSpacing space: CGFloat, padding paddingValue:CGFloat, titleName title: String, coverImageName coverImgName: String) {
        
        let height = (superViewSize.width-(paddingValue*4))/3
        let width = (superViewSize.width-(paddingValue*4))/3
        let rect = CGRect(origin: CGPoint(x: space, y: superViewSize.height-height-paddingValue), size: CGSize(width: width, height: height))
        
        super.init(frame: rect)
        self.layer.cornerRadius = paddingValue/3
        self.clipsToBounds = true
        self.backgroundColor = UIColor(red: 251/255, green: 107/255, blue: 131/255, alpha: 1)
        
        titleText = title
        coverImageName = coverImgName
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func draw(_ rect: CGRect) {
        
        coverImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.width-self.frame.height/5))
        coverImageView.image = UIImage(named: coverImageName)
        coverImageView.contentMode = UIViewContentMode.scaleToFill
        self.addSubview(coverImageView)
        
        titleLbl = UILabel(frame: CGRect(x: 0, y: coverImageView.frame.height, width: self.frame.width, height: self.frame.height/5))
        titleLbl.font = UIFont(name: "Avenir-Heavy", size: titleLbl.frame.height/2)
        titleLbl.text = titleText
        titleLbl.textColor = .white
        titleLbl.textAlignment = .center
        self.addSubview(titleLbl)
    }
}
