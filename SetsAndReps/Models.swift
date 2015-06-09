//
//  Workout.swift
//  SetsAndReps
//
//  Created by Michael Gallagher on 3/24/15.
//  Copyright (c) 2015 Michael Gallagher. All rights reserved.
//

import Foundation
import RealmSwift

class User : Object
{
    
    dynamic var currentWorkout = Workout()
    dynamic var weightLbs = 0.0
    
    // Use a getter function to get their weight and return lbs or kgs depending
    /**
    Returns weight in lbs or kg depending on what's set
    */
    var weight: Double {
        get {
            if usesKilograms {
                return weightLbs * 0.4535923
            } else {
                return weightLbs
            }
        }
        set {
            if usesKilograms {
                weightLbs = newValue * 0.4535923
            } else {
                weightLbs = newValue
            }
        }
    }
    dynamic var usesKilograms = false
    let activePlans = List<Plan>()
    let pastWorkouts = List<Workout>()
    
    func getUser() -> User? {
        return Realm().objects(User).first!
    }
}

class Plan : Object
{
    dynamic var name = ""
    let defaultExerciseList = List<Exercise>()
    dynamic var isPreconfigured = false
    dynamic var isActive = false
    
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    convenience init(name: String, exercises: Exercise...) {
        self.init()
        self.name = name
        for e in exercises {
            self.defaultExerciseList.append(e)
        }
        self.isPreconfigured = true
    }
    
    convenience init(nameAsPreconfigured: String) {
        self.init()
        self.name = nameAsPreconfigured
        self.isPreconfigured = true
    }
    
    func getPreconfiguredPlans() -> Results<Plan> {
        let realm = Realm()
        let preconfiguredWorkouts = realm.objects(Plan).filter("isPreconfigured == true")
        return preconfiguredWorkouts
    }
    
    func getActivePlans() -> Results<Plan> {
        let realm = Realm()
        let actives = realm.objects(Plan).filter("isActive == true")
        return actives
    }
}

class Exercise : Object
{
    dynamic var name : String = ""
    dynamic var sets = List<Sets>()
    
    convenience init(name: String, sets: [Sets]) {
        self.init()
        self.name = name
        for set in sets {
            self.sets.append(set)
        }
    }
}

class Sets : Object
{
    dynamic var reps : Int = 0
    dynamic var weight : Int = 0
    
    convenience init(reps: Int, weight: Int) {
        self.init()
        self.reps = reps
        self.weight = weight
    }
}

class Workout : Object
{
    dynamic var name: String = ""
    let exercises = List<Exercise>()
    dynamic var isCompleted = false
    dynamic var dateCompleted = NSDate(timeIntervalSince1970: 1)
    dynamic var totalReps : Int = 0
    dynamic var totalSets : Int = 0
    dynamic var totalWeightLifted : Int = 0
    
    convenience init(planToCopyFrom: Plan) {
        self.init()
        self.name = planToCopyFrom.name
//        self.exercises = planToCopyFrom.defaultExerciseList
        self.exercises.extend(planToCopyFrom.defaultExerciseList)
    }
}

class PreconfiguredWorkouts
{
    init() {
        println("Adding SS and SL to realm")
        
        // Starting Strength
        let setWithFiveReps = Sets(reps: 5, weight: 0)
        let threeSets = [Sets](count: 3, repeatedValue: setWithFiveReps)
        let startingStrength = Plan(name: "STARTING STRENGTH", exercises:
            Exercise(name: "SQUATS", sets: threeSets),
            Exercise(name: "OVERHEAD PRESS", sets: threeSets),
            Exercise(name: "BENCH PRESS", sets: threeSets))
        
        // StrongLifts 5x5
        let fiveSets = [Sets](count: 5, repeatedValue: setWithFiveReps)
        let strongLifts = Plan(name: "STRONGLIFTS 5X5", exercises:
            Exercise(name: "SQUATS", sets: fiveSets),
            Exercise(name: "OVERHEAD PRESS", sets: fiveSets),
            Exercise(name: "BENCH PRESS", sets: fiveSets))
        
        
        // HugeLift
        let hugeLift = Plan(name: "HUGELIFT", exercises:
            Exercise(name: "SQUATS", sets: threeSets),
            Exercise(name: "OVERHEAD PRESS", sets: threeSets),
            Exercise(name: "BENCH PRESS", sets: threeSets))
        
        Realm().write
        {
            Realm().add([startingStrength,strongLifts,hugeLift])
        }
    }
}
