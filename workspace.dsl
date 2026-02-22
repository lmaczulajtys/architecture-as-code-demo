workspace "Demo" "Structurizr in Action" {

    !identifiers hierarchical
    !adrs adrs
    !docs docs

    configuration {
        scope softwaresystem
    }

    model {
        customer = person "Customer"

        storeStaff = person "Staff"

        onlineStoreSystem = softwareSystem "Online Store" "Online bookstore system" {
            storeWebsite = container "Store Website" "Website for store customers" {
                perspectives {
                    owner "Forntend Team"
                }
            }
            
            storeAdminPanel = container "Store Admin Panel" "Web application for store administrators" {
                perspectives {
                    owner "Forntend Team"
                }
            }
            
            apiServer = container "API Server" "Online store backend" {
                properties {
                    repository "https://github.com/..."
                }
            }
            
            authManager = container "Auth Manager" "Authentication and authorization"
            
            database = container "Database" "Datastore for bookstore system" {
                tag "Database" // For better styling

                securitySchema = component "Security schema" "User acounts and permissions"
                
                storeSchema = component "Store schema" "Bookstore data"
            }
        }

        paymentsSystem = softwareSystem "Online Payments" "External system handling payments" {
            tag "External"
        }

        identityProviderSystem = softwareSystem "Identity Provider" "External identity provider" {
            tag "External"
        }

        customer -> onlineStoreSystem.storeWebsite "Uses to browse and buy products"
        storeStaff -> onlineStoreSystem.storeAdminPanel "Uses to collect orders"

        onlineStoreSystem.storeWebsite -> onlineStoreSystem.apiServer "API calls" "REST"
        onlineStoreSystem.storeAdminPanel -> onlineStoreSystem.apiServer "API calls" "REST"

        onlineStoreSystem.apiServer -> onlineStoreSystem.authManager "Authenticate user and ask for permissions" "REST"
        onlineStoreSystem.apiServer -> onlineStoreSystem.database.storeSchema "Get products and save orders"
        onlineStoreSystem.apiServer -> paymentsSystem "Handle payments" "REST"

        onlineStoreSystem.authManager -> onlineStoreSystem.database.securitySchema "Store user data"
        onlineStoreSystem.authManager -> identityProviderSystem "Authenticate customers"
        customer -> identityProviderSystem "Provide credentials"

        prodDeployment = deploymentEnvironment "Production" {
            deploymentNode "our-production-gcp-project" {
                tag "Google Cloud Platform - Project"

                deploymentNode "kubernetes-cluster-prod" {
                    tag "Google Cloud Platform - Kubernetes Engine"
                    
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
                        containerInstance onlineStoreSystem.authManager {
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

    //    themes google-cloud-platform-v1.5 kubernetes

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
            element "External" {
                color #5f646a
                stroke #5f646a
                strokeWidth 7
                shape roundedbox
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
