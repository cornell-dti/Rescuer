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
        Book(name: "Run", details: " \n • If there is an escape path, attempt to evacuate \n • Evacuate whether others agree or not \n • Leave your belongings behind \n • Help others escape if possible \n • Prevent others from entering the area \n • Meet at a predetermined area \n • Do not leave campus \n • Call 911 when you are safe"),
        Book(name: "Hide", details: " \n • Lock and/or blockade the door \n • Hide behind large objects \n • Silence your cell phone \n • Remain very quiet"),
        Book(name: "Fight", details: " \n • Attempt to incapacitate the shooter \n • Act with physical aggression \n • Improvise weapons \n • Commit to your actions"),
        Book(name: "When Law Enforcement arrives on the Scene", details: " \n • Do exactly as the team of officers instructs \n • Do not approach the officers \n • Keep your hands visible, fingers spread, and empty.")
    ]
    
    let animalIncidents: [Book] = [
        Book(name: "If an animal such as a bat or raccoon is found inside a building:", details: " \n • Isolate it in a room by closing doors behind it and keeping people away. \n • Call Facilities Customer Service at (607)255‐5322."),
        Book(name: "If you are unable to isolate the animal:", details: " \n • Call Cornell Police at 911 (or (607)255‐1111 from a cell phone). \n • If an animal has bitten, scratched or had direct contact with a person, call Cornell Police at 911 as soon as possible. "),
        Book(name: "If you see a suspicious animal wandering loose on campus:", details: " \n • Call Facilities Customer Service at (607)255‐5322. ")
    ]
    
    let bombThreat: [Book] = [
        Book(name: "Bomb Threat by Telephone", details: " \n • Record the time of call, sex of caller, phone number (if caller ID present). \n • What did the caller say? \n        Ask: \n •     When is it going to explode? \n •     Where is the bomb? \n •     What does it look like? \n •     What kind of bomb is it? \n •     What will cause it to explode? \n •     Did you place the bomb? Why? \n •     What is your name and address? Write down information about the caller: \n •      Man or a woman? \n •      Approximate age? \n •      Unusual speech traits? \n •      Tone of voice and attitude? \n •      Foreign or regional accent? \n •      Diction? \n •      Background noise? \n • Write down information about the caller. \n • If the threat was delivered or left in your area, try to recall a description of the deliverer or any suspicious person(s) in the area." ),
        Book(name: "General Information", details: "\n • Report the time, location and content of the threat, as well as your location and phone number. Stay on the line with the 911 dispatcher until the 911 dispatcher terminates the phone call. \n • Take no other action unless directed by Cornell Police. Do not create a panic situation. \n • Take a quick visual look around your area for any suspicious object(s).  Do not touch or move the object. \n • If you are told to evacuate the area, take your notes about the call with you.")
    ]
    
    let buildingEvacuation: [Book] = [
        Book(name: "Evacuation is required:", details: " \n • any time the fire alarm sounds, or \n • an evacuation announcement is made, or \n • a university official orders you to evacuate"),
        Book(name: "In the event of an evacuation:", details: "\n • Alert those around you who might not have heard. Turn off equipment and secure hazardous operations if possible. \n • Take your keys, jackets, and any personal items with you, you may not have access to them for hours or longer. \n • Close doors and windows. Leave room lights on. \n • Remain calm and walk to nearest exit. Do NOT use elevators."),
        Book(name: "If you are unable to leave the building due to a physical disability:", details: " \n • Go to the nearest area where there are no hazards. \n • Use a telephone to call 911 or Cornell Police at (607)255‐1111. \n • Be sure to give them the room number so they can send help to you. \n • If possible, signal out the window to on‐site emergency responders. \n • One person may remain with you if they wish to assist you."),
        Book(name: "Do not re‐enter until given an “all clear” signal by emergency personnel.", details: "")
    ]
    
    let crime: [Book] = [
        Book(name: "Call 911 to report a crime in progress or criminal behavior to Cornell Police.", details: ""),
        Book(name: "Do not approach or attempt to apprehend the person(s) involved.", details: "\n • Take only actions necessary for self‐defense. \n • TIf you are safe, stay where you are until the police arrive. Otherwise, try to move to a safe location."),
        Book(name: "Report as much information as possible including:", details: " \n • Type of crime. \n • Description of persons involved, including height, weight, sex, clothing and any weapons. \n • Location of crime. \n • Direction of travel. \n • Vehicle description, including color, year, make, model and license."),
        Book(name: "Call Cornell Police at (607)255‐1111 to report non‐emergency criminal activities", details: "")
    ]
    
    let earthquake: [Book] = [
        Book(name: "Earthquakes are rare in the Ithaca area but knowing what to do could save your life.", details: " \n • DROP, COVER, and HOLD ON"),
        Book(name: "If Indoors", details: " \n • DROP to the ground; take COVER by getting under a sturdy table or other piece of furniture; and HOLD ON until the shaking stops. If there isn’t a table or desk near you, cover your face and head with your arms and crouch in an inside corner of the building. \n • Stay away from glass, windows, outside doors and walls, and anything that could fall, such as lighting fixtures or furniture. \n • Stay in bed if you are there when the earthquake strikes. Hold on and protect your head with a pillow, unless you are under a heavy light fixture that could fall. In that case, move to the nearest safe place. \n • Do not use a doorway except if you know it is a strongly supported, load‐bearing doorway and it is close to you. Many inside doorways are lightly constructed and do not offer protection. \n • Stay inside until the shaking stops and it is safe to go outside. Do not exit a building during the shaking. Research has shown that most injuries occur when people inside buildings attempt to move to a different location inside the building or try to leave. \n • DO NOT use the elevators. \n • Be aware that the electricity may go out or the sprinkler systems or fire alarms may turn on."),
        Book(name: "If Outdoors", details: "Stay there. \n • Move away from buildings, streetlights, and utility wires. \n • Once in the open, stay there until the shaking stops. The greatest danger exists directly outside buildings, at exits and alongside exterior walls. Ground movement during an earthquake is seldom the direct cause of death or injury. Most earthquake‐related casualties result from collapsing walls, flying glass, and falling objects."),
        Book(name: "If in a Moving Vehicle", details: " \n • Stop as quickly as safety permits and stay in the vehicle. Avoid stopping near or under buildings, trees, overpasses, and utility wires. \n • Proceed cautiously once the earthquake has stopped. Avoid roads, bridges, or ramps that might have been damaged by the earthquake."),
        Book(name: "If Trapped Under Debris", details: " \n • Do not light a match, lighter, flare or other open flame. \n • Do not move about or kick up dust. \n • Cover your mouth with a handkerchief or clothing. \n • Tap on a pipe or wall so rescuers can locate you. Use a whistle if one is available. \n • Shout only as a last resort. Shouting can cause you to inhale dangerous amounts of dust.")
    ]
    
    let elevatorEmergency: [Book] = [
        Book(name: "If you find yourself in a stalled elevator:", details: " \n • Do not try to exit the elevator car. \n • Use the emergency telephone in the elevator to call for help or call (607)255‐1111 from a cell phone or bang on the doors and shout for assistance. \n • Do not try to force the doors open or exit the car. \n • Wait for trained personnel to assist you from the elevator. "),
        Book(name: "If you hear someone calling for help from a stalled elevator car:", details: " \n • Call Cornell Police at (607)255‐1111 or use a building emergency phone. \n • Reassure the persons in the car that you have reported the problem and help is on the way. \n • Do NOT attempt to open the elevator doors."),
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
//        case 7 : value = facilityOrUtilityProblem
//        case 8 : value = fireSmokeExplosion
//        case 9 : value = hazardousMaterials
//        case 10 : value = medicalHealthEmergency
//        case 11 : value = severeWeather
//        case 12 : value = suspiciousMailOrPackage
//        case 13 : value = workPlaceViolence
        default: break
        }
    }

}

