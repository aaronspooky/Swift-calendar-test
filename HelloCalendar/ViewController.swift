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
  @IBOutlet weak var calendarView: JTAppleCalendarView!
  
  // COLORS
  let outsideMonthColor = UIColor(colorWithHexValue: 0x584a66)
  let monthColor = UIColor.white
  let selectedMonthColor = UIColor(colorWithHexValue: 0x3a294b)
  let currentDateSelectedViewColor = UIColor(colorWithHexValue: 0x4e3f5d)
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupCalendarView()
  }
  
  func setupCalendarView() {
    calendarView.minimumLineSpacing = 0
    calendarView.minimumInteritemSpacing = 0
  }
  
  func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
    guard let validCell = view as? CustomCell else { return }
    
    if cellState.isSelected {
      validCell.dateLabel.textColor = selectedMonthColor
    } else {
      if cellState.dateBelongsTo == .thisMonth {
        validCell.dateLabel.textColor = monthColor
      } else {
        validCell.dateLabel.textColor = outsideMonthColor
      }
    }
  }
  
  func handleCellSelected(view: JTAppleCell?, cellState: CellState) {
    guard let validCell = view as? CustomCell else { return }
    
    if cellState.isSelected {
      validCell.selectedView.isHidden = false
    } else {
      validCell.selectedView.isHidden = true
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

// MARK: DATASOURCE
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

// MARK: DELEGATE
extension ViewController: JTAppleCalendarViewDelegate {
  func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
    let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
    cell.dateLabel.text = cellState.text
    handleCellSelected(view: cell, cellState: cellState)
    handleCellTextColor(view: cell, cellState: cellState)
    
    return cell
  }
  
  func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
    guard let validCell = cell as? CustomCell else { return }
    handleCellSelected(view: cell, cellState: cellState)
    handleCellTextColor(view: cell, cellState: cellState)
    validCell.selectedView.isHidden = false
  }
  
  func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
    guard let validCell = cell as? CustomCell else { return }
    handleCellSelected(view: cell, cellState: cellState)
    handleCellTextColor(view: cell, cellState: cellState)
    validCell.selectedView.isHidden = true
  }
}

extension UIColor {
  convenience init(colorWithHexValue value: Int, alpha: CGFloat = 1.0) {
    self.init(
      red: CGFloat((value & 0xFF0000) >> 16 ) / 255.0,
      green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
      blue: CGFloat(value & 0x0000FF) / 255.0,
      alpha: alpha
    )
  }
}
