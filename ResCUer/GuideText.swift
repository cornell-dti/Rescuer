//
//  GuideText.swift
//  ResCUer
//
//  Created by Raymone Radi  on 12/8/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import Foundation

public struct GuideText {
    
    var value: [(name: String, values: [String])] = []
    
    let activeShooter: [(name: String, values: [String])] = [
        
        ("Run",
         ["If there is an escape path, attempt to evacuate EXTRA STUFF LOLOLOL HAHAHAHAHA ",
          "Evacuate whether others agree or not",
          "Leave your belongings behind",
          "Help others escape if possible",
          "Prevent others from entering the area",
          "Meet at a predetermined area, do not leave campus",
          "Call 911 when you are safe"]),
        ("Run",
         ["If there is an escape path, attempt to evacuate",
          "Evacuate whether others agree or not",
          "Leave your belongings behind",
          "Help others escape if possible",
          "Prevent others from entering the area",
          "Meet at a predetermined area, do not leave campus",
          "Call 911 when you are safe"]),
        
        ("Run",
         ["If there is an escape path, attempt to evacuate",
          "Evacuate whether others agree or not",
          "Leave your belongings behind",
          "Help others escape if possible",
          "Prevent others from entering the area",
          "Meet at a predetermined area, do not leave campus",
          "Call 911 when you are safe"]),
        ("Run",
         ["If there is an escape path, attempt to evacuate",
          "Evacuate whether others agree or not",
          "Leave your belongings behind",
          "Help others escape if possible",
          "Prevent others from entering the area",
          "Meet at a predetermined area, do not leave campus",
          "Call 911 when you are safe"]),
        
        ]
    
    


    public init(_ pdfText: String) {
        switch pdfText {
        case "Active Shooter" : value = activeShooter
        default: break
        }
        
        
    }
}
