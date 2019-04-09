//
//  QuickPollViewController.swift
//  VendorManager
//
//  Created by NILESH_iOS on 09/04/19.
//  Copyright © 2019 iDev. All rights reserved.
//

import UIKit

class QuickPollViewController: UIViewController {
    
    

    let queTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .lightGray
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let scrollView: UIScrollView = {
        let scrView = UIScrollView()
        scrView.translatesAutoresizingMaskIntoConstraints = false
        scrView.backgroundColor = UIColor.white
        scrView.isScrollEnabled = true
        return scrView
    }()
    
    let optionTableView: UITableView = {
        let table = UITableView()
        table.isScrollEnabled = false
        table.allowsSelection = false
        table.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let addChoiceButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add", for: .normal)
        btn.setTitleColor(.black, for: .normal)
        btn.addTarget(self, action: #selector(addNewChoice), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let expiryDateLabel: UILabel = {
        let label = UILabel()
        label.text = "Poll expiry date"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let expiryDateButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("\(Date())", for: .normal)
        btn.setTitleColor(.blue, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        btn.addTarget(self, action: #selector(changeDate), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    let datePicker: UIDatePicker = {
        let dtPicker = UIDatePicker()
        dtPicker.timeZone = NSTimeZone.local
        dtPicker.backgroundColor = UIColor.lightGray
        return dtPicker
    }()
    
    var dateChooserAlert = UIAlertController()
    
    var optionArray: [String] = ["Choice 1", "Choice 2"]
    var tableHeightConstraint: NSLayoutConstraint?
    var contentHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.contentSize = CGSize(width:self.view.frame.width, height: contentHeight)
    }
    
    func setupUI() {
        let btn1 = UIButton(type: .custom)
        btn1.setTitle("Cancel", for: .normal)
        btn1.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        btn1.addTarget(self, action: #selector(dismissView), for: .touchUpInside)
        let item1 = UIBarButtonItem(customView: btn1)
        self.navigationItem.setRightBarButtonItems([item1], animated: true)
        
        self.view.addSubview(scrollView)
        
        if #available(iOS 11.0, *) {
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        } else {
            scrollView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        }
        scrollView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        if #available(iOS 11.0, *) {
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        } else {
            scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        }
        
        contentHeight = scrollView.frame.height

        scrollView.addSubview(queTextView)
        queTextView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        queTextView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        queTextView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        queTextView.heightAnchor.constraint(equalToConstant: 70.0).isActive = true
        //Imp constraint
        queTextView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        scrollView.addSubview(optionTableView)
        optionTableView.delegate = self
        optionTableView.dataSource = self
        optionTableView.topAnchor.constraint(equalTo: queTextView.bottomAnchor, constant: 10).isActive = true
        optionTableView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 0).isActive = true
        optionTableView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: 0).isActive = true
        tableHeightConstraint = optionTableView.heightAnchor.constraint(equalToConstant: 70.0)
        tableHeightConstraint?.isActive = true
        
        scrollView.addSubview(addChoiceButton)
        addChoiceButton.topAnchor.constraint(equalTo: optionTableView.bottomAnchor, constant: 10).isActive = true
        addChoiceButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15).isActive = true
        addChoiceButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        addChoiceButton.widthAnchor.constraint(equalToConstant: 50.0).isActive = true
        
        scrollView.addSubview(expiryDateLabel)
        expiryDateLabel.topAnchor.constraint(equalTo: addChoiceButton.bottomAnchor, constant: 15).isActive = true
         expiryDateLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15).isActive = true
        expiryDateLabel.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        expiryDateLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.5).isActive = true
        
        scrollView.addSubview(expiryDateButton)
        expiryDateButton.topAnchor.constraint(equalTo: addChoiceButton.bottomAnchor, constant: 15).isActive = true
        expiryDateButton.leadingAnchor.constraint(equalTo: expiryDateLabel.trailingAnchor, constant: 10).isActive = true
        expiryDateButton.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
        expiryDateButton.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.5).isActive = true
    }
    
    @objc func dismissView() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func addNewChoice() {
        optionArray.append("Choice \(optionArray.count+1)")
        optionTableView.reloadData()
        tableHeightConstraint?.constant = CGFloat(optionArray.count * 35)
        
        if (queTextView.frame.height + optionTableView.frame.height + addChoiceButton.frame.height + 30) > contentHeight {
            contentHeight = queTextView.frame.height + optionTableView.frame.height + addChoiceButton.frame.height + 60
            self.scrollView.contentSize = CGSize(width:self.view.frame.width, height: contentHeight)
        }
    }
    
    @objc func changeDate() {
        
        let doneView = UIView(frame: CGRect(x: -20, y: 0, width: self.view.frame.width+20, height: 50))
        doneView.backgroundColor = .white
        let doneBtn = UIButton(frame: CGRect(x: doneView.frame.width - 75, y: 0, width: 60, height: 50))
        doneBtn.setTitleColor(.blue, for: .normal)
        doneBtn.setTitle("Done", for: .normal)
        doneBtn.addTarget(self, action: #selector(selectDate), for: .touchUpInside)
        
        doneView.addSubview(doneBtn)
        
        datePicker.frame = CGRect(x: -20, y: 50, width: self.view.frame.width+20, height: 170)
        
        dateChooserAlert = UIAlertController(title: "Choose date...", message: nil, preferredStyle: .actionSheet)
        dateChooserAlert.view.addSubview(doneView)
        dateChooserAlert.view.addSubview(datePicker)
        dateChooserAlert.addAction(UIAlertAction(title: "Done", style: .cancel, handler: { action in
            // Your actions here if "Done" clicked...
        }))
        let height: NSLayoutConstraint = NSLayoutConstraint(item: dateChooserAlert.view, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.1, constant: 200)
        dateChooserAlert.view.addConstraint(height)
        self.present(dateChooserAlert, animated: true, completion: nil)
    }
    
    @objc func selectDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.short
        dateFormatter.timeStyle = DateFormatter.Style.short
        let strDate = dateFormatter.string(from: datePicker.date)
        expiryDateButton.setTitle(strDate, for: .normal)
    }
}

extension QuickPollViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(optionArray[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return optionArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.contentView.subviews.forEach { $0.removeFromSuperview() }
        
        let tf = UITextField(frame: CGRect(x: 15, y: 0, width: cell.frame.width - 50, height: 33))
        tf.placeholder = "\(optionArray[indexPath.row])"
        tf.font = UIFont.systemFont(ofSize: 15)
        cell.addSubview(tf)
        let deleteBtn = UIButton(frame: CGRect(x: tf.frame.width + 15, y: 2.5, width: 30, height: 30))
        deleteBtn.setTitle("X", for: .normal)
        deleteBtn.setTitleColor(.black, for: .normal)
        deleteBtn.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        deleteBtn.tag = indexPath.row
        deleteBtn.addTarget(self, action: #selector(deleteRow(_:)), for: .touchUpInside)
        cell.addSubview(deleteBtn)
        tableView.separatorInset.right = 15.0
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 35.0
    }
    
    @objc func deleteRow(_ sender: UIButton) {
        optionArray.remove(at: sender.tag)
        optionTableView.reloadData()
        tableHeightConstraint?.constant = CGFloat(optionArray.count * 35)
        
        if (queTextView.frame.height + optionTableView.frame.height + addChoiceButton.frame.height + 30) < contentHeight {
            contentHeight = (queTextView.frame.height + optionTableView.frame.height + addChoiceButton.frame.height + 60)
            self.scrollView.contentSize = CGSize(width:self.view.frame.width, height: contentHeight)
        }
    }
}
