//
//  ElectricityBillViewController.swift
//  ElectricityBIllCalculation
//
//  Created by MacStudent on 2018-08-10.
//  Copyright © 2018 MacStudent. All rights reserved.
//

import UIKit

class ElectricityBillViewController: UIViewController,PassDataProtocol,UITextFieldDelegate  {
     var electricityBill: ElectricityBill?
     var datePicker : UIDatePicker!

    @IBOutlet weak var txtCustomerId: UITextField!
    @IBOutlet weak var txtCustomerName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtDate: UITextField!
    @IBOutlet weak var txtUnits: UITextField!
    @IBOutlet weak var lblTotalBillAmount: UILabel!
    
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
self.navigationItem.title = "Calculate Electricity Bill"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    
    @IBAction func btCalc(_ sender: UIButton) {
        electricityBill = ElectricityBill(customerId:Int(txtCustomerId.text!), customerName: String(txtCustomerId.text!), gender: Gender.MALE, billDate: Date(), unitConsumed: Int(txtUnits.text!), totalBillAmount: 0)
        performSegue(withIdentifier: "seguetodetails", sender: self)
    }
    
   
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        if let destVC = segue.destination as? BillDetailViewController
        {
            destVC.electricityBill = electricityBill
            destVC.delegate = self as? PassDataProtocol
        }
    }
        func setTotal(totalBill: Double)
        {
        print("A = \(totalBill)")
            self.electricityBill?.totalBillAmount = totalBill
        lblTotalBillAmount.isHidden = false
        lblTotalBillAmount.text = "TotalBill : $\(totalBill)"
        
        // Pass the selected object to the new view controller.
    }
    func textFieldEditing(_ textField : UITextField)
    {
        self.pickingDate(self.txtDate)
    }
    func pickingDate(_ textField : UITextField)
    {
        self.datePicker = UIDatePicker(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        self.datePicker.backgroundColor = UIColor.white
        self.datePicker.datePickerMode = UIDatePickerMode.date
        textField.inputView = self.datePicker
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(ElectricityBillViewController.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(ElectricityBillViewController.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    @objc func doneClick() {
        let dateFormatter1 = DateFormatter()
        dateFormatter1.dateStyle = .medium
        dateFormatter1.timeStyle = .none
        txtDate.text = dateFormatter1.string(from: datePicker.date)
        txtDate.resignFirstResponder()
    }
    
    @objc func cancelClick() {
        txtDate.resignFirstResponder()
    }
}
