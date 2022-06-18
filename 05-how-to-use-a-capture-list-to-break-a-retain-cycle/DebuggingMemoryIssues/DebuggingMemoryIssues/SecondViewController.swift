//
//  SecondViewController.swift
//  DebuggingMemoryIssues
//
//  Created by John Salvador on 6/18/22.
//

import UIKit

class SecondViewController: UIViewController {

    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set Title
        title = "Second"
        
        // Observe Notification: Application Did Become Active Notification
//        NotificationCenter.default.addObserver(forName: UIApplication.didBecomeActiveNotification, object: nil, queue: .main) { [weak self] _ in
//            self?.updateView()
//        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.updateView()
        }
    }
    
    // MARK: - View Methods
    
    private func updateView() { }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
