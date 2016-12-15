//
//  CollegeStudent.swift
//  ClassRoster
//
//  Created by Filiz Kurban on 12/14/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import Foundation

//
//  SeniorStudent.swift
//  ClassRoster
//
//  Created by Filiz Kurban on 12/14/16.
//  Copyright © 2016 Filiz Kurban. All rights reserved.
//

import Foundation

class CollegeStudent : Student {

    let collageName : String

    init(collageName: String, email: String, firstName: String, lastName: String) {
        self.collageName = collageName
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        //super.init(firstName: firstName, lastName: lastName, email: email)
    }

    func chooseMajor(){
        print("You are a Business student now!")
    }
}
