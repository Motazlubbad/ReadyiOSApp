//
//  SkillsViewController.swift
//  Ahmed Abdallah
//
//  Created by Ahmed's Mac on 10/24/18.
//  Copyright © 2018 4a5. All rights reserved.
//

import UIKit

class SkillsViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var skillsTableView: UITableView!
    var skillsModel : [SkillsModel]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.skillsTableView.delegate = self
        self.skillsTableView.dataSource = self
        self.skillsTableView	.register(UINib(nibName: "EductionTableViewCell", bundle: nil), forCellReuseIdentifier: "EductionTableViewCell")
        getSkillsData()
        
    }
    func getSkillsData()
    {
        self.startAnimating()
        ServiceConnector.shared.connect(.getSkills, success: { (target, response) in
            print(response)
            self.stopAnimating()
            if (response["status"]).int == 200
            {
                self.skillsModel = SkillsModel.skillsFrom(json: response)
                self.skillsTableView.reloadData()
            }
        })
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let eductionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "EductionTableViewCell", for: indexPath) as! EductionTableViewCell
        eductionTableViewCell.selectionStyle = UITableViewCellSelectionStyle.none
        if let edu = self.skillsModel?[indexPath.row]
        {
            if let name = edu.name
            {
                eductionTableViewCell.educationNameLBL.text = name
            }
            if let description = edu.descriptionField
            {
                eductionTableViewCell.educationDescriptionLBL.text = description
            }
            if let period = edu.period
            {
                eductionTableViewCell.educationDurationLBL.text = period
            }
        }
        return eductionTableViewCell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let count = self.skillsModel?.count
        {
            return count
        }
        return 0
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 75
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
