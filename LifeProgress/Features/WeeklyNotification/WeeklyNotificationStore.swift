//
//  WeeklyNotificationStore.swift
//  LifeProgress
//
//  Created by Bartosz Król on 13/03/2023.
//

import Foundation
import ComposableArchitecture

/// A type alias for a store of the `WeeklyNotificationReducer`'s state and action types.
typealias WeeklyNotificationStore = Store<WeeklyNotificationReducer.State, WeeklyNotificationReducer.Action>

/// A reducer that manages the state of the weekly notification.
struct WeeklyNotificationReducer: ReducerProtocol {
    
    /// The state of the weekly notification.
    struct State: Equatable {
        /// Whether the weekly notification is enabled
        var isWeeklyNotificationEnabled = false
    }
    
    /// The actions that can be taken on the weekly notification.
    enum Action: Equatable {
        /// Indicates that the weekly notification status has changed.
        case isWeeklyNotificationChanged
        /// Indicates that the view has appeared.
        case onAppear
    }
    
    @Dependency(\.analyticsClient) var analyticsClient
    
    /// The body of the reducer that processes incoming actions and updates the state accordingly.
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .isWeeklyNotificationChanged:
                state.isWeeklyNotificationEnabled.toggle()
                NSUbiquitousKeyValueStoreHelper.saveIsWeeklyNotificationEnabled(state.isWeeklyNotificationEnabled)
                analyticsClient.sendWithPayload(
                    "weekly_notification.is_weekly_notification_changed", [
                        "isWeeklyNotificationEnabled": "\(state.isWeeklyNotificationEnabled)"
                    ])
                return .none
                
            case .onAppear:
                return .none
            }
        }
    }
}
