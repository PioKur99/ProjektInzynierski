import Foundation

class BMR {
    var age: Double
    var height: Double
    var weight: Double
    var gender: String
    var activityLevel: String
    var goal: String
    var proteinAmount: Double = 0.0
    var carbsAmount: Double = 0.0
    var fatsAmount: Double = 0.0
    var activityLevelMultiplier: Double = 0.0
    var BMRValue: Double = 0.0
    
    
    init (iAge: Double, iHeight: Double, iWeight: Double, iGender: String, iActivityLevel: String, iGoal: String) {
        self.age = iAge
        self.height = iHeight
        self.weight = iWeight
        self.gender = iGender
        self.activityLevel = iActivityLevel
        self.goal = iGoal
    }
    
    func setActivityLevelMultiplier(activityLevelSelect: String) -> Void {
        if(activityLevelSelect == "Brak aktywnosci"){
            self.activityLevelMultiplier = 1.2
        }
        
        else if (activityLevelSelect == "Niska aktywnosc"){
            self.activityLevelMultiplier = 1.3
        }
        
        else if (activityLevelSelect == "Srednia aktywnosc"){
            self.activityLevelMultiplier = 1.45
        }
        
        else if (activityLevelSelect == "Wysoka aktywnosc"){
            self.activityLevelMultiplier = 1.6
        }
        
        else {self.activityLevelMultiplier = 1.85}
    }
    
    func setBMRValue() -> Void {
        self.setActivityLevelMultiplier(activityLevelSelect: self.activityLevel)
        
        let tmpWeight = 9.99 * weight
        let tmpHeight = 6.25 * height
        let tmpAge = 4.92 * age
        
        if(self.gender == "Mezczyzna"){
            
            BMRValue = (tmpWeight + tmpHeight - tmpAge + 5) * activityLevelMultiplier
        }
        
        else {
            BMRValue = (tmpWeight + tmpHeight - tmpAge - 161) * activityLevelMultiplier
        }
        
        if(self.goal == "Utrata wagi") {self.BMRValue = self.BMRValue - 150.0}
        
        else if(self.goal == "Przybranie wagi") {self.BMRValue = self.BMRValue + 150.0}
        
        self.proteinAmount = ((0.25 * BMRValue) / 4)
        self.fatsAmount = ((0.25 * BMRValue) / 9)
        self.carbsAmount = ((0.5 * BMRValue) / 4)
    
    }
}

func convertAnyToString(word: Any) -> String {
    
    let doubleVal: Double = word as! Double
    let intVal = Int(doubleVal)
    let stringVal = "\(intVal)"
    return stringVal
}

func mapBMRValuesToStrings(inputArr: NSArray) -> [String] {
    var output: [String] = []
    for elem in inputArr {
        let intValue = convertAnyToString(word: elem)
        output.append(intValue)
    }
    return output
}
