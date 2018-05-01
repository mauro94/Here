//
//  TableViewCellTodayClass.swift
//  Here
//
//  Created by Mauro on 4/20/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit

class TableViewCellTodayClass: UITableViewCell {
    // MARK: - Outlets
    @IBOutlet weak var lbTime: UILabel!
    @IBOutlet weak var lbClass: UILabel!
    @IBOutlet weak var vColor: UIView!
    @IBOutlet weak var lbClassRoom: UILabel!
    
    // MARK: - Variables
    var bFirst = false
    var bLast = false
    var bOne = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()!
        let darkColor = UIColor(red: 52/255, green: 58/255, blue: 64/255, alpha: 1)
        
        context.setLineWidth(2.0)
        context.setStrokeColor(darkColor.cgColor)
        context.setFillColor(darkColor.cgColor)
        
        if bOne {
            // ignore
        }
        else if bFirst {
            context.move(to: CGPoint(x: 10, y: 27))
            context.addLine(to: CGPoint(x: 10, y: self.frame.height))
        }
        else if bLast {
            context.move(to: CGPoint(x: 10, y: 0))
            context.addLine(to: CGPoint(x: 10, y: 27))
        }
        else {
            context.move(to: CGPoint(x: 10, y: 0))
            context.addLine(to: CGPoint(x: 10, y: self.frame.height))
        }
        
        context.strokePath()
        
        let circle = UIBezierPath(arcCenter: CGPoint(x: 10,y: 27.5), radius: CGFloat(5), startAngle: CGFloat(0), endAngle:CGFloat(Double.pi * 2), clockwise: true)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = circle.cgPath
        
        shapeLayer.fillColor = UIColor(red: 52/255, green: 58/255, blue: 64/255, alpha: 1.0).cgColor
        
        self.layer.addSublayer(shapeLayer)
    }
}
