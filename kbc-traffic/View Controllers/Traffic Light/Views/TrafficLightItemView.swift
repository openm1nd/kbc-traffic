//
//  TrafficLightItemView.swift
//  kbc-traffic
//
//  Created by Dimitar Marinov on 8.08.24.
//

import UIKit

class TrafficLightItemView: UIView, TrafficLightItemProtocol {
    
    convenience init(type: TrafficLightItemType) {
        self.init(frame: .init(x: 0, y: 0, width: 100, height: 100))
        
        switch(type) { // could be all separated into different classes, as 'RedTrafficLight' and set the values in the init of each one, trying to not over-enginner it though
        case .red:
            backgroundColor = .systemRed
        case .yellow:
            backgroundColor = .systemYellow
        case .green:
            backgroundColor = .systemGreen
        }
        
        layer.cornerRadius = frame.size.width/2
        layer.masksToBounds = true
        accessibilityLabel = "light-" + String(type.rawValue)
        
        turnOff()
    }
    
    func turnOn() {
        UIView.animate(withDuration: 0.15) { [weak self] in
            self?.alpha = 1
        }
        accessibilityValue = "1"
    }
    
    func turnOff() {
        UIView.animate(withDuration: 0.15) { [ weak self] in
            self?.alpha = 0.3
        }
        accessibilityValue = "0"
    }
}
