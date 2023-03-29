//
//  ViewController.swift
//  project27
//
//  Created by Tamim Khan on 29/3/23.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    var currentdrawType = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawRectangle()
    }

    @IBAction func redrawTapped(_ sender: Any) {
        currentdrawType += 1
        
        if currentdrawType > 6{
            currentdrawType = 0
        }
        switch currentdrawType{
        case 0:
            drawRectangle()
        case 1:
            drawCircle()
        case 2:
            drawCheckerboard()
        case 3:
            drawRotatedSquars()
        case 4:
            drawLines()
        case 5:
            drawImagesAndText()
        case 6:
            drawStar()
    
            
            
        default:
            break
        }
        
    }
    func drawRectangle(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            
            ctx.cgContext.addRect(rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
            
        }
        imageView.image = img
        
    }
    func drawCircle(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        
        let img = renderer.image { ctx in
            let rectangle = CGRect(x: 0, y: 0, width: 512, height: 512).insetBy(dx: 5, dy: 5)
            
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(10)
            
            
            ctx.cgContext.addEllipse(in: rectangle)
            ctx.cgContext.drawPath(using: .fillStroke)
            
        }
        imageView.image = img
    }
    func  drawCheckerboard(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        
        let img = renderer.image { ctx in
            ctx.cgContext.setFillColor(UIColor.black.cgColor)
            
            for row in 0..<8{
                for col in 0..<8{
                    if (row + col).isMultiple(of: 2){
                        ctx.cgContext.fill(CGRect(x: col * 64, y: row * 64, width: 64, height: 64))
                    }
                    
                }
            }
            
           
            
        }
        imageView.image = img
    }
    
    func  drawRotatedSquars(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        
        let img = renderer.image { ctx in
            
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let rotaion = 16
            let amount = Double.pi / Double(rotaion)
            
            for _ in 0..<rotaion{
                ctx.cgContext.rotate(by: CGFloat(amount))
                ctx.cgContext.addRect(CGRect(x: -128, y: -128, width: 256, height: 256))
                
                
                
            }
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
           
            
        }
        imageView.image = img
    }
    
    
    func  drawLines(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        
        let img = renderer.image { ctx in
            
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            var first = true
            var length: CGFloat = 256
            
            
            for _ in 0..<256{
                ctx.cgContext.rotate(by: .pi / 2)
                
                if first{
                    ctx.cgContext.move(to: CGPoint(x: length, y: 50))
                    first = false
                }else{
                    ctx.cgContext.addLine(to: CGPoint(x: length, y: 50))
                }
                length *= 0.99
            }
            
            
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.strokePath()
           
            
        }
        imageView.image = img
    }
    func  drawImagesAndText(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        
        let img = renderer.image { ctx in
            
           let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 36),
                .paragraphStyle: paragraphStyle
            ]
           
            
            let string = "who will rang the cat\n-the old mice"
            let attributeString = NSAttributedString(string: string, attributes: attrs)
            
            
            attributeString.draw(with: CGRect(x: 32, y: 32, width: 448, height: 448), options: .usesLineFragmentOrigin, context: nil)
            
            let mouse = UIImage(named: "mouse")
            mouse?.draw(at: CGPoint(x: 300, y: 150))
            
            
            
           
            
        }
        imageView.image = img
    }
   
    func drawStar() {
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 512, height: 512))
        
        let img = renderer.image { ctx in
            ctx.cgContext.translateBy(x: 256, y: 256)
            
            let starPath = UIBezierPath()
            
            let pointsOnStar = 5
            let starRadius: CGFloat = 100
            let angleIncrement = CGFloat.pi * 4 / CGFloat(pointsOnStar * 2)
            var angle: CGFloat = -.pi / 2
            
            let outerPoint = CGPoint(x: starRadius * cos(angle), y: starRadius * sin(angle))
            starPath.move(to: outerPoint)
            
            for _ in 0..<pointsOnStar {
                angle += angleIncrement
                
                let innerPoint = CGPoint(x: starRadius / 2 * cos(angle), y: starRadius / 2 * sin(angle))
                starPath.addLine(to: innerPoint)
                
                angle += angleIncrement
                
                let outerPoint = CGPoint(x: starRadius * cos(angle), y: starRadius * sin(angle))
                starPath.addLine(to: outerPoint)
            }
            
            starPath.close()
            ctx.cgContext.setFillColor(UIColor.yellow.cgColor)
            ctx.cgContext.setStrokeColor(UIColor.black.cgColor)
            ctx.cgContext.setLineWidth(5)
            ctx.cgContext.addPath(starPath.cgPath)
            ctx.cgContext.drawPath(using: .fillStroke)
        }
        
        imageView.image = img
    }

    
    
}

