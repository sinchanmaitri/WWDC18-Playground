import UIKit
import AVFoundation

public class BookTicketsView:UIView, UIPickerViewDelegate, UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate{
    
    var titleBar:UIView!
    var closeBtn:UIButton!
    var titleLabel:UILabel!
    var dummyProgress:UIProgressView!
    var containerView:UIView!
    var ticketsBookedLabel:UILabel!
    
    var fromLabel:UILabel!
    var toLabel:UILabel!
    var classLabel:UILabel!
    
    var fromPicker:UIPickerView!
    var toPicker:UIPickerView!
    var classSelector:UISegmentedControl!
    var bookBtn:UIButton!
    var instructionLabel:UILabel!
    
    var checklistTable:UITableView!
    
    var planeVideo:AVPlayer!
    var planeVideoLayer:AVPlayerLayer!
    
    var finishBtn:UIButton!
    
    var fromValue:String = ""
    var toValue:String = ""
    var classValue:String = ""
    
    var from:[String] = ["Delhi", "Mumbai", "Bangalore"]
    var to:[String] = ["San Fransisco", "San Jose", "New York"]
    
    var todoItems:[String] = ["Complete code", "Update iPhone", "Book Tickets"]
    
    var firstColors:[CGColor] = [UIColor(red: 250/255, green: 217/255, blue: 97/255, alpha: 1).cgColor, UIColor(red: 245/255, green: 81/255, blue: 95/255, alpha: 1).cgColor, UIColor(red: 48/255, green: 35/255, blue: 174/255, alpha: 1).cgColor]
    var secondColors:[CGColor] = [UIColor(red: 247/255, green: 107/255, blue: 28/255, alpha: 1).cgColor, UIColor(red: 159/255, green: 4/255, blue: 27/255, alpha: 1).cgColor, UIColor(red: 200/255, green: 109/255, blue: 215/255, alpha: 1).cgColor]
    
    var mainScreen:MainScreen!
    var endScreen:EndScreen!
    
    override public init(frame: CGRect) {
        super.init(frame: CGRect(x: 0, y: 0, width: 700, height: 500))
        self.backgroundColor = .white
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func draw(_ rect: CGRect) {
        
        let gradient = CAGradientLayer()
        let firstColor = UIColor(red: 3/255, green: 64/255, blue: 214/255, alpha: 1).cgColor
        let secondColor = UIColor(red: 1/255, green: 250/255, blue: 254/255, alpha: 1).cgColor
        gradient.frame = CGRect(x: self.frame.width/2, y: 0, width: self.frame.width/2, height: self.frame.height)
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 1)
        gradient.colors = [firstColor, secondColor]
        self.layer.insertSublayer(gradient, at: 0)
        
        titleBar = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width/2, height: self.frame.height/10))
        titleBar.backgroundColor = UIColor(red: 230/255, green: 228/255, blue: 230/255, alpha: 1)
        self.addSubview(titleBar)
        
        closeBtn = UIButton(frame: CGRect(x: self.frame.height/30, y: self.frame.height/30, width: self.frame.height/25, height: self.frame.height/25))
        closeBtn.setImage(UIImage(named: "close-icon.png"), for: .normal)
        closeBtn.addTarget(self, action: #selector(backToMainScreen(_:)), for: .touchUpInside)
        closeBtn.tag = 12
        titleBar.addSubview(closeBtn)
        
        titleLabel = UILabel(frame: CGRect(x: closeBtn.frame.origin.x+closeBtn.frame.width*1.5, y: self.frame.height/30, width: self.frame.width/2-2*(closeBtn.frame.origin.x+closeBtn.frame.width*1.5), height: self.frame.height/25))
        titleLabel.text = "Apple Air 🛩"
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: "Avenir-Black", size: self.frame.height/25)
        titleBar.addSubview(titleLabel)
        
        dummyProgress = UIProgressView(progressViewStyle: .bar)
        dummyProgress.frame = CGRect(x: 0, y: titleBar.frame.origin.y+titleBar.frame.height, width: self.frame.width/2, height: 50)
        dummyProgress.progressTintColor = UIColor.blue
        dummyProgress.setProgress(0, animated: true)
        
        self.addSubview(dummyProgress)
        
        containerView = UIView(frame: CGRect(x: 0, y: dummyProgress.frame.origin.y+self.frame.height/30, width: self.frame.width/2, height: self.frame.height-dummyProgress.frame.origin.y+self.frame.height/30))
        containerView.alpha = 0
        addSubview(containerView)
        
        let labelFont = UIFont(name: "Avenir-Medium", size: self.frame.height/30)
        
        fromLabel = UILabel(frame: CGRect(x: (self.frame.width/20)/2, y: self.frame.height/30, width: (self.frame.width/2-3*(self.frame.width/20)/2)/2, height: self.frame.height/30))
        fromLabel.text = "From"
        fromLabel.font = labelFont
        containerView.addSubview(fromLabel)
        
        toLabel = UILabel(frame: CGRect(x: fromLabel.frame.origin.x+fromLabel.frame.width+(self.frame.width/20)/2, y: fromLabel.frame.origin.y, width: (self.frame.width/2-3*(self.frame.width/20)/2)/2, height: self.frame.height/30))
        toLabel.text = "To"
        toLabel.font = labelFont
        containerView.addSubview(toLabel)
        
        fromPicker = UIPickerView(frame: CGRect(x: (self.frame.width/20)/2, y: fromLabel.frame.origin.y+fromLabel.frame.height, width: (self.frame.width/2-3*(self.frame.width/20)/2)/2, height: self.frame.height/6))
        fromPicker.dataSource = self
        fromPicker.delegate = self
        fromPicker.tag = 1
        containerView.addSubview(fromPicker)
        
        classLabel = UILabel(frame: CGRect(x: fromPicker.frame.origin.x, y: fromPicker.frame.origin.y+fromPicker.frame.height+self.frame.height/30, width: self.frame.width/2-(self.frame.width/20), height: self.frame.height/30))
        classLabel.font = labelFont
        classLabel.text = "Class"
        containerView.addSubview(classLabel)
        
        toPicker = UIPickerView(frame: CGRect(x: fromPicker.frame.origin.x+fromPicker.frame.width+(self.frame.width/20)/2, y: fromPicker.frame.origin.y, width: fromPicker.frame.width, height: fromPicker.frame.height))
        toPicker.dataSource = self
        toPicker.delegate = self
        toPicker.tag = 2
        containerView.addSubview(toPicker)
        
        classSelector = UISegmentedControl(items: ["WWDC Attendee", "WWDC Scholarship"])
        classSelector.frame = CGRect(x: fromPicker.frame.origin.x, y: classLabel.frame.origin.y+classLabel.frame.height*1.5, width: classLabel.frame.width, height: self.frame.height/20)
        classSelector.addTarget(self, action: #selector(selectClass(_:)), for: .valueChanged)
        containerView.addSubview(classSelector)
        
        bookBtn = UIButton(frame: CGRect(x: classSelector.frame.origin.x, y: classSelector.frame.origin.y+classSelector.frame.height+(self.frame.width/20), width: classSelector.frame.width, height: self.frame.height/10))
        bookBtn.setTitle("Book", for: .normal)
        bookBtn.titleLabel?.font = UIFont(name: "Avenir-Medium", size: self.frame.height/20)
        bookBtn.layer.cornerRadius = bookBtn.frame.height/6
        bookBtn.clipsToBounds = true
        bookBtn.backgroundColor = UIColor(red: 251/255, green: 107/255, blue: 131/255, alpha: 1)
        bookBtn.addTarget(self, action: #selector(bookTicket(_:)), for: .touchUpInside)
        containerView.addSubview(bookBtn)
        
        instructionLabel = UILabel(frame: CGRect(x: classLabel.frame.origin.x, y: containerView.frame.height-bookBtn.frame.height*2, width: classLabel.frame.width, height: bookBtn.frame.height))
        instructionLabel.text = "Book me an Apple Air Flight from Bangalore, India to San Jose, USA."
        instructionLabel.font = UIFont(name: "Avenir-Light", size: self.frame.height/30)
        instructionLabel.numberOfLines = 0
        instructionLabel.lineBreakMode = .byWordWrapping
        instructionLabel.textAlignment = .center
        containerView.addSubview(instructionLabel)
        
        UIView.animate(withDuration: 5.0, animations: {() -> Void in
            self.dummyProgress.setProgress(1, animated: true)
        })
        UIView.animate(withDuration: 1.0, delay: 5.0, options: .curveEaseIn, animations: {
            self.dummyProgress.alpha = 0
            self.containerView.alpha = 1
        }, completion: nil)
        
        checklistTable = UITableView(frame: CGRect(x: self.frame.width/2, y: self.frame.height/2, width: self.frame.width/2, height: self.frame.height/2))
        checklistTable.register(TodoCell.self, forCellReuseIdentifier: "Cell")
        checklistTable.delegate = self
        checklistTable.dataSource = self
        checklistTable.backgroundColor = .clear
        checklistTable.tableFooterView = UIView()
        checklistTable.separatorStyle = .none
        
        addSubview(checklistTable)
        
        let path = Bundle.main.path(forResource: "video", ofType: ".m4v")
        planeVideo = AVPlayer(url: URL(fileURLWithPath: path!))
        NotificationCenter.default.addObserver(self, selector: #selector(self.playerDidFinishPlaying(sender:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: planeVideo.currentItem)

        planeVideoLayer = AVPlayerLayer(player: planeVideo)
        planeVideoLayer.frame = CGRect(x: self.frame.width/2, y: 0, width: self.frame.width/2, height: self.frame.height/2)
        planeVideoLayer.videoGravity = .resizeAspectFill
        planeVideoLayer.opacity = 0
        self.layer.addSublayer(planeVideoLayer)
        
        ticketsBookedLabel = UILabel(frame: CGRect(x: 0, y: dummyProgress.frame.origin.y, width: self.frame.width/2, height: self.frame.height-titleLabel.frame.origin.y-titleLabel.frame.height))
        ticketsBookedLabel.text = "Tickets Booked"
        ticketsBookedLabel.font = labelFont
        ticketsBookedLabel.textAlignment = .center
        ticketsBookedLabel.alpha = 0
        
        finishBtn = UIButton(frame: CGRect(x: self.frame.width/8, y: self.frame.height/2-self.frame.height/16, width: self.frame.width/4, height: self.frame.height/8))
        finishBtn.layer.cornerRadius = finishBtn.frame.height/5
        finishBtn.clipsToBounds = true
        finishBtn.backgroundColor = UIColor(red: 79/255, green: 206/255, blue: 178/255, alpha: 1)
        finishBtn.setTitle("Go", for: .normal)
        finishBtn.setTitleColor(.white, for: .normal)
        finishBtn.addTarget(self, action: #selector(endPlayground(_ :)), for: .touchUpInside)
        finishBtn.titleLabel?.font = labelFont
        finishBtn.alpha = 0
        
    }
    
    @objc public func playerDidFinishPlaying(sender: Notification) {
        self.addSubview(finishBtn)
        UIView.animate(withDuration: 0.5, animations: {
            self.finishBtn.alpha = 1
            self.ticketsBookedLabel.alpha = 0
        })
    }
    
    @objc public func endPlayground(_ sender:UIButton){
        endScreen = EndScreen()
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromTop, .showHideTransitionViews]
        UIView.transition(with: self.superview!, duration: 1.0, options: transitionOptions, animations: {
            self.isHidden = true
            self.superview?.addSubview(self.endScreen)
            self.endScreen.isHidden = false
        })
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        let tag = pickerView.tag
        if tag == 1 {
            return from.count
        }else {
            return to.count
        }
    }
    
    public func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = (view as? UILabel) ?? UILabel()
        
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Light", size: self.frame.height/30)
        
        if pickerView.tag == 1 {
            label.text = from[row]
        }else {
            label.text = to[row]
        }
        
        return label
    }
    
    public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let tag = pickerView.tag
        let label:UILabel!
        if tag == 1 {
            label = pickerView.view(forRow: row, forComponent: component) as! UILabel
            fromValue = label.text!
        }else {
            label = pickerView.view(forRow: row, forComponent: component) as! UILabel
            toValue = label.text!
        }
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/3
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath) as! TodoCell
        cell.gradientColors = [firstColors[indexPath.row], secondColors[indexPath.row]]
        
        if indexPath.row == 0{
            if MyVariables.codeCompleted == true{
                cell.checked = true
            }else{
                cell.checked = false
            }
        }else if indexPath.row == 1{
            if MyVariables.iphoneUpdated == true{
                cell.checked = true
            }else{
                cell.checked = false
            }
        } else{
            if MyVariables.ticketsBooked == true{
                cell.checked = true
            }else{
                cell.checked = false
            }
        }
        cell.textLabel?.text = todoItems[indexPath.row]
        return cell
    }
    
    @objc public func selectClass(_ sender: Any){
        switch classSelector.selectedSegmentIndex
        {
        case 0:
            classValue = classSelector.titleForSegment(at: 0)!
        case 1:
            classValue = classSelector.titleForSegment(at: 1)!
        default:
            break
        }
    }
    
    @objc public func bookTicket(_ sender: Any){
        if self.fromValue == "Bangalore" && self.toValue == "San Jose" && self.classValue == "WWDC Scholarship"{
            UIView.animate(withDuration: 0.1, animations: {
                self.bookBtn.alpha = 0.5
                self.closeBtn.alpha = 0
            }, completion: {finished in
                self.performButtonAppearanceResetAnimation()
                self.ticketsBooked()
                self.closeBtn.isHidden = true
            })
            MyVariables.ticketsBooked = true
        }else{
            self.bookBtn.vibrate()
        }
    }
    
    func ticketsBooked(){
        let cell = checklistTable.cellForRow(at: IndexPath(row: 2, section: 0)) as! TodoCell
        UIView.animate(withDuration: 0.5, animations: {
            self.containerView.alpha = 0
            cell.checked = true
        }, completion: {(Bool) -> Void in
            self.containerView.removeFromSuperview()
            self.addSubview(self.ticketsBookedLabel)
            UIView.animate(withDuration: 0.5, animations:{
                self.ticketsBookedLabel.alpha = 1
                self.planeVideoLayer.opacity = 1
                self.checklistTable.selectRow(at: IndexPath(row: 3, section: 1), animated: true, scrollPosition: .none)
            }, completion: {(Bool) -> Void in
                self.planeVideo.play()
            })
        })
    }
    
    func performButtonAppearanceResetAnimation() {
        UIView.animate(withDuration: 0.1, animations: {
            self.bookBtn.alpha = 1
        })
    }
    
    @objc public func backToMainScreen(_ sender: UIButton){
        mainScreen = MainScreen()
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        
        UIView.transition(with: self.superview!, duration: 1.0, options: transitionOptions, animations: {
            self.isHidden = true
            self.superview?.addSubview(self.mainScreen)
            self.mainScreen.isHidden = false
        })
    }
    
}

class TodoCell: UITableViewCell {
    
    var toDoText:String = ""
    var toDoLabel:UILabel!
    
    var gradientColors:[CGColor] = []
    
    var checked:Bool! {
        didSet{
            if self.checked == true {
                self.imageView?.image = UIImage(named: "checkbox-selected.png")
            }else{
                self.imageView?.image = UIImage(named: "checkbox-unselected.png")
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        self.contentView.backgroundColor = .clear
        self.textLabel?.font = UIFont(name: "Avenir-Medium", size: self.frame.height/4)
        self.textLabel?.textColor = .white
        self.selectionStyle = .none
        createGreadient()
    }
    
    func createGreadient()
    {
        let gradientLayer = CAGradientLayer.init()
        gradientLayer.frame = self.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.colors = gradientColors
        
        self.contentView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

