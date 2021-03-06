//
//  DebugWidget.swift
//  demo
//
//  Created by liman on 26/11/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class DebugWidgetViewController: UIViewController {

    var bubble = DebugWidgetBubble(frame: CGRect(origin: DebugWidgetBubble.originalPosition, size: DebugWidgetBubble.size))

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.addSubview(self.bubble)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        self.bubble.updateOrientation(newSize: size)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.bubble.delegate = self
        self.view.backgroundColor = .clear
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        WindowHelper.shared.displayedList = false
    }

    func shouldReceive(point: CGPoint) -> Bool {
        if WindowHelper.shared.displayedList {
            return true
        }
        return self.bubble.frame.contains(point)
    }
}

//MARK: - DebugWidgetBubbleDelegate
extension DebugWidgetViewController: DebugWidgetBubbleDelegate {
    
    func didTapDebugWidgetBubble() {
        WindowHelper.shared.displayedList = true
        let storyboard = UIStoryboard(name: "Manager", bundle: Bundle(for: DebugWidgetViewController.self))
        guard let vc = storyboard.instantiateInitialViewController() else {return}
        self.present(vc, animated: true, completion: nil)
    }
}
