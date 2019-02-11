//
//  NewsCell.swift
//  NewsParser
//
//  Created by Ильяс Ихсанов on 09/02/2019.
//  Copyright © 2019 ilyas. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var decalarationLabel: UILabel!
    
    func setTitle(_ title: String) {
        titleLabel.text = title
    }
    
    func setDeclaration(_ text: String) {
        decalarationLabel.text = text
    }
}
