//
//  GuideText.swift
//  ResCUer
//
//  Created by Raymone Radi  on 12/8/16.
//  Copyright © 2016 Raymone Radi . All rights reserved.
//

import Foundation

class Book: NSObject {
    
    let name: String
    let details: String
    
    init(name: String, details: String) {
        self.name = name
        self.details = details
    }
    
}

public struct GuideText {
    
    var value: [Book] = []

    let activeShooter: [Book] = [
        Book(name: "Run", details: "The Count of Monte Cristo (French: Le Comte de Monte-Cristo) is an adventure novel by French author Alexandre Dumas (père) completed in 1844. It is one of the author's most popular works, along with The Three Musketeers. Like many of his novels, it is expanded from plot outlines suggested by his collaborating ghostwriter Auguste Maquet. The story takes place in France, Italy, and islands in the Mediterranean during the historical events of 1815–1839: the era of the Bourbon Restoration through the reign of Louis-Philippe of France."),
        Book(name: "Hide", details: "Harry Potter and the Philosopher's Stone is the first novel in the Harry Potter series and J. K. Rowling's debut novel, first published in 1997 by Bloomsbury. It was published in the United States as Harry Potter and the Sorcerer's Stone by Scholastic Corporation in 1998. The plot follows Harry Potter, a young wizard who discovers his magical heritage as he makes close friends and a few enemies in his first year at the Hogwarts School of Witchcraft and Wizardry."),
        Book(name: "Fight", details: "The Monstrumologist (2009) is a young adult horror novel by Rick Yancey. It received the 2010 Michael L. Printz Honor Award for excellence in young adult literature."),
        Book(name: "When Law Enforcement arrives on the Scene", details: "Nineteen Eighty-Four, often published as 1984, is a dystopian novel by English author George Orwell published in 1949. The novel is set in Airstrip One (formerly known as Great Britain), a province of the superstate Oceania in a world of perpetual war, omnipresent government surveillance and public manipulation, dictated by a political system euphemistically named English Socialism (or Ingsoc in the government's invented language, Newspeak) under the control of a privileged elite of the Inner Party, that persecutes individualism and independent thinking as thoughtcrime.")
    ]
    
    let animalIncidents: [Book] = [
        Book(name: "NEW", details: " • This\n • Is\n • Something\n • New"),
        Book(name: "NEW", details: "THIS IS SOMETHOING NEW"),
        Book(name: "NEW", details: "THIS IS SOMETHOING NEW"),
        Book(name: "NEW", details: "THIS IS SOMETHOING NEW"),
    ]
    
    public init(_ pdfText: Int) {
        switch pdfText {
        case 0 : value = activeShooter
        case 1 : value = animalIncidents
        default: break
        }
    }

}

