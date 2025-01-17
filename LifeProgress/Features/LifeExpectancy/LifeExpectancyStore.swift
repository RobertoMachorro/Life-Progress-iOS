//
//  LifeExpectancyStore.swift
//  LifeProgress
//
//  Created by Bartosz Król on 13/03/2023.
//


import Foundation
import ComposableArchitecture

/// A type alias for a store of the `LifeExpectancyReducer`'s state and action types.
typealias LifeExpectancyStore = Store<LifeExpectancyReducer.State, LifeExpectancyReducer.Action>

/// A reducer that manages the state of the life expectancy.
struct LifeExpectancyReducer: ReducerProtocol {
    
    /// The state of the birthday.
    struct State: Equatable {
        /// The user's life expectancy.
        var lifeExpectancy: Int = NSUbiquitousKeyValueStoreHelper.getLifeExpectancy()
        
        /// Whether the slider is visible.
        var isSliderVisible = false
    }
    
    /// The actions that can be taken on the life expectancy.
    enum Action: Equatable {
        /// Indicates that user has ended using slider.
        case lifeExpectancySelectionEnded(Double)
        /// Indicates that the life expectancy value has changed.
        case lifeExpectancyChanged(Double)
        /// Indicates that the slider visible status has changed.
        case isSliderVisibleChanged
        /// Indicates that the view has appeared.
        case onAppear
    }
    
    @Dependency(\.userSettingsClient) var userSettingsClient
    private enum LifeExpectancyRequestID {}
    
    @Dependency(\.mainQueue) var mainQueue
    
    /// The body of the reducer that processes incoming actions and updates the state accordingly.
    var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case .lifeExpectancySelectionEnded(let sliderValue):
                return .run { send in
                    await userSettingsClient.updateLifeExpectancy(Int(sliderValue))
                    await send(.lifeExpectancyChanged(sliderValue))
                }
                .cancellable(id: LifeExpectancyRequestID.self)
                
            case .lifeExpectancyChanged(let lifeExpectancy):
                state.lifeExpectancy = Int(lifeExpectancy)
                return .none
                
            case .isSliderVisibleChanged:
                state.isSliderVisible.toggle()
                return .none
                
            case .onAppear:
                return userSettingsClient
                    .lifeExpectancyPublisher
                    .receive(on: mainQueue)
                    .eraseToEffect()
                    .map { Action.lifeExpectancyChanged(Double($0)) }
                    .cancellable(id: LifeExpectancyRequestID.self)
            }
        }
    }
}

