//
//  LifeProgressView.swift
//  LifeProgress
//
//  Created by Bartosz Król on 28/03/2023.
//

import SwiftUI

struct LifeProgressView: View {
    
    let life: Life
    let type: CalendarType
    
    var body: some View {
        switch type {
        case .life:
            lifeProgressInfo
        case .currentYear:
            yearProgressInfo
        }
    }
    
    var lifeProgressInfo: some View {
        return VStack(alignment: .leading) {
            Text("Life Progress: \(life.formattedProgress)%")
                .font(.title)
                .bold()
            Text(
                "**\(life.numberOfWeeksSpent)** weeks spent • **\(life.numberOfWeeksLeft)** weeks left"
            )
            .foregroundColor(.secondary)
        }
    }

    var yearProgressInfo: some View {
        return VStack(alignment: .leading) {
            Text("Year Progress: \(life.formattedCurrentYearProgress)%")
                .font(.title)
                .bold()

            // TODO: Make sure other strings are pluralized properly
            // Maybe use stringsdict instead
            Text(
                "^[**\(life.currentYearRemainingWeeks)** weeks](inflect: true) until your birthday"
            )
            .foregroundColor(.secondary)
        }
    }
}

//struct LifeProgressView_Previews: PreviewProvider {
//    static var previews: some View {
//        LifeProgressView()
//    }
//}
