//
//  TrafficLightViewController.swift
//  kbc-traffic
//
//  Created by Dimitar Marinov on 8.08.24.
//

import UIKit

enum TrafficLightItemType: Int {
    case red = 0
    case yellow
    case green
}

protocol TrafficLightItemProtocol {
    func turnOn()
    func turnOff()
}

class TrafficLightViewController: UIViewController {

    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var modelName: UILabel!
    
    private var lights: [TrafficLightItemView] = [
        TrafficLightItemView(type: .red),
        TrafficLightItemView(type: .yellow),
        TrafficLightItemView(type: .green)
    ]
    private var isThreadRunning = true
    private var workItem: DispatchWorkItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        func arrangedSubview(for type: TrafficLightItemType) -> TrafficLightItemView {
            return self.stackView.arrangedSubviews[type.rawValue] as! TrafficLightItemView
        }
        
        modelName.text = SharedData.shared.modelName
        
        lights.forEach({
            stackView.addArrangedSubview($0)
        })
        
        let red = arrangedSubview(for: .red)
        let yellow = arrangedSubview(for: .yellow)
        let green = arrangedSubview(for: .green)
        
        let commands: [Command] = [
            .init(turnOn: [red], turnOff: [yellow], wait: 4),
            .init(turnOn: [yellow], turnOff: [], wait: 1),
            .init(turnOn: [green], turnOff: [red, yellow], wait: 4),
            .init(turnOn: [yellow], turnOff: [green], wait: 1),
        ]
        workItem = DispatchWorkItem { [unowned self] in
            guard let workItem = self.workItem  else { return }
            
            while(!workItem.isCancelled) {
                for command in commands {
                    DispatchQueue.main.sync {
                        command.turnOn.forEach({$0.turnOn()})
                        command.turnOff.forEach({$0.turnOff()})
                    }
                    sleep(command.wait)
                }
            }
        }
        
        DispatchQueue.global().async(execute: workItem!)
    }

    override func viewWillDisappear(_ animated: Bool) {
        workItem?.cancel()
        workItem = nil
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
