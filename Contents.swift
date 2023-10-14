import UIKit

print("Orbiton Space Station - Operations and Drones")

//4
class StationModule {
    
    private let moduleName: String
    var drone: Drone?
    
    init(moduleName: String, drone: Drone) {
        self.moduleName = moduleName
        self.drone = drone
    }
    
    func giveDroneTask(task: String) {
        drone?.task = task
    }
}

//1
class ControlCenter: StationModule {
    
    var isLockedDown: Bool
    private let securityCode: String = "I hope aliens are real."
    
    init(isLockedDown: Bool, moduleName: String, drone: Drone) {
        self.isLockedDown = isLockedDown
        super.init(moduleName: moduleName, drone: drone)
    }
        
    func lockdown(insertPassword: String) {
        if insertPassword == securityCode {
            isLockedDown = true
        } else {
            print("The password is incorrect. Please try again.")
        }
    }
    
    func checkLockdown() {
        print("Control Center is on lockdown: \(isLockedDown).")
        
        if isLockedDown == true {
            print("The control center is on lockdown.")
        } else {
            print("The control center is NOT on lockdown.")
        }
    }
}

//2
class ResearchLab: StationModule {
    
    var labSample: [String] = []
    
    func getSample(newSample: String) {
        labSample.append(newSample)
    }
}

//3
class LifeSupportSystem: StationModule {
    
    var oxygenLevel: Int
    
    init(oxygenLevel: Int, moduleName: String, drone: Drone) {
        self.oxygenLevel = oxygenLevel
        super.init(moduleName: moduleName, drone: drone)
    }
    
    func checkOxygenLevel() {
        print("The oxygen level on the space station is: \(oxygenLevel).")
        if oxygenLevel < 90 {
            print("OXYGEN LEVEL LOW")
        } else {
            print("The oxygen levels are in the norm.")
        }
    }
}

//6
class Drone {
    
    var task: String?
    unowned var assignedModule: StationModule
    weak var missionControlLink: MissionControl?
    
    init(task: String?, assignedModule: StationModule, missionControlLink: MissionControl?) {
        self.task = task
        self.assignedModule = assignedModule
        self.missionControlLink = missionControlLink
    }
    
    func checkTask() {
        if task != nil {
            print("The drone has been assigned a task: \(String(describing: task))")
        } else {
            print("The drone currently does NOT have a task.")
        }
    }
}



//7
class OrbitonSpaceStation {
    //??????/
    let controlCenterDrone = Drone(task: nil, assignedModule: ControlCenter, missionControlLink: nil)
    let researchLabDrone = Drone(task: nil, assignedModule: ResearchLab, missionControlLink: nil)
    let lifeSupportSystemDrone = Drone(task: nil, assignedModule: LifeSupportSystem, missionControlLink: nil)
    
    let controlCenter = ControlCenter(isLockedDown: true, moduleName: "Control Center", drone: controlCenterDrone)
    let researchLab = ResearchLab(moduleName: "Research Lab", drone: researchLabDrone)
    let lifeSupportSystem = LifeSupportSystem(oxygenLevel: 97, moduleName: "Life Support System", drone: lifeSupportSystemDrone)
    

    //I understood this part as, if there is an emergency (Alien invasion/attack or oxygen level too low), put control center on lockdown.
    func inCaseOfEmergency(password: String) {
        if lifeSupportSystem.oxygenLevel < 90 {
            controlCenter.lockdown(password: password)
        }
    }
}

//8
class MissionControl {
    
    var spaceStation: OrbitonSpaceStation?
    
    init(spaceStation: OrbitonSpaceStation) {
        self.spaceStation = spaceStation
    }
    
    func connectFromEarth(orbitonSpaceStation: OrbitonSpaceStation) {
        spaceStation = orbitonSpaceStation
        print("Mission control is connected to Orbiton Space Station.")
    }
    
    func requestControlCentralStatus() {
        spaceStation?.controlCenter.checkLockdown()
    }
    
    func requestOxygenStatus() {
        spaceStation?.lifeSupportSystem.checkOxygenLevel()
    }
    
    func requestDroneStatus(module: StationModule) {
        switch module {
        case is ControlCenter:
            print("The Control Center drone's task: \(String(describing: spaceStation?.controlCenterDrone.task))")
        case is ResearchLab:
            print("The Research Lab drone's task: \(String(describing: spaceStation?.researchLabDrone.task))")
        case is LifeSupportSystem:
            print("The Life Support System drone's task: \(String(describing: spaceStation?.lifeSupportSystemDrone.task))")
        default:
            print("Incorrect Module.")
        }
    }
}


//Vaime exla mivxvdi kidev erT orbitronis clasSi vwerdi am raRaceebs da magitom amiwitlda yvelaferi (I'm crying on the inside)
let orbitron = OrbitonSpaceStation()
let missionControl = MissionControl(spaceStation: orbitron)

missionControl.connectFromEarth(orbitonSpaceStation: orbitron)
missionControl.requestControlCentralStatus()

let controlCenterTask = "Debug or something."
let researchLabTask = "Orginize samples."
let lifeSupportSystemTask = "Regulate oxygen levels."

orbitron.controlCenter.giveDroneTask(task: controlCenterTask)
orbitron.researchLab.giveDroneTask(task: researchLabTask)
orbitron.lifeSupportSystem.giveDroneTask(task: lifeSupportSystemTask)

missionControl.requestDroneStatus(module: orbitron.controlCenter)
missionControl.requestDroneStatus(module: orbitron.lifeSupportSystem)
missionControl.requestDroneStatus(module: orbitron.researchLab)

missionControl.requestOxygenStatus()

var password = "ihopealiensarereal."

orbitron.inCaseOfEmergency(password: password)
orbitron.controlCenter.checkLockdown()

password = "I hope aliens are real."
orbitron.inCaseOfEmergency(password: password)
orbitron.controlCenter.checkLockdown()
