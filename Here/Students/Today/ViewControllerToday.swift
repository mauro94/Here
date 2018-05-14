//
//  ViewControllerToday.swift
//  Here
//
//  Created by Mauro Amarante Esparza on 4/11/18.
//  Copyright © 2018 Mauro Amarante Esparza. All rights reserved.
//

import UIKit

class ViewControllerToday: UIViewController, TodayDelegate {
    // MARK: - Outlets
    @IBOutlet weak var vAssignments: UIView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    // MARK: - Variables
    var pageViewController: PageViewControllerAssignments? {
        didSet {
            pageViewController?.todayDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Remove navbar shadow
        self.navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pageViewController = segue.destination as? PageViewControllerAssignments {
            pageViewController.todayDelegate = self
        }
    }

    
    // MARK: - Delegate
    func pageViewControllerAssignments(pageViewController: PageViewControllerAssignments, didUpdatePageCount count: Int) {
        pageControl.numberOfPages = count
    }
    
    func pageViewControllerAssignments(pageViewController: PageViewControllerAssignments, didUpdatePageIndex index: Int) {
        pageControl.currentPage = index
    }
}
