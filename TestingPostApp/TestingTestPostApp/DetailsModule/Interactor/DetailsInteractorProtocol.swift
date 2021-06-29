//
//  DetailsInteractorProtocol.swift
//  TestingTestPostApp
//
//  Created by Artem Chuklov on 22.06.2021.
//

import Foundation

protocol DetailsInteractorProtocol: AnyObject {
    var post: Item! { get set }
    func getAuthorName()
    func getAuthorImage()
    func getContentImage()
    func getDescriptionText()
    
}
