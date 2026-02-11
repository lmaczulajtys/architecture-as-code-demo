workspace "Demo" "Structurizr in Action" {

    !identifiers hierarchical

    configuration {
        scope softwaresystem
    }

    model {
        !include model.dsl
        !include deployment.dsl
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