//
//  Pie.swift
//  Memorize
//
//  Created by キラ on 2021/02/07.
//  Copyright © 2021 Kira. All rights reserved.
//

import SwiftUI

struct Pie: Shape{
    var startAngle: Angle
    var endAngle: Angle
    var clockwise: Bool = false
    
    var animatableData: AnimatablePair<Double,Double>{
        get {
            AnimatablePair(startAngle.radians, endAngle.radians)
        }
        set {
            startAngle = Angle.radians(newValue.first)
            endAngle = Angle.radians(newValue.second)
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        let start = CGPoint(x: rect.midX,
                            y: center.y + radius * sin(CGFloat(startAngle.radians)
            )
        )
        
        var p = Path()
        p.move(to: center)
        p.addLine(to: start)
        p.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        p.addLine(to: center)
        return p
    }
}
