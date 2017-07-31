//
//  RootViewController.swift
//  SwiftDemo
//
//  Created by Ryan Han on 7/24/17.
//  Copyright © 2017 Surfline. All rights reserved.
//

import UIKit
import SnapKit

enum MediaType {
    case movie
    case tv
    case music
    case ebook
    
    func title() -> String {
        switch self {
        case .movie: return "Movie"
        case .tv: return "TV Show"
        case .music: return "Music"
        case .ebook: return "eBook"
        }
    }
    
    //MARK:- segments
    static var segments: [MediaType] { return [.movie, .tv, .music, .ebook] }
    
    init(rawValue: Int) {
        if rawValue < MediaType.segments.count {
            self = MediaType.segments[rawValue]
        } else {
            self = .movie
        }
    }
}

class RootViewController: UIViewController {
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    let segmentControl = UISegmentedControl(items: MediaType.segments.map({ return $0.title() }))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = segmentControl
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self,
                                 action: #selector(didSelectSegment),
                                 for: .valueChanged)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    func didSelectSegment() {
        let selected = MediaType(rawValue: segmentControl.selectedSegmentIndex)
        dLog(selected.title())
    }
}

//MARK:- UITableViewDelegate, UITableViewDataSource
extension RootViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        dLog()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

//MARK:- UISearchBarDelegate
extension RootViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        // return NO to not become first responder
        return true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // called when text starts editing
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        // return NO to not resign first responder
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        // called when text ends editing
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // called when text changes (including clear)
    }
    
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        // called before text changes
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // called when keyboard search button pressed
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        // called when bookmark button pressed
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // called when cancel button pressed
    }
    
    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {
        // called when search results button pressed
    }

}

