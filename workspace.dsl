workspace "Demo" "Structurizr in Action" {

    !identifiers hierarchical

    configuration {
        scope softwaresystem
    }

    model {
        customer = person "Customer"

        storeStaff = person "Staff"

        onlineStoreSystem = softwareSystem "Online Store" {
            storeWebsite = container "Store Website"
            
            storeAdminPanel = container "Store Admin Panel"
            
            apiServer = container "API Server"
            
            database = container "Database" {
                tag "Database" // For better styling
            }
        }

        customer -> onlineStoreSystem.storeWebsite "Uses to buy stuff"
        storeStaff -> onlineStoreSystem.storeAdminPanel "Uses collect orders"

        onlineStoreSystem.storeWebsite -> onlineStoreSystem.apiServer "API calls" "REST"
        onlineStoreSystem.storeAdminPanel -> onlineStoreSystem.apiServer "API calls" "REST"

        onlineStoreSystem.apiServer -> onlineStoreSystem.database "Stores data"
    }

    views {
        systemContext onlineStoreSystem {
            include *
            autoLayout lr
        }

        container onlineStoreSystem {
            include *
            autoLayout lr
        }

        styles {
            element "Element" {
                color #55aa55
                stroke #55aa55
                strokeWidth 7
                shape roundedbox
            }
            element "Person" {
                shape person
            }
            element "Database" {
                shape cylinder
            }
            element "Boundary" {
                strokeWidth 5
            }
            relationship "Relationship" {
                thickness 4
            }
        }
    }
}