//
//  Section.swift
//  WebConsuming
//
//  Created by Rodrigo Yukio Okido on 02/07/21.
//

import UIKit


/**
 Custom section header titles for the TableView.
 */
class CustomSectionHeader: UITableViewHeaderFooterView {

    let title = UILabel()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure () {
               title.translatesAutoresizingMaskIntoConstraints = false

               contentView.addSubview(title)

               
               NSLayoutConstraint.activate([
                   title.heightAnchor.constraint(equalToConstant: 40),
                   title.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
                   title.trailingAnchor.constraint(equalTo:
                          contentView.layoutMarginsGuide.trailingAnchor),
                   title.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor, constant: 0),
                   title.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: 6),
                   title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
               ])
    }

}
