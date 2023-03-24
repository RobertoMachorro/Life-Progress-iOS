//
//  ThemeStore.swift
//  LifeProgress
//
//  Created by Bartosz Król on 15/03/2023.
//

import Foundation
import ComposableArchitecture
import SwiftUI

/// A type alias for a store of the `ThemeReducer`'s state and action types.
typealias ThemeStore = Store<ThemeReducer.State, ThemeReducer.Action>

/// A reducer that manages the state of the theme.
struct ThemeReducer: ReducerProtocol {
    
    /// The state of the theme.
    struct State: Equatable {
        /// The user's selected theme.
        var selectedTheme = UserDefaultsHelper.getTheme()
        
        /// A list of themes available in the app.
        var themes = Theme.allCases
    }
    
    /// The actions that can be taken on the theme.
    enum Action: Equatable {
        /// Indicates that the theme has changed.
        case themeChanged(Theme)
        /// Indicates that the view has appeared.
        case onAppear
    }
    
    /// The body of the reducer that processes incoming actions and updates the state accordingly.
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .themeChanged(let theme):
                state.selectedTheme = theme
                UserDefaultsHelper.saveTheme(theme)
                return .none
                
            case .onAppear:
                state.selectedTheme = UserDefaultsHelper.getTheme()
                return .none
            }
        }
    }
}