# Domain layer

This is Domain-layer. It responsible for business-logic, the cleanest layer. Only pure logic, no direct work with data providers (DB, API).

## Contract

This is common rules for the layer:

1. Using of external dependencies should be avoided
2. The layer should not depend on any other layer (presentation, **data**) with one exception:
    **Repositories** - the only place where data layer can be accessed. It violates CLEAN concept, but it saves a lot from boilerplate. In ideal world, repository interface is responsibility of domain layer:

    ```dart
    abstract class IUserRepository {
        User getUser();
    } 
    ```

    There's no data logic - there's no calls to API/DB, just some contract that says it can get user for us, it doesn't says how it will get it, it doesn't know the source of entities.

    **Repository implementation** is data layer. It defines how the repository will get the user for us. Because it cannot be implemented without external dependencies, it works with data providers (DB, API) directly - it cannot be the business logic.

    **But** to make it right, we need to write interface for every repository we have, even when we have only one implementation of this repository, so more code just to make it right, no any other pros.
    Instead, we can write only repository without interface, but keep in mind, that *repository contract (interface)* (class with method declarations, parameters, responses, *no method bodies*) is domain layer and *repository implementation* (method bodies itself) is data layer.

    **Data layer in domain layer can be accessed only from repositories.**

## Repositories

Repositories - the classes that suppose to work with data on domain layer language. This is an abstraction above data layer (e.g. API).

Common case - mapping data layer models (API requests / responses) to domain models (entities).
This is important, because data layer depends on external sources (like API servers). So, if they changes - data layer also changes. Domain layer should completely depend on us and should not be affected by external changes as much as possible, because domain layer represents our internal app logic.  

For example, data layer models often have String type to store numeric values. We don't need this, because we want to do calculation with these fields. Convert String to int/double in domain layer (in cubits or use cases) is expensive (because the convertation will be probably repeated several times) and is not right, because this is not actually a business logic, so in business layer we should already have models with numeric fields stored as int/double.

That's why we have data models - models for data they send to us.
And domain models - models for data we need.  

Repository is a middleman between them, the one who converts string to double.

## Entities

Entities - the models that our entire application can work with.
"An Entity is an object within our computer system that embodies a small set of critical business rules operating on Critical Business Data." (Uncle Bob, the author of Clean Architecture book)
