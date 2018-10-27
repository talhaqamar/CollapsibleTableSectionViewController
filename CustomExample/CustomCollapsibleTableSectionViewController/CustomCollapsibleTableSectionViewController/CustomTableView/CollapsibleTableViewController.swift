//
//  CollapsibleTableViewController.swift
//
//  Created by Talha Qamar on 27/10/18.
//  Copyright © 2018 devtalha.com. All rights reserved.
//

import UIKit





class CollapsibleTableViewController: UITableViewController
{
    var myAlertViewController:AlertViewController?
    
    var sections = sectionsPassed//sectionsData
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Auto resizing the height of the cell
        tableView.estimatedRowHeight = 60.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor.clear
        
        //  print("xnxx \(sections)")
        //    tableView.tableHeaderView?.backgroundColor = UIColor.clear
        //   self.title = "Apple Products"
    }
    
}

//
// MARK: - View Controller DataSource and Delegate
//

extension CollapsibleTableViewController {


    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].collapsed ? 0 : sections[section].items.count
    }


    // Cell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CollapsibleTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CollapsibleTableViewCell ??
            CollapsibleTableViewCell(style: .default, reuseIdentifier: "cell")
        
        let item: Item = sections[indexPath.section].items[indexPath.row]
        // sections[indexPath.row].items.remove(at: indexPath.row)
        cell.nameLabel.text = item.name
        cell.delegate = self
        cell.tag = indexPath.row
        cell.valuePassed(val: indexPath.row)
        
        // cell.detailLabel.text = item.detail
        // cell.layer.backgroundColor =  //clear.cgColor
        
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
   
    
    // Header
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "header") as? CollapsibleTableViewHeader ?? CollapsibleTableViewHeader(reuseIdentifier: "header")
        
        let apply = self.parent as! LeavesViewController
        
        if (!apply.isApplyView)
        {
            
            header.titleLabel.text = sections[section].name
            header.hoursLabel.text = sections[section].count //"[0.0 hrs]"
            header.arrowLabel.isHidden = true
            
         // header.arrowLabel.removeFromSuperview()
         //   header.hoursLabel.removeConstraints(header.hoursLabel.constraints)
         //   header.hoursLabel.frame.origin = CGPoint(x: header.arrowLabel.frame.height, y: header.arrowLabel.frame.width)//CGRect(x: header.arrowLabel.frame.width, y: header.arrowLabel.frame.height, width: <#T##CGFloat#>, height: <#T##CGFloat#>)
            
         //  header.hoursLabel.textAlignment = .right
         //  header.arrowLabel.text = ">"
         //  header.setCollapsed(!sections[section].collapsed)
             header.section = section
         //  header.delegate = self
        }
        else
        {
            if(sections[section].status == true)
            {
                header.arrowLabel.image = #imageLiteral(resourceName: "plus")
            }
            
            if(sections[section].status == false)
            {
                header.arrowLabel.image = #imageLiteral(resourceName: "minus")
                
            }
            
            header.titleLabel.text = sections[section].name
            header.hoursLabel.text = sections[section].count //"[0.0 hrs]"
            // header.arrowLabel.text = ">"
            header.setCollapsed(!sections[section].collapsed)
            header.valuePassedHeader(val: section)
            header.tag = section
            header.section = section
            header.delegate = self
           
            
        }
       
        return header
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50.0
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }

}

//
// MARK: - Section Header Delegate
//

extension CollapsibleTableViewController: CollapsibleTableViewCellDelegate
{
    func test(count : Int)
    {
        
        
      //  globalCheckForHeader = header.tag
        
        print("header \(globalCheckForHeader)")
        print("count \(count)")
        print("\(sectionsPassed[globalCheckForHeader].items[count])")
        
        let leaveQuantity: Double = ((sectionsPassed[globalCheckForHeader].items[count].detail as NSString).doubleValue)
        let lType: String = sectionsPassed[globalCheckForHeader].items[count].name
        
        print("\(leaveQuantity)")
        print("\(lType)")

        
        
        if(leaveQuantity > 0)
        {
            var dataArray = NSMutableArray()
            let dict = NSMutableDictionary()
            dict.setValue("\(sectionsPassed[globalCheckForHeader].items[count].id)", forKey: "leaveTypeID")
            dict.setValue("\(sectionsPassed[globalCheckForHeader].items[count].name)", forKey: "leaveType")
            dict.setValue("\(sectionsPassed[globalCheckForHeader].items[count].detail)", forKey: "leaveHours")
            dict.setValue("\(sectionsPassed[globalCheckForHeader].items[count].detail)", forKey: "leaveHoursQuantity")
            dataArray.add(dict)
            
            let dictt = dataArray.object(at: 0) as! NSDictionary
            
            let leavesView = self.storyboard!.instantiateViewController(withIdentifier: "ApplyLeavesViewController") as! ApplyLeavesViewController
            leavesView.leaveData = dictt
            leavesView.leaveId = "LeaveId" //dataDict.objectForKey("leaveId")
            leavesView.leaveTypeId = "LeaveTypeId"//dataDict.objectForKey("leaveTypeId")
            self.navigationController?.pushViewController(leavesView, animated: true)
        }
        else
       // else if (lType.contains("Compasionate") || lType.contains("Leave Without Pay") || lType.contains("Sick Leave - Unpaid") || lType.contains("Jury") || lType.contains("Maternity"))
        {
            let pos = UserDefaults.standard.string(forKey: "EmployeePositionKey")
          
            let checkForZero = realmLeave.objects(LeaveModal.self).filter("leaveTypeName == %@ AND leaveEmployeePayRateID == %@"
                , "\(sectionsPassed[globalCheckForHeader].items[count].name)", "\(pos!)")
            
            
            if(checkForZero.count > 0)
            {
               
                    var value = checkForZero.first?.leaveAccruel!
              
                    var decimal = Double(round(1000 * Double(value!)!)/1000)
                   
                    var dataArray = NSMutableArray()
                    let dict = NSMutableDictionary()
                    dict.setValue("\(sectionsPassed[globalCheckForHeader].items[count].id)", forKey: "leaveTypeID")
                    dict.setValue("\(sectionsPassed[globalCheckForHeader].items[count].name)", forKey: "leaveType")
                    dict.setValue("\(decimal)", forKey: "leaveHours")
                    dict.setValue("\(decimal)", forKey: "leaveHoursQuantity")
                    dataArray.add(dict)
                
                
                    let dictt = dataArray.object(at: 0) as! NSDictionary
                    let leavesView = self.storyboard!.instantiateViewController(withIdentifier: "ApplyLeavesViewController") as! ApplyLeavesViewController
                    leavesView.leaveData = dictt
                    leavesView.leaveId = "LeaveId" //dataDict.objectForKey("leaveId")
                    leavesView.leaveTypeId = "LeaveTypeId"//dataDict.objectForKey("leaveTypeId")
                    self.navigationController?.pushViewController(leavesView, animated: true)
           
                
            }
            else
            {
                
                var dataArray = NSMutableArray()
                let dict = NSMutableDictionary()
                dict.setValue("\(sectionsPassed[globalCheckForHeader].items[count].id)", forKey: "leaveTypeID")
                dict.setValue("\(sectionsPassed[globalCheckForHeader].items[count].name)", forKey: "leaveType")
                dict.setValue("\(sectionsPassed[globalCheckForHeader].items[count].detail)", forKey: "leaveHours")
                dict.setValue("\(sectionsPassed[globalCheckForHeader].items[count].detail)", forKey: "leaveHoursQuantity")
                dataArray.add(dict)
           
                
                let dictt = dataArray.object(at: 0) as! NSDictionary
                let leavesView = self.storyboard!.instantiateViewController(withIdentifier: "ApplyLeavesViewController") as! ApplyLeavesViewController
                leavesView.leaveData = dictt
                leavesView.leaveId = "LeaveId" //dataDict.objectForKey("leaveId")
                leavesView.leaveTypeId = "LeaveTypeId"//dataDict.objectForKey("leaveTypeId")
                self.navigationController?.pushViewController(leavesView, animated: true)
         
            }
            
}
    
        
        
      
    }
    
    
}

extension CollapsibleTableViewController: CollapsibleTableViewHeaderDelegate
{
    func testHeader(count : Int)
    {
          globalCheckForHeader = count
    }
    
    
     func toggleSection(_ header: CollapsibleTableViewHeader, section: Int)
     {
          headerCount.append(section)
        if(headerCount.first != section){
          
            if(headerCount.count > 1 && headerCount[0] != section)
            {
                let collapsed = !sections[headerCount[0]].collapsed
                sections[headerCount[0]].collapsed = collapsed
                sections[headerCount[0]].status = collapsed
                header.setCollapsed(collapsed)
                tableView.reloadSections(NSIndexSet(index: headerCount[0]) as IndexSet, with: .automatic)
                headerCount.removeFirst()
              
                print("remove \(section)")
                print(headerCount)
                print("XXXXXXX remove")
            }
        }
        else if(headerCount.first == section && headerCount.count > 1)
        {
            headerCount.removeFirst()
            headerCount.removeLast()
        }
       
       
        
         let collapsed = !sections[section].collapsed
       
        sections[section].collapsed = collapsed
        sections[section].status = collapsed
        header.setCollapsed(collapsed)
       
        tableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .automatic)
     
       
       
        
        /*
         
         for i in 0...headerCount.count-1
         {
             //  print(headerCount.count)
             //  print(headerCount[i])
            
              if(i != section)
              {
                let collapsed = sections[i].collapsed
                sections[i].collapsed = collapsed
                header.setCollapsed(collapsed)
                tableView.reloadSections(NSIndexSet(index: i) as IndexSet, with: .automatic)
    
            }
        }
    */
       
    }
    
}
