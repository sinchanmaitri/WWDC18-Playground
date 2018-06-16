/*:
# WWDC Scholarship Process - Fun, amusing and intuitive

 In this playground, you will experience the process of a **WWDC Scholarship** submission in a more fun and intuitive manner.

 You'll have three tasks :
 * Help me by completing lines or pieces of code of a playground by answering multiple choice questions.
 * Update my iPhone to the latest **iOS 11.3** by collecting falling updates and avoiding malwares and viruses.
 * Book ** Air** Flight tickets to San Jose through **WWDC Scholarship** class.
 
 ### Note
 All the views are contained in the main view, **containerView**. The whole process starts by booting the playground up.
 
 
 Let's get started then.
 
 ## Click and hold on the grey circle until it boots into the next view.
 */


import UIKit
import PlaygroundSupport
import AVFoundation
import SpriteKit

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 700, height: 500))
let mainView = BootView()
containerView.addSubview(mainView)

PlaygroundPage.current.liveView = containerView
//PlaygroundPage.current.needsIndefiniteExecution = true


/*:
 * "Apple", "Xcode", "iOS", "iPhone" and "WWDC" are trademarks of Apple Inc, Cupertino, California, US. The Swift logo, the Xcode logo and the Apple logo() are under the copyrights of Apple
 * The click sound "click.wav", originally known as "Teleport-Casual" is licensed under the Creative Commons 0 License, obtained from http://freesound.org
 
 */
