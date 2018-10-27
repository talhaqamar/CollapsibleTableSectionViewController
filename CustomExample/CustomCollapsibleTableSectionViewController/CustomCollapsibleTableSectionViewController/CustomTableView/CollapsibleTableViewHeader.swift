//
//  CollapsibleTableViewHeaderDelegate.swift
//
//  Created by Talha Qamar on 27/10/18.
//  Copyright © 2018 devtalha.com. All rights reserved.
//
import Foundation

import UIKit

protocol CollapsibleTableViewHeaderDelegate
{
    func toggleSection(_ header: CollapsibleTableViewHeader, section: Int)
      func testHeader(count:Int)
}

class CollapsibleTableViewHeader: UITableViewHeaderFooterView
{
    var delegate: CollapsibleTableViewHeaderDelegate?
    var section: Int = 0
    let titleLabel = UILabel()
    let hoursLabel = UILabel()
    var arrowLabel = UIImageView(image: #imageLiteral(resourceName: "plus")); //UILabel()
    var min = UIImage(named: "minus.png") ;
    var max = UIImage(named: "plus.png") ;
     var checkHeader = -5
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        // Content View
        contentView.backgroundColor = UIColor(hex: 0xef9f04)
        
        let marginGuide = contentView.layoutMarginsGuide
        
        contentView.addSubview(arrowLabel)
        //  arrowLabel.textColor = UIColor.white
        arrowLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowLabel.widthAnchor.constraint(equalToConstant: 30).isActive = true
        arrowLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        arrowLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        arrowLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        arrowLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
       
        contentView.addSubview(titleLabel)
        titleLabel.textColor = UIColor.white
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16.0)
       
        contentView.addSubview(hoursLabel)
        hoursLabel.textColor = UIColor.white
        hoursLabel.translatesAutoresizingMaskIntoConstraints = false
        hoursLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        hoursLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        hoursLabel.trailingAnchor.constraint(equalTo: arrowLabel.leadingAnchor).isActive = true
        hoursLabel.textColor = UIColor.black
        hoursLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        hoursLabel.font = UIFont.boldSystemFont(ofSize: 12.0)
        
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(CollapsibleTableViewHeader.tapHeader(_:))))
    
    }
    
    func valuePassedHeader(val : Int)
    {
        checkHeader = val;
        
    }
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }

    func tapHeader(_ gestureRecognizer: UITapGestureRecognizer)
    {
        guard let cell = gestureRecognizer.view as? CollapsibleTableViewHeader else {
            return
        }
        delegate?.toggleSection(self, section: cell.section)
        delegate?.testHeader(count: cell.section)
        
        //    celldelegate?.applyButtonPressed()
        
    }
    
    
    func setCollapsed(_ collapsed: Bool)
    {
        //
        // Animate the arrow rotation (see Extensions.swf)
        //
        //arrowLabel.rotate(collapsed ? 0.0 : .pi / 2)
        // arrowLabel = UIImageView(image: #imageLiteral(resourceName: "minus"))
    }
    
}
