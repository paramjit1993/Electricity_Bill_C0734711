//
//  BillDetailViewController.swift
//  ElectricityBIllCalculation
//
//  Created by MacStudent on 2018-08-10.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit
protocol PassDataProtocol {
  func setTotal(totalBill: Double)
}

class BillDetailViewController: UIViewController {
    @IBOutlet weak var lblBillAmt: UILabel!
    @IBOutlet weak var txtBillAmt: UITextField!
    
    var electricityBill: ElectricityBill?
    var delegate: PassDataProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Bill Details"
        if let bill = electricityBill
        {
            print(bill.customerId!)
            print(bill.customerName!)
            CalcTotalBillAmount()
        }

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func CalcTotalBillAmount()
    {
        var totalBill = 0.0
        if (electricityBill?.unitConsumed)!<=100
        {
            totalBill = Double((electricityBill?.unitConsumed)!) * 0.75
        }
        else if(electricityBill?.unitConsumed)!<=250
        {totalBill = 75 + (Double((electricityBill?.unitConsumed)!)-100) * 1.25
        }
        else if(electricityBill?.unitConsumed)!<=450
        {totalBill = 262.5 + Double((electricityBill?.unitConsumed)!) * 2.25
        }
        
   delegate?.setTotal(totalBill: totalBill)
   print("B = \(totalBill)")
   txtBillAmt.text = String("TotalBill : $\(totalBill)")
        
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
