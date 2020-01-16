//
//  profileHeaderCell.swift
//  gridloka
//
//  Created by Razan Nasir on 20/09/19.
//  Copyright © 2019 Razan Nasir. All rights reserved.
//

import UIKit
import SDWebImage

class userCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
        @IBOutlet weak var GitHubUrlLbl: UILabel!
    @IBOutlet weak var accountTypeLbl: UILabel!
    @IBOutlet weak var siteAdminStatusLbl: UILabel!
    @IBOutlet weak var favBtn: UIButton!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func fillData (jsonData : UserListlModel){
        
        self.profileImage.sd_setImage(with: URL(string: jsonData.avatar_url ?? ""), placeholderImage: UIImage(named: "avatar"))
        nameLbl.text = jsonData.login
        GitHubUrlLbl.text = jsonData.url
        accountTypeLbl.text = jsonData.type
        siteAdminStatusLbl.text = String (format:"\(jsonData.site_admin ?? false)")
        if jsonData.isFav ?? false {
            self.favBtn.setImage(UIImage(named: "favIcon"), for: .normal)
        }else{
            self.favBtn.setImage(UIImage(named: "unfavIcon"), for: .normal)
        }

    }

}

