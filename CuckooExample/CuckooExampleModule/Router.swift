//
//  Router.swift
//  CuckooExample
//
//  Created by Juan Garcia on 2018-10-18.
//  Copyright © 2018 Cocoaheads. All rights reserved.
//

import Foundation

class Router {

    public static let shared: Router = Router()

    private let presenter = Presenter()

    private init() {}

    func viewDidLoad(with view: UserInterface) {
        self.presenter.userInterface = view
        self.presenter.broker = ImageBroker()
        self.presenter.imageEditor = ImageEditor()
        view.eventHandler = self.presenter
    }
}
