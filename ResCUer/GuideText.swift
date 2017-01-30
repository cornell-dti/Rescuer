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
        Book(name: "HEART ATTACK - Signs and Symptoms", details: "\n • Chest discomfort: Most heart attacks involve discomfort in the center of the chest that lasts more than a few minutes, or that goes away and comes back. It can feel like uncomfortable pressure, squeezing, fullness or pain.\n • Discomfort in other areas of the upper body. Symptoms can include pain or discomfort in one or both arms, the back, neck, jaw or stomach.\n • Shortness of breath with or without chest discomfort.\n • Other signs may include: breaking out in a cold sweat, nausea or lightheadedness.\n\nCALL 911 and send someone to get the nearest Automatic External Defibrillator (AED)")]

    let activeShooter: [Book] = [
        Book(name: "Run", details: "\n • If there is an escape path, attempt to evacuate \n • Evacuate whether others agree or not \n • Leave your belongings behind \n • Help others escape if possible \n • Prevent others from entering the area \n • Meet at a predetermined area \n • Do not leave campus \n • Call 911 when you are safe"),
        Book(name: "Hide", details: " \n • Lock and/or blockade the door \n • Hide behind large objects \n • Silence your cell phone \n • Remain very quiet"),
        Book(name: "Fight", details: " \n • Attempt to incapacitate the shooter \n • Act with physical aggression \n • Improvise weapons \n • Commit to your actions"),
        Book(name: "When Law Enforcement arrives on the Scene", details: " \n • Do exactly as the team of officers instructs \n • Do not approach the officers \n • Keep your hands visible, fingers spread, and empty.")
    ]
    
    let animalIncidents: [Book] = [
        Book(name: "If an animal such as a bat or raccoon is found inside a building:", details: "\n • Isolate it in a room by closing doors behind it and keeping people away.\n • Call Facilities Customer Service at (607) 255‐5322."),
        Book(name: "If you are unable to isolate the animal:", details: " \n • Call Cornell Police at 911 (607-255‐1111 for cell phones).\n • If an animal has bitten, scratched or had direct contact with a person, call Cornell Police at 911 as soon as possible. "),
        Book(name: "If you see a suspicious animal wandering loose on campus:", details: " \n • Call Facilities Customer Service at (607) 255‐5322. ")
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
        Book(name: "Practice preventive measures:", details: "\n • Avoid scheduling appointments for times when no one else is in the area.\n •  Remove sharp and blunt objects from desks.\n •  Try to avoid working alone after hours.\n •  If you have to work late, advise a friend or family member.\n • When working after office hours, keep doors locked and do not open the door unless you are expecting someone.\n • Do not leave money or valuable belongings lying around. Purses should be locked in a desk or cabinet.\n • Lock your office and/or lab doors when they are not in use, even when you are leaving for “just a moment.”\n • Always walk in well‐lit areas and know your surroundings.\n • If you think you are being followed, do not go home; go where there are other people. Call the Cornell Police at 911 (607-255‐1111 for cell phones) as soon as you are in a safe place.\n • Report any strange or unusual activities immediately to your supervisor and the police.\n • Report any locks, windows or lights that are in need of repair to your building coordinator.")]
    
    let bombThreat: [Book] = [
        Book(name: "Bomb Threat by Telephone", details: "\n • Record the time of call, sex of caller, phone number, and what they say.\n • Ask: \n     • When is it going to explode?\n     • Where is the bomb?\n     • What does it look like?\n     • What kind of bomb is it?\n     • What will cause it to explode?\n     • Did you place the bomb? Why?\n     • What is your name and address?\n • Write down information about the caller:\n     • Man or a woman?\n     • Approximate age?\n     • Unusual speech traits?\n     • Tone of voice and attitude?\n     • Foreign or regional accent?\n     • Background noise?\n • If the threat was delivered or left in your area, try to recall a description of the deliverer or any suspicious person(s) in the area."),
        Book(name: "General Information", details: "\n • Report the time, location and content of the threat, as well as your location and phone number. Stay on the line with the 911 dispatcher until the 911 dispatcher terminates the phone call. \n • Take no other action unless directed by Cornell Police. Do not create a panic situation. \n • Take a quick visual look around your area for any suspicious object(s).  Do not touch or move the object. \n • If you are told to evacuate the area, take your notes about the call with you.")
    ]
    
    let buildingEvacuation: [Book] = [
        Book(name: "Evacuation is required:", details: " \n • any time the fire alarm sounds, or \n • an evacuation announcement is made, or \n • a university official orders you to evacuate"),
        Book(name: "In the event of an evacuation:", details: "\n • Alert those around you who might not have heard. Turn off equipment and secure hazardous operations if possible. \n • Take your keys, jackets, and any personal items with you, you may not have access to them for hours or longer. \n • Close doors and windows. Leave room lights on. \n • Remain calm and walk to nearest exit. Do NOT use elevators."),
        Book(name: "If you are unable to leave the building due to a physical disability:", details: " \n • Go to the nearest area where there are no hazards. \n • Use a telephone to call 911 or Cornell Police at (607) 255‐1111. \n • Be sure to give them the room number so they can send help to you. \n • If possible, signal out the window to on‐site emergency responders. \n • One person may remain with you if they wish to assist you."),
        Book(name: "Do not re‐enter until given an “all clear” signal by emergency personnel.", details: "")
    ]
    
    let crime: [Book] = [
        Book(name: "Call 911 to report a crime in progress or criminal behavior to Cornell Police.", details: ""),
        Book(name: "Do not approach or attempt to apprehend the person(s) involved.", details: "\n • Take only actions necessary for self‐defense. \n • If you are safe, stay where you are until the police arrive. Otherwise, try to move to a safe location."),
        Book(name: "Report as much information as possible including:", details: " \n • Type of crime. \n • Description of persons involved, including height, weight, sex, clothing and any weapons. \n • Location of crime. \n • Direction of travel. \n • Vehicle description, including color, year, make, model and license."),
        Book(name: "Call Cornell Police at (607) 255‐1111 to report non‐emergency criminal activities", details: "")
    ]
    
    let earthquake: [Book] = [
        Book(name: "Earthquakes are rare in the Ithaca area but knowing what to do could save your life.", details: ""),
        Book(name: "DROP, COVER, and HOLD ON", details: "\nMinimize your movements to a few steps to a nearby safe place and if you are indoors, stay there until the shaking has stopped and you are sure exiting is safe."),
        Book(name: "If Indoors", details: " \n • DROP to the ground; take COVER by getting under a sturdy table or other piece of furniture; and HOLD ON until the shaking stops. If there isn’t a table or desk near you, cover your face and head with your arms and crouch in an inside corner of the building.\n\n • Stay away from glass, windows, outside doors and walls, and anything that could fall, such as lighting fixtures or furniture.\n\n • Stay in bed if you are there when the earthquake strikes. Hold on and protect your head with a pillow, unless you are under a heavy light fixture that could fall. In that case, move to the nearest safe place.\n\n • Do not use a doorway except if you know it is a strongly supported, load‐bearing doorway and it is close to you. Many inside doorways are lightly constructed and do not offer protection.\n\n • Stay inside until the shaking stops and it is safe to go outside. Do not exit a building during the shaking. Research has shown that most injuries occur when people inside buildings attempt to move to a different location inside the building or try to leave.\n\n • DO NOT use the elevators.\n\n • Be aware that the electricity may go out or the sprinkler systems or fire alarms may turn on."),
        Book(name: "If Outdoors", details: "\n • Stay there. Move away from buildings, streetlights, and utility wires. \n • Once in the open, stay there until the shaking stops. The greatest danger exists directly outside buildings, at exits and alongside exterior walls. Ground movement during an earthquake is seldom the direct cause of death or injury. Most earthquake‐related casualties result from collapsing walls, flying glass, and falling objects."),
        Book(name: "If in a Moving Vehicle", details: " \n • Stop as quickly as safety permits and stay in the vehicle. Avoid stopping near or under buildings, trees, overpasses, and utility wires. \n • Proceed cautiously once the earthquake has stopped. Avoid roads, bridges, or ramps that might have been damaged by the earthquake."),
        Book(name: "If Trapped Under Debris", details: " \n • Do not light a match, lighter, flare or other open flame. \n • Do not move about or kick up dust. \n • Cover your mouth with a handkerchief or clothing. \n • Tap on a pipe or wall so rescuers can locate you. Use a whistle if one is available. \n • Shout only as a last resort. Shouting can cause you to inhale dangerous amounts of dust.")
    ]
    
    let elevatorEmergency: [Book] = [
        Book(name: "If you find yourself in a stalled elevator:", details: " \n • Do not try to exit the elevator car. \n • Use the emergency telephone in the elevator to call for help or call (607) 255‐1111 from a cell phone or bang on the doors and shout for assistance. \n • Do not try to force the doors open or exit the car. \n • Wait for trained personnel to assist you from the elevator. "),
        Book(name: "If you hear someone calling for help from a stalled elevator car:", details: " \n • Call Cornell Police at (607) 255‐1111 or use a building emergency phone. \n • Reassure the persons in the car that you have reported the problem and help is on the way. \n • Do NOT attempt to open the elevator doors."),
    ]
    
    
    public init(_ pdfText: Int) {
        switch pdfText {
        case 0 : value = activeShooter
        case 1 : value = animalIncidents
        case 2 : value = bombThreat
        case 3 : value = buildingEvacuation
        case 4 : value = crime
        case 5 : value = earthquake
        case 6 : value = elevatorEmergency
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

