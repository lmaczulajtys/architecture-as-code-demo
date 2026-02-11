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

                securitySchema = component "Security schema"
                
                storeSchema = component "Store schema"
            }
        }

        customer -> onlineStoreSystem.storeWebsite "Uses to buy stuff"
        storeStaff -> onlineStoreSystem.storeAdminPanel "Uses collect orders"

        onlineStoreSystem.storeWebsite -> onlineStoreSystem.apiServer "API calls" "REST"
        onlineStoreSystem.storeAdminPanel -> onlineStoreSystem.apiServer "API calls" "REST"

        onlineStoreSystem.apiServer -> onlineStoreSystem.database.securitySchema "Store user data"
        onlineStoreSystem.apiServer -> onlineStoreSystem.database.storeSchema "Get products and save orders"

        prodDeployment = deploymentEnvironment "Production" {
            deploymentNode "our-production-gcp-project" {
                tag "Google Cloud Platform - Project"

                deploymentNode "kubernetes-cluster-prod" {
                    tag "Google Cloud Platform - Kubernetes Engine" {
                    
                    deploymentNode "frontend" {
                        tag "Kubernetes - ns"

                        containerInstance onlineStoreSystem.storeWebsite {
                            tag "Kubernetes - deploy"
                        }
                        containerInstance onlineStoreSystem.storeAdminPanel {
                            tag "Kubernetes - deploy"
                        }
                    }
                    
                    deploymentNode "backend" {
                        tag "Kubernetes - ns"

                        containerInstance onlineStoreSystem.apiServer {
                            tag "Kubernetes - deploy"
                        }
                    }
                }
                    
                deploymentNode "Cloud SQL for Postgres" {
                    tag "Google Cloud Platform - Cloud SQL"

                    containerInstance onlineStoreSystem.database
                }
            }
        }
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

        component onlineStoreSystem.database {
            include *
            autoLayout lr
        }

        deployment * prodDeployment {
            include *
            autoLayout lr
        }

        themes google-cloud-platform-v1.5 kubernetes

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
