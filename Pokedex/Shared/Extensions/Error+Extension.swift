//
//  Error+Extension.swift
//  Pokedex
//
//  Created by André Luis Barbosa Coutinho on 05/10/22.
//

import Foundation

enum CommonError: Error {
    case serverError, networkError, decodeError, notFound, badRequest, unauthorized, forbidden

    var errorDescription: String {
        switch self {
        case .networkError:
            return "Sem conexão com a internet."
        case .serverError:
            return "Erro de conexão com o servidor, por favor tente novamente mais tarde."
        case .decodeError:
            return "Não foi possível retornar os dados, por favor tente novamente mais tarde."
        case .notFound:
            return "Nenhum dado encontrado."
        case .badRequest:
            return ""
        case .unauthorized:
            return "Não autorizado."
        case .forbidden:
            return "Acesso não permitido."
        }
    }
}

extension Error {}
