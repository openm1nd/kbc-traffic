//
//  Command.swift
//  kbc-traffic
//
//  Created by Dimitar Marinov on 8.08.24.
//

import Foundation

struct Command {
    let turnOn: [TrafficLightItemView]
    let turnOff: [TrafficLightItemView]
    let wait: UInt32
}
