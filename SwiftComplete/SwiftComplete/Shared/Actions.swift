//
//  Actions.swift
//  SwiftComplete
//
//  Created by Ankit kumar on 11/12/24.
//


public typealias SimpleAction = () -> Void
public typealias ItemAction<T> = (T) -> Void
public typealias ItemActions<T, U> = (T, U) -> Void
public typealias ReturnAction<T, R> = (T) -> R
public typealias ReturnActions<T, U, R> = (T, U) -> R

struct TitledAction {
    let title: String
    var action: SimpleAction?
    var disabled = false
}
