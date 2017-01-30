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
    
    let facilityProblem: [Book] = [
        Book(name: "", details: "Call 911 (607-255‐1111 for cell phones) and evacuate the building in cases of:\n\n • Fire\n • Smoke\n • Explosion\n • Structural damage or collapse\n • Uncontrolled gas leak\n • Uncontrolled chemical or hazardous material spills"),
        Book(name: "", details: "Call 911 (607-255‐1111 for cell phones) and follow dispatcher and responder instructions in cases of:\n\n • Unknown odors\n • Activated residence hall room smoke detectors\n • Hazardous conditions\n • Persons trapped in elevators"),
        Book(name: "", details: "Campus Life facility and utility problems - Call the Campus Life Facilities Office at (607) 255‐0423 or the area service center, for problems such as:\n\n • Electrical outage\n • Flooding\n • Heating or air-conditioning failure\n • Building or room security issues\n\nIf the problem occurs between 5 p.m. and 8 a.m., or on weekends, call the Residential Program staff on call."),
        Book(name: "", details: "Facility and utility problems (NON‐Campus Life facilities) ‐ Call Facilities Customer Service at (607) 255‐5322 for problems such as:\n\n • Electrical outage\n • Building flooding\n • Heating or air-conditioning failure\n • Water Leaks\n\nIn case of electrical emergencies, do not touch equipment that is smoking, sparking, tripping circuit breakers or giving electrical shocks."),
        Book(name: "", details: "Telephone or computer network failure ‐ Call your unit’s network administrator or Cornell Information Technologies at (607) 255‐8990.")
    ]
    
    let fireExplosion: [Book] = [
        Book(name: "In the event of fire, smoke, or an explosion:", details: "\n • Alert those around you to the hazard.\n • Evacuate the room, closing doors behind you as you leave.\n • Manually activate the fire alarm system as you exit the building.\n • Exit and move away from the building – DO NOT USE ELEVATORS. \n     • If you encounter smoke, stay low and if necessary use your secondary escape route.\n • Call 911 (607-255‐1111 for cell phones) from a safe location. Tell the dispatcher:\n     • Name of the building\n     • Location of the fire\n     • Description of the fire\n • ALL fires must be reported to Cornell Police, including those that have been extinguished."),
        Book(name: "If your clothing is on fire", details: "\n • Stop ‐ Drop to the ground or floor and Roll to smother flames.\n • Smother flames using a fire blanket.\n •  Drench with water from a safety shower or other source.\n •  Seek medical attention for all burns and injuries."),
        Book(name: "If you are trapped in a building", details: "\n • If possible, take shelter in a room with an outside window.\n • Close all doors and windows.\n • Use clothing, towels, or paper to block around the door or over vents to keep smoke out.\n • Stay low in smoke.\n • If there is a telephone, call 911 to report your location and situation.\n • Signal to rescuers and people outside the building by waving clothing and other light colored objects. Stay where rescuers can see you.\n • Remain calm, stay low, and be patient."),
        Book(name: "Fire Extinguishers", details: "\n • If you have been trained and it is safe to do so, you may use one extinguisher to attempt to extinguish the fire.\n • Only attempt to extinguish small fires.\n • Make sure you have a clear escape path.\n • If you have not been trained to use a fire extinguisher you must EVACUATE immediately."),
    ]
    
    let hazardous: [Book] = [
        Book(name: "", details: "For spills or incidents requiring training, procedures, or personal protective equipment beyond the abilities of the personnel present, take the following actions:"),
        Book(name: "• Alert others in the immediate area and evacuate the room.", details: "\n • If building evacuation is needed then manually activate the building fire alarm."),
        Book(name: "• Close doors as you leave the room.", details: ""),
        Book(name: "• Call 911 (607-255‐1111 from cell phones) from a safe location and provide the following information", details: "\n • Your name, telephone number, and location\n • Location of the spill\n • Name and quantity of material spilled (if known)\n • Any injuries or personal contamination"),
        Book(name: "• Use eyewash or safety showers as needed to wash spilled chemicals off your body.", details: "\n • Flush the affected areas with copious amounts of water for at least 15 minutes."),
        Book(name: "• Call 911 to report hazardous materials spills and personal contamination.", details: ""),
        Book(name: "", details: "If you are contaminated do not spread the material or contaminate others. Tell responders you have the material on you.")
        
    ]
    
    let healthEmergency: [Book] = [
        Book(name: "", details: "If you are contaminated do not spread the material or contaminate others. Tell responders you have the material on you.\n\n • Call 911\n • Do not move the person unless they are in immediate danger.\n • Provide first aid if you are trained to do so.\n • Reassure the person that help is on the way."),
        Book(name: "", details: "Students (or anyone concerned about a student): Consultation regarding medical and mental health concerns is available by phone at all times. Call Gannett Health Services at (607) 255‐5155.\n\nFaculty, staff, post‐doctoral fellows and associates, retirees, spouses/partners of employees: Consultation with a counselor is available by phone at all times. Call the Faculty and Staff Assistance Program (FSAP) at (607) 255‐2673.\n\nIf you are immediately concerned that someone may harm themselves or others, call the Cornell Police at (607) 255‐1111."),
        Book(name: "HEART ATTACK - Signs and Symptoms", details: "\n • Chest discomfort: Most heart attacks involve discomfort in the center of the chest that lasts more than a few minutes, or that goes away and comes back. It can feel like uncomfortable pressure, squeezing, fullness or pain.\n • Discomfort in other areas of the upper body. Symptoms can include pain or discomfort in one or both arms, the back, neck, jaw or stomach.\n • Shortness of breath with or without chest discomfort.\n • Other signs may include: breaking out in a cold sweat, nausea or lightheadedness.\n\nCALL 911 and send someone to get the nearest Automatic External Defibrillator (AED)")

    ]
    
    let severeWeather: [Book] = [
        Book(name: "Thunderstorm", details: "\n • Seek shelter inside of a sturdy building.\n • Avoid small sheds or isolated structures in open areas.\n •  Stay away from windows and doors, and stay off porches.\n •  Avoid contact with corded phones.\n •  Cell phones and cordless phones are fine.\n •  Avoid contact with plumbing. Do not wash hands, bathe, shower, wash dishes, etc.\n •  Avoid contact with electrical equipment and cords. Before the storm, unplug or power down sensitive equipment."),
        Book(name: "Snow / Ice", details: "\n • Avoid unnecessary travel.\n • Ensure you have supplies (food, water, etc.) to last at least several of days.\n •  Monitor University closures and special conditions:\n     • University Operating Status: cornell.edu/status\n •     University Special Conditions: cornell.edu/cuinfo/specialconditions/\n     • Or call (607) 255‐3377 for information."),
        Book(name: "Flood", details: "\n • Follow official instructions given for your area.\n • Never drive through standing water.\n • Never walk through moving water. Be aware that flash flood can occur quickly. If flooding occurs, move immediately to higher ground.\n • Ensure you have food & clean water to last you at least several days.\n • Monitor local radio/TV channels for evacuation and other directives."),
        Book(name: "Tornado", details: "\n • Take shelter inside a substantial building if a warning is issued or you see a funnel cloud:\n     • Go to the basement or an interior room on the lowest floor, preferably without windows.\n     • Closets, bathrooms, and other interior rooms are best\n     • Get under something sturdy or cover yourself with a mattress if possible.\n • If no shelter is close by, lie flat in a ditch or low spot with your hands shielding your head. Avoid overpasses and bridges.\n\nFor more information and planning guides, please visit www.ready.gov")
    ]
    
    let suspiciousMail: [Book] = [
        Book(name: "", details: " • If you receive or observe a suspicious piece of mail, package or material, do not move, open, cover or interfere with it.\n\n • Move people away from suspicious items. Avoid contaminating other areas and people.\n\n • Call Cornell Police immediately at 911 (607-255‐1111 from a cell phone) from a safe location.\n\n • Be prepared to give the location of the item, the context of what you’ve observed, and your name and phone number.\n\n • Follow directions of the Cornell Police. Do not create panic. If you are told to evacuate, follow your unit’s evacuation procedure."),
        Book(name: "", details: "Characteristics of a suspicious piece of mail or package that is received unexpectedly or is unknown and may include:\n\n • misspellings of common words\n • excessive weight\n • rigid envelope\n • foreign mail, air mail, or special delivery\n • handwritten or poorly typed address\n • incorrect titles\n • restrictive markings; such as confidential, personal, etc.\n • an excessive amount of securing material used, such as masking tape, string, etc.\n • oily stains or discoloration\n • visual distractions\n • lopsided or uneven writing\n • titles but no names\n • no return address\n • protruding wires or foil ")
    ]
    
    let workplaceViolence: [Book] = [
        Book(name: "", details: "Your actions may help calm a potentially violent situation, or they may escalate the problem."),
        Book(name: "Behave in a manner that helps calm a situation.", details: "\n • Stay calm and don’t be in a hurry.\n • Be empathetic. Show you are concerned.\n • Try to have the person and you sit down; sitting is a less aggressive position.\n • Try to be helpful, for example, schedule an appointment for a later time.\n • Give positive outcome statements, such as, “We can get this straightened out.”\n • Give positive feedback for continued talking, such as, “I’m glad you’re telling me how you feel.”\n • Stay out of arms’ reach.\n • Have limited eye contact.\n • Take notes."),
        Book(name: "Avoid exacerbating behaviors:", details: "\n • Do not patronize.\n • Do not yell or argue.\n • Do not joke or be sarcastic.\n • Do not touch the person"),
        Book(name: "If someone becomes agitated:", details: "\n • Leave the scene immediately, if possible.\n • Call the Cornell Police from a safe place.\n • Or, call a co–worker, using an agreed‐upon code word to indicate trouble."),
        Book(name: "Practice preventive measures:", details: "\n • Avoid scheduling appointments for times when no one else is in the area.\n •  Remove sharp and blunt objects from desks.\n •  Try to avoid working alone after hours.\n •  If you have to work late, advise a friend or family member.\n • When working after office hours, keep doors locked and do not open the door unless you are expecting someone.\n • Do not leave money or valuable belongings lying around. Purses should be locked in a desk or cabinet.\n • Lock your office and/or lab doors when they are not in use, even when you are leaving for “just a moment.”\n • Always walk in well‐lit areas and know your surroundings.\n • If you think you are being followed, do not go home; go where there are other people. Call the Cornell Police at 911 (607-255‐1111 for cell phones) as soon as you are in a safe place.\n • Report any strange or unusual activities immediately to your supervisor and the police.\n • Report any locks, windows or lights that are in need of repair to your building coordinator.")
    ]
    
    public init(_ pdfText: Int) {
        switch pdfText {
        case 7 : value = facilityProblem
        case 8 : value = fireExplosion
        case 9 : value = hazardous
        case 10 : value = healthEmergency
        case 11 : value = severeWeather
        case 12 : value = suspiciousMail
        case 13 : value = workplaceViolence
        default: break
        }
    }

}

