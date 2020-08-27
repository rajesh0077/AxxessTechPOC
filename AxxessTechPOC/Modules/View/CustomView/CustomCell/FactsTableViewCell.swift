//
//  FactsTableViewCell.swift
//  TelstraApp
//
//  Created by RajeshDeshmukh on 30/06/20.
//  Copyright © 2020 Rajesh Deshmukh. All rights reserved.
//

import UIKit
import SDWebImage // used for lazy loading of images
import  SnapKit

class FactsTableViewCell: UITableViewCell {
    
    /// Private Constants
    
    private struct Constant {
        static let borderWidth: CGFloat = 0.1
        static let imageHeight: CGFloat = 200
        static let cornerRadius: CGFloat = 25
        static let spacing: CGFloat = 8
        static let padding: CGFloat = 16
        static let numberOfLines: Int = 0
    }
    
    /// Computated property to set tableview cell data
    
    var rowCellModel: FactsModel? {
        didSet {
            guard let model = rowCellModel else {return}
            
            if let title = model.date {
                lblDateAsTitle.text = title
            } else {
                lblDateAsTitle.text = ""
            }
            
            if let idStr = model.id {
                lblId.text = idStr
            } else {
                lblId.text = ""
            }
            
            if let type = model.type, type == "text" {
                resetConstraintsDescriptionToOriginal()
                resetConstraintsImageViewToZero()
                if let description = model.data {
                    lblDescription.text = description
                } else {
                    lblDescription.text = ""
                    resetConstraintsDescriptionToZero()
                }
            } else if let type = model.type, type == "image" {
                lblDescription.text = ""
                resetConstraintsDescriptionToZero()
                resetConstraintsImageViewToOriginal()
                if let href = model.data {
                    if InternetConnectionManager.isConnectedToNetwork() {
                        imgView.downloaded(from: href, fileName: model.id ?? "")
                    } else {
                        imgView.image = DirectoryManager.shared.getImageFromDocumentDirectory(fileName: model.id ?? "")
                    }
                } else {
                    imgView.image = UIImage(named: AppConstants.AppImage.placeholder)
                }
            } else {
                resetConstraintsDescriptionToOriginal()
                resetConstraintsImageViewToZero()
                if let description = model.data {
                    lblDescription.text = description
                } else {
                    lblDescription.text = ""
                    resetConstraintsDescriptionToZero()
                }
            }
        }
    }
    
     /// reset constraints of Description label to zero constant
    
    func resetConstraintsDescriptionToZero() {
        lblDescription.snp.remakeConstraints({ (make) in
            make.top.equalTo(lblDateAsTitle.snp.bottom).offset(0)
            make.height.equalTo(0)
        })
    }
    
     /// reset constraints of Description label to Origina constant
    
    func resetConstraintsDescriptionToOriginal() {
        lblDescription.snp.remakeConstraints({ (make) in
            make.top.equalTo(lblDateAsTitle.snp.bottom).offset(FactsTableViewCell.Constant.spacing)
            make.left.right.equalTo(lblDateAsTitle)
        })
    }
    
    /// reset constraints of ImageView  to zero constant
    
    func resetConstraintsImageViewToZero() {
        imgView.snp.remakeConstraints({ (make) in
            make.top.equalTo(lblDescription.snp.bottom).offset(0)
            make.height.equalTo(0)
            make.bottom.equalToSuperview().offset(-1 * FactsTableViewCell.Constant.padding)
        })
    }
    
    /// reset constraints of ImageView  to Origina constant
    
    func resetConstraintsImageViewToOriginal() {
        imgView.snp.remakeConstraints({ (make) in
            make.top.equalTo(lblDescription.snp.bottom).offset(FactsTableViewCell.Constant.spacing)
            make.height.equalTo(FactsTableViewCell.Constant.imageHeight)
            make.right.left.equalTo(lblDateAsTitle)
            make.bottom.equalToSuperview().offset(-1 * FactsTableViewCell.Constant.padding)
        })
    }
    
    /// Configuration of cell
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(containerView)
        containerView.addSubview(lblDateAsTitle)
        containerView.addSubview(lblId)
        containerView.addSubview(lblDescription)
        containerView.addSubview(imgView)
        
        self.backgroundColor = .white
        containerView.backgroundColor = .white
        
        containerView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        lblDateAsTitle.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(FactsTableViewCell.Constant.padding)
            make.right.equalToSuperview().offset(-1 * FactsTableViewCell.Constant.padding)
        }
        
        lblId.snp.makeConstraints { (make) in
            make.top.right.height.equalTo(lblDateAsTitle)
            make.width.equalTo(100)
        }
        
        lblDescription.snp.makeConstraints { (make) in
            make.top.equalTo(lblDateAsTitle.snp.bottom).offset(FactsTableViewCell.Constant.spacing)
            make.left.right.equalTo(lblDateAsTitle)
        }
        
        imgView.snp.makeConstraints { (make) in
            make.top.equalTo(lblDescription.snp.bottom).offset(FactsTableViewCell.Constant.spacing)
            make.height.equalTo(FactsTableViewCell.Constant.imageHeight)
            make.right.left.equalTo(lblDateAsTitle)
            make.bottom.equalToSuperview().offset(-1 * FactsTableViewCell.Constant.padding)
        }
        
    }
    
    /// Instance of container view
    let containerView: UIView = {
        let view = UIView()
        return view
    }()
    
    /// Instance of UIImageView for image
    var imgView:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill // image will never be strecthed vertially or horizontally
        img.translatesAutoresizingMaskIntoConstraints = false // enable autolayout
        img.layer.cornerRadius = FactsTableViewCell.Constant.cornerRadius
        img.clipsToBounds = true
        img.layer.masksToBounds = true
        img.layer.borderWidth = FactsTableViewCell.Constant.borderWidth
        img.layer.borderColor = AppConstants.AppColor.kColor_DarkGray.cgColor
        return img
    }()
    
    /// Instance of UILabel for Date as Title
    let lblDateAsTitle:UILabel = {
        let label = UILabel()
        label.font = AppConstants.AppFonts.kboldSystemFont16
        label.textColor = AppConstants.AppColor.kColor_black
        label.clipsToBounds = true
        label.numberOfLines = FactsTableViewCell.Constant.numberOfLines // used for multiline
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()
    
    /// Instance of UILabel for Id
    var lblId: UILabel = {
        let label = UILabel()
        label.font =  AppConstants.AppFonts.ksystemFont14
        label.textColor =  AppConstants.AppColor.kColor_DarkGray
        label.clipsToBounds = true
        label.numberOfLines = FactsTableViewCell.Constant.numberOfLines
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.textAlignment = .right
        return label
    }()
    
    /// Instance of UILabel for description
    var lblDescription: UILabel = {
        let label = UILabel()
        label.font =  AppConstants.AppFonts.ksystemFont14
        label.textColor =  AppConstants.AppColor.kColor_DarkGray
        label.clipsToBounds = true
        label.numberOfLines = FactsTableViewCell.Constant.numberOfLines
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
