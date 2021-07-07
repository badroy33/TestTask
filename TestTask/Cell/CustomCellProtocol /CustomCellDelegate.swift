//
//  CustomCellDelegate.swift
//  TestTask
//
//  Created by Maksym Levytskyi on 05.07.2021.
//

import UIKit

protocol CustomCellDelegate {
    func downloadButtonTappped(tag: Int)
    func resumeButtonTapped(tag: Int)
    func cancelButtonTapped(tag: Int)
    func imageViewButtonTapped(tag: Int)
}
