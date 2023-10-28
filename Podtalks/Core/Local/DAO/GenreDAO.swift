//
//  GenreDAO.swift
//  Podtalks
//
//  Created by Ashish Mohite + on 28/10/23.
//

import CoreData


protocol GenreDAO {
    
    func addAll(dto: [GenreDTO]) async throws -> Bool
    func add(dto: GenreDTO) async throws
    func getAll() async throws -> [GenreEntity]
    func get(by ids: [String]) async throws -> [GenreEntity]
    func deleteAll() async throws
    
}


final class PTGenreDAO: GenreDAO {
    
    func addAll(dto: [GenreDTO]) async throws -> Bool {
        await PersistentStorage.shared.persistentContainer.performBackgroundTask { privateManagedContext in
            dto.forEach { genre in
                let localGenre = GenreEntity(context: privateManagedContext)
                localGenre.id = Int16(genre.id)
                localGenre.name = genre.name
                localGenre.parent_id = Int16(genre.parentId)
            }
            if (privateManagedContext.hasChanges) {
                try? privateManagedContext.save()
            }
        }
        return true
    }
    
    func add(dto: GenreDTO) async throws {
        let entity = GenreEntity(context: PersistentStorage.shared.context)
        entity.id = Int16(dto.id)
        entity.name = dto.name
        entity.parent_id = Int16(dto.parentId)
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() async throws -> [GenreEntity] {
        let result = PersistentStorage.shared.fetchManagedObject(managedObject: GenreEntity.self)
        return result
    }
    
    func get(by ids: [String]) async throws -> [GenreEntity] {
        let fetchRequest = NSFetchRequest<GenreEntity>(entityName: "GenreEntity")
        let predicate = NSPredicate(format: "ANY id IN %@", ids)
        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest)
            return result
        } catch {
            debugPrint(error)
        }
        return []
    }
    
    func deleteAll() async throws {}
    
    private func update(entity: GenreEntity) -> Bool {
        guard let result = getGenre(by: entity.id) else {
            return false
        }
        result.id = entity.id
        result.name = entity.name
        result.parent_id = entity.parent_id
        PersistentStorage.shared.saveContext()
        return true
    }
    
    private func delete(entity: GenreEntity) -> Bool {
        guard let result = getGenre(by: entity.id) else {
            return false
        }
        PersistentStorage.shared.context.delete(result)
        PersistentStorage.shared.saveContext()
        return true
        
    }
    
    private func getGenre(by id: Int16) -> GenreEntity? {
        let fetchRequest = NSFetchRequest<GenreEntity>(entityName: "GenreEntity")
        let predicate = NSPredicate(format: "id==%@", id)
        fetchRequest.predicate = predicate
        do {
            let result = try PersistentStorage.shared.context.fetch(fetchRequest).first
            guard result != nil else {
                return nil
            }
            return result
        } catch {
            debugPrint(error)
        }
        return nil
    }
    
}
