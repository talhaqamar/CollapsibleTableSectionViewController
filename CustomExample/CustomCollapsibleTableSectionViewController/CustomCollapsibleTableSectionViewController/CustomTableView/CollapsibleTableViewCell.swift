//
//  CollapsibleTableViewCell.swift
//
//
//  Created by Talha Qamar on 27/10/18.
//  Copyright © 2018 devtalha.com. All rights reserved.
//

import Foundation
import UIKit


protocol CollapsibleTableViewCellDelegate
{
    func test(count:Int)
}

class CollapsibleTableViewCell: UITableViewCell {

    var delegate: CollapsibleTableViewCellDelegate?
    let nameLabel = UILabel()
    let detailLabel = UIButton()
    let imageview = #imageLiteral(resourceName: "home_green_button") ;//UIImage(image: #imageLiteral(resourceName: "home_orange_button")); //UILabel()
    var check = -5
    // MARK: Initalizers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        contentView.backgroundColor = UIColor(hex: 0xf7c562)
        let marginGuide = contentView.layoutMarginsGuide
        // configure nameLabel
        contentView.addSubview(nameLabel)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        nameLabel.numberOfLines = 0
        nameLabel.font = UIFont.systemFont(ofSize: 16)
        nameLabel.textColor = UIColor.white
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        nameLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        nameLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
      
        // configure detailLabel
        contentView.addSubview(detailLabel)
        detailLabel.translatesAutoresizingMaskIntoConstraints = false
        detailLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        detailLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        detailLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        detailLabel.widthAnchor.constraint(equalToConstant: 60).isActive = true
        detailLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        detailLabel.setTitle("APPLY", for: .normal)
        detailLabel.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14) //UIFont.systemFont(ofSize: 14.0)//boldSystemFont(ofSize: 16.0)
        detailLabel.setBackgroundImage(imageview, for: .normal)
        detailLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewCell.testing)))
        
      
    }
    func valuePassed(val : Int)
    {
        check = val;
        
    }
 
    var countX = 0;
    @objc func testing(_ gestureRecognizer: UITapGestureRecognizer)
    {
        countX = countX + 1;
        
        print("67 testing")
  
        delegate?.test(count: check)
        
        //    celldelegate?.applyButtonPressed()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    
}
