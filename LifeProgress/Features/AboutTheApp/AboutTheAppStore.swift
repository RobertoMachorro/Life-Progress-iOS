//
//  AboutTheAppStore.swift
//  LifeProgress
//
//  Created by Bartosz Król on 01/04/2023.
//

import Foundation
import ComposableArchitecture

/// A type alias for a store of the `AboutTheAppReducer`'s state and action types.
typealias AboutTheAppStore = Store<AboutTheAppReducer.State, AboutTheAppReducer.Action>

/// A reducer that manages the state of the about the app.
struct AboutTheAppReducer: ReducerProtocol {
    
    /// The state of the about the app.
    struct State: Equatable {
        /// The user's life information.
        var life: Life
        
        /// Whether the about calendar sheet is visible.
        var isAboutTheCalendarSheetVisible: Bool
    }
    
    /// The actions that can be taken on the about the app.
    enum Action: Equatable {
        /// Indicates that is about the app sheet should be hidden.
        case closeAboutTheCalendarSheet
    }
    
    /// The body of the reducer that processes incoming actions and updates the state accordingly.
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .closeAboutTheCalendarSheet:
                state.isAboutTheCalendarSheetVisible = false
                return .none
            }
        }
    }
}
