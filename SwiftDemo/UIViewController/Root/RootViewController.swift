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
}

class RootViewController: UIViewController {
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    @IBOutlet fileprivate weak var searchBar: UISearchBar!
    let segmentControl = UISegmentedControl(items: [MediaType.movie.title(),
                                                    MediaType.tv.title(),
                                                    MediaType.music.title(),
                                                    MediaType.ebook.title()])
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.titleView = segmentControl
        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self,
                                 action: #selector(didSelectSegment),
                                 for: .valueChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func didSelectSegment() {
        dLog()
    }
}

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

