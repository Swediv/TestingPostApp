//
//  DetailsInteractor.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 22.06.2021.
//

import Foundation
import UIKit

class DetailsInteractor: DetailsInteractorProtocol {
    
    weak var presenter: DetailsPresenterProtocol!
    
    var post: Item!
    
    required init(presenter: DetailsPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getAuthorName() {
        if let name = post.author?.name {
            presenter.setAuthorName(with: name)
        } else {
            presenter.setAuthorName(with: "ANONYM")
        } 
    }
    
    func getAuthorImage()  {
        guard let url = post.author?.photo?.data.extraSmall.url else { return }
        if let authorImageURL = URL(string: url) {
            ImageService.getImage(withUrl: authorImageURL) { image in
                self.presenter.setAuthorImage(with: image)
            }
        }
        
    }
    
    func getContentImage() {
        var contentImageURL: URL?
        self.post.contents.forEach({ content in
            
            switch content.type {
            case "IMAGE":
                if let url = content.data.original?.url {
                    contentImageURL = URL(string: url)
                }
            case "IMAGE_GIF":
                if let url = content.data.original?.url {
                    contentImageURL = URL(string: url)
                }
            case "VIDEO":
                if let url = content.data.previewImage?.data.medium.url {
                    contentImageURL = URL(string: url)
                }
            default:
                break
            }
        })
        
        if let imageURL = contentImageURL {
            ImageService.getImage(withUrl: imageURL) { image in
                self.presenter.setContentImage(with: image)
            }
        }
    }
    
    func getDescriptionText()  {
        var texts = [String]()
        self.post.contents.forEach({ content in
            
            
            switch content.type {
            case "TEXT":
                if let text = content.data.value {
                    texts.append(text)
                }
            default:
                break
            }
        })
        presenter.setDescriptionText(with: texts)
    }
}
