//
//  WebSocketSessionDelegate.swift
//  LAN Buzzer
//
//  Created by Ben Woodworth on 12/16/18.
//

import Foundation
import Swifter

protocol WebSocketSessionDelegate {
    
    func onWebSocketSessionConnect(session: WebSocketSession)
    
    func onWebSocketSessionDisconnect(session: WebSocketSession)
    
    func onWebSocketSessionText(session: WebSocketSession, data: String)
    
    func onWebSocketSessionBinary(session: WebSocketSession, data: [UInt8])
    
    func onWebSocketSessionPong(session: WebSocketSession, data: [UInt8])
}

func websocket(
    delegate: @escaping (WebSocketSession) -> WebSocketSessionDelegate
) -> ((HttpRequest) -> HttpResponse) {
    
    var sessionDelegates = Dictionary<WebSocketSession, WebSocketSessionDelegate>()
    
    return websocket(
        text: { session, data in
            sessionDelegates[session]?.onWebSocketSessionText(session: session, data: data)
        },
        binary: { session, data in
            sessionDelegates[session]?.onWebSocketSessionBinary(session: session, data: data)
        },
        pong: { session, ping in
            sessionDelegates[session]?.onWebSocketSessionBinary(session: session, data: ping)
        },
        connected: { session in
            let sessionDelegate = delegate(session)
            sessionDelegates[session] = sessionDelegate
            sessionDelegate.onWebSocketSessionConnect(session: session)
        },
        disconnected: { session in
            let sessionDelegate = sessionDelegates[session]
            sessionDelegates[session] = nil
            sessionDelegate?.onWebSocketSessionDisconnect(session: session)
        }
    )
}

func websocket(
    delegate: WebSocketSessionDelegate
) -> ((HttpRequest) -> HttpResponse) {
    
    return websocket(
        text: { session, data in
            delegate.onWebSocketSessionText(session: session, data: data)
        },
        binary: { session, data in
            delegate.onWebSocketSessionBinary(session: session, data: data)
        },
        pong: { session, ping in
            delegate.onWebSocketSessionBinary(session: session, data: ping)
        },
        connected: { session in
            delegate.onWebSocketSessionConnect(session: session)
        },
        disconnected: { session in
            delegate.onWebSocketSessionDisconnect(session: session)
        }
    )
}
