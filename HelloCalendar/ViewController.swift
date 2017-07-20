//
//  ViewController.swift
//  HelloCalendar
//
//  Created by Sergio A. Balderas on 19/07/17.
//  Copyright © 2017 Sergio A. Balderas. All rights reserved.
//

import UIKit
import JTAppleCalendar

class ViewController: UIViewController {
  let formatter = DateFormatter()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

extension ViewController: JTAppleCalendarViewDataSource {
  func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
    formatter.dateFormat = "yyyy MM dd"
    formatter.timeZone = Calendar.current.timeZone
    formatter.locale = Calendar.current.locale
    
    let startDate = formatter.date(from: "2017 01 01")!
    let endDate = formatter.date(from: "2018 01 01")!
    
    let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
    return parameters
  }
}

extension ViewController: JTAppleCalendarViewDelegate {
  func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
    let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
    cell.dateLabel.text = cellState.text
    return cell
  }
  
  func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
    guard let validCell = cell as? CustomCell else { return }
    validCell.selectedView.isHidden = false
    print("Delegate")
  }
}
