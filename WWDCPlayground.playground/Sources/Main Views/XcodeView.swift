import UIKit

public class XcodeView:UIView, UITableViewDataSource, UITableViewDelegate, UITextViewDelegate{
    
    var titleBar:UIView!
    var titleHolder:UIView!
    var sideBar:UIVisualEffectView!
    var guideLabel:UILabel!
    var swiftFilesView:UITableView!
    var completeBtn:UIButton!
    var codeView:UIImageView!
    var optionsView:UIVisualEffectView!
    var option1,option2,option3,option4:UIButton!
    var questionView:UILabel!
    
    var mainScreen:MainScreen!
    
    let items = ["Main.swift","myView.swift","newView.swift","oldView.swift"]
    
    let codeImages = ["swift1.png","swift2.png","swift3.png","swift4.png"]
    let questions = ["Call the function to return true.", "Initialize the custom UIView to get it's live view.","Set the background color of the view newView.","Set the alpha of oldView to 0.5."]
    let options = [["i-2.png","i-1.png","i-5.png","i-33.png"],["ii-myView.png","ii-liveView.png","ii-no().png","ii-uiview.png"],["iii-backgroundColor.png","iii-newView.color.png","iii-self.color.png","iii-self.png"],["iv-self.alpha.png","iv-oldView.png","iv-oldView(alpha).png","iv-alpha.png"]]
    
    var currentQuestion = 0
    var rightAnswerPlacement : UInt32 = 0
    
    var score:Int = 0
    
    override public init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 700, height: 500))
        self.backgroundColor = UIColor(red: 41/255, green: 43/255, blue: 54/255, alpha: 1)
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func draw(_ rect: CGRect) {
        
        titleBar = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height/10))
        titleBar.backgroundColor = UIColor(red: 230/255, green: 228/255, blue: 230/255, alpha: 1)
        self.addSubview(titleBar)
        
        sideBar = UIVisualEffectView(frame: CGRect(x: 0, y: titleBar.frame.height, width: self.frame.width/4, height: self.frame.height-titleBar.frame.height))
        sideBar.effect = UIBlurEffect(style: .extraLight)
        self.addSubview(sideBar)
        
        guideLabel = UILabel(frame: CGRect(x: 0, y: sideBar.frame.height/2, width: sideBar.frame.width, height: sideBar.frame.height/2))
        guideLabel.font = UIFont(name: "Avenir-Book", size: sideBar.frame.height/24)
        guideLabel.textAlignment = .center
        guideLabel.numberOfLines = 0
        guideLabel.text = "Do as the instruction says."
        sideBar.contentView.addSubview(guideLabel)
        
        completeBtn = UIButton(frame: CGRect(x: sideBar.frame.width, y: self.frame.height-titleBar.frame.height, width: self.frame.width-sideBar.frame.width, height: titleBar.frame.height))
        completeBtn.backgroundColor = UIColor(red: 79/255, green: 206/255, blue: 178/255, alpha: 1)
        completeBtn.setTitleColor(UIColor.white, for: .normal)
        completeBtn.setTitleColor(UIColor.black, for: .highlighted)
        completeBtn.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: completeBtn.frame.height/2)
        completeBtn.setTitleColor(UIColor(red: 1, green: 1, blue: 1, alpha: 0.5), for: .disabled)
        completeBtn.addTarget(self, action: #selector(backToMainScreen(_:)), for: .touchUpInside)
        completeBtn.tag = 11
        completeBtn.setTitle("Complete", for: .normal)
        completeBtn.isEnabled = false
        self.addSubview(completeBtn)
        
        titleHolder = UIView(frame: CGRect(x: self.frame.width/14, y: 0, width: self.frame.width/5, height: titleBar.frame.height/2.5))
        titleHolder.center = titleBar.center
        
        let xcodeIcon = UIImageView(image: UIImage(named: "xcode-icon.png"))
        xcodeIcon.frame = CGRect(x: 0, y: 0, width: titleBar.frame.height/3, height: titleBar.frame.height/3)
        titleHolder.addSubview(xcodeIcon)
        titleBar.addSubview(titleHolder)
        
        let xcodeTitle = UILabel(frame: CGRect(x: 1.5*titleBar.frame.height/3, y: 0, width: titleHolder.frame.width-1.5*titleBar.frame.height/3, height: titleBar.frame.height/3))
        xcodeTitle.text = "Xcode - WWDC 2018"
        xcodeTitle.sizeToFit()
        xcodeTitle.font = UIFont(name: "Avenir-Medium", size: xcodeTitle.font.pointSize)
        titleHolder.addSubview(xcodeTitle)
        
        let closeBtn = UIButton(frame: CGRect(x: titleHolder.frame.origin.y, y: titleHolder.frame.origin.y, width: titleHolder.frame.height, height: titleHolder.frame.height))
        closeBtn.setImage(UIImage(named: "close-icon.png"), for: .normal)
        closeBtn.addTarget(self, action: #selector(backToMainScreen(_:)), for: .touchUpInside)
        closeBtn.tag = 12
        titleBar.addSubview(closeBtn)
        
        swiftFilesView = UITableView(frame: CGRect(x: 0, y: 0, width: sideBar.frame.width, height: sideBar.frame.height/2))
        swiftFilesView.dataSource = self
        swiftFilesView.delegate = self
        swiftFilesView.separatorStyle = UITableViewCellSeparatorStyle.none
        swiftFilesView.backgroundColor = .clear
        swiftFilesView.isScrollEnabled = false
        sideBar.contentView.addSubview(swiftFilesView)
        
        codeView = UIImageView(frame: CGRect(x: sideBar.frame.width, y: titleBar.frame.height, width: self.frame.width-sideBar.frame.width, height: (self.frame.height-2*titleBar.frame.height)/2))
        codeView.image = UIImage(named: "instruction.png")
        codeView.contentMode = .scaleAspectFit
        self.addSubview(codeView)
        
        questionView = UILabel(frame: CGRect(x: sideBar.frame.width+sideBar.frame.width/10, y: codeView.frame.origin.y+codeView.frame.height, width: self.frame.width-(sideBar.frame.width-2*sideBar.frame.width/10), height: titleBar.frame.height))
        questionView.font = UIFont(name: "Avenir-Medium", size: questionView.frame.height/4)
        questionView.textColor = .white
        self.addSubview(questionView)
        
        optionsView = UIVisualEffectView(frame: CGRect(x: sideBar.frame.width, y: questionView.frame.origin.y+questionView.frame.height, width: self.frame.width-sideBar.frame.width, height: codeView.frame.height-questionView.frame.height))
        optionsView.effect = UIBlurEffect(style: .dark)
        self.addSubview(optionsView)
        
        option1 = UIButton(frame: CGRect(x: 0, y: 0, width: optionsView.frame.width/2, height: optionsView.frame.height/2))
        option1.tag = 1
        
        option2 = UIButton(frame: CGRect(x: optionsView.frame.width/2, y: 0, width: optionsView.frame.width/2, height: optionsView.frame.height/2))
        option2.tag = 2
        
        option3 = UIButton(frame: CGRect(x: 0, y: optionsView.frame.height/2, width: optionsView.frame.width/2, height: optionsView.frame.height/2))
        option3.tag = 3
        
        option4 = UIButton(frame: CGRect(x: optionsView.frame.width/2, y: optionsView.frame.height/2, width: optionsView.frame.width/2, height: optionsView.frame.height/2))
        option4.tag = 4
        
        self.questionView.alpha = 0
        self.optionsView.alpha = 0
        
        optionsView.contentView.addSubview(option1)
        optionsView.contentView.addSubview(option2)
        optionsView.contentView.addSubview(option3)
        optionsView.contentView.addSubview(option4)
        
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = SwiftFileCell()
        cell.textLabel?.text = self.items[indexPath.row]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let selectionColor = UIView() as UIView
        selectionColor.backgroundColor =  UIColor(red: 74/255, green: 144/255, blue: 226/255, alpha: 1)
        tableView.cellForRow(at: indexPath)?.selectedBackgroundView = selectionColor
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guideLabel.text = "Choose the correct swift code for the intent."
        codeView.image = UIImage(named: codeImages[indexPath.row])?.imageWithInsets(insets: UIEdgeInsetsMake(15, 15, 15, 15))
        questionView.text = questions[indexPath.row]
        setupQuestion(indexRow: indexPath.row)
    }
    
    func setupQuestion(indexRow: Int){
        UIView.animate(withDuration: 0.5, animations: {
            self.questionView.alpha = 1
            self.optionsView.alpha = 1
        })
        currentQuestion = indexRow
        rightAnswerPlacement = arc4random_uniform(3)+1
        var button = UIButton()
        var x = 1
        for i in 1...4 {
            button = self.viewWithTag(i) as! UIButton
            if (i == Int(rightAnswerPlacement)){
                button.setImage(UIImage(named: options[currentQuestion][0])?.imageWithInsets(insets: UIEdgeInsetsMake(30, 30, 30, 30)), for: .normal)
            }
            else {
                button.setImage(UIImage(named: options[currentQuestion][x]), for: .normal)
                x += 1
            }
            if(i == 1 || i == 4){
                button.backgroundColor = UIColor(red: 41/255, green: 43/255, blue: 54/255, alpha: 0.6)
            }
            button.addTarget(self, action: #selector(nextCode(_:)), for: .touchUpInside)
            button.contentMode = .scaleAspectFit
        }
        
    }
    
    @objc func nextCode(_ sender: Any){
        if ((sender as AnyObject).tag == Int(rightAnswerPlacement)) {
            print("RIGHT")
            score += 1
            guideLabel.text = "Click the next file"
            UIView.animate(withDuration: 0.5, animations: {
                self.questionView.alpha = 0
                self.optionsView.alpha = 0
            })
            swiftFilesView.cellForRow(at: IndexPath(row: currentQuestion, section: 0))?.isUserInteractionEnabled = false
            swiftFilesView.cellForRow(at: IndexPath(row: currentQuestion, section: 0))?.contentView.backgroundColor = UIColor(red: 79/255, green: 206/255, blue: 178/255, alpha: 1)
            swiftFilesView.cellForRow(at: IndexPath(row: currentQuestion, section: 0))?.contentView.alpha = 0.5
            
            if(score == 4){
                guideLabel.text = "Click \"Complete\""
                completeBtn.isEnabled = true
            }
            
        }
        else{
            print("WRONG!")
            guideLabel.text = "Incorrect Code"
        }
    }
    
    @objc public func backToMainScreen(_ sender: UIButton){
        if sender.tag == 11{
            MyVariables.codeCompleted = true
        }else if sender.tag == 12{
            
        }
        mainScreen = MainScreen()
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        UIView.transition(with: self.superview!, duration: 1.0, options: transitionOptions, animations: {
            self.isHidden = true
            self.superview?.addSubview(self.mainScreen)
            self.mainScreen.isHidden = false
        })
    }
    
}

class SwiftFileCell: UITableViewCell {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        self.imageView?.frame = CGRect(x: self.frame.width/10, y: self.frame.height/4, width: self.frame.height/2, height: self.frame.height/2)
        self.textLabel?.frame.origin.x = 1.2*(self.imageView?.frame.width)!+(self.imageView?.frame.origin.x)!
        self.textLabel?.frame.size.width = self.frame.width
        self.imageView?.image = UIImage(named: "swift-icon.png")
        self.textLabel?.font = UIFont(name: "Avenir-Medium", size: self.frame.height/3.5)
        self.selectionStyle = .blue
    }
}

