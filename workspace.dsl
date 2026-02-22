workspace "Demo" "Structurizr in Action" {

    !identifiers hierarchical
    !adrs adrs
    !docs docs

    configuration {
        scope softwaresystem
    }

    model {
        customer = person "Customer" "Our beloved customer"

        storeStaff = person "Store staff" "Our store's high-performing staff"

        onlineStoreSystem = softwareSystem "Online Store" "Online bookstore system" {
            
            storeWebsite = container "Store Website" "Website for store customers"
            
            storeAdminPanel = container "Store Admin Panel" "Web application for store administrators"

            apiServer = container "API Server" "Online store backend"
            
            database = container "Database" "Datastore for bookstore system" {
                tag "Database"

                securitySchema = component "Security schema" "User acounts and permissions"
                
                storeSchema = component "Store schema" "Bookstore data"
            }
        }

        customer -> onlineStoreSystem.storeWebsite "Uses to browse and buy products"
        storeStaff -> onlineStoreSystem.storeAdminPanel "Uses to collect orders"

        onlineStoreSystem.storeWebsite -> onlineStoreSystem.apiServer "API calls" "REST"
        onlineStoreSystem.storeAdminPanel -> onlineStoreSystem.apiServer "API calls" "REST"

        onlineStoreSystem.apiServer -> onlineStoreSystem.database.storeSchema "Get products and save orders"
        onlineStoreSystem.apiServer -> onlineStoreSystem.database.storeSchema "Save payments data"
        onlineStoreSystem.apiServer -> onlineStoreSystem.database.securitySchema "Store user data"
        
        paymentsSystem = softwareSystem "Online Payments" "External system handling payments" "External"
        onlineStoreSystem.apiServer -> paymentsSystem "Handle payments" "REST"






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
                    }
                }
                    
                deploymentNode "cloud-sql-instance-prod" {
                    tag "Google Cloud Platform - Cloud SQL"

                    containerInstance onlineStoreSystem.database
                }
            }

            deploymentNode "payments.example.com" {
                softwareSystemInstance paymentsSystem
            }
        }
    }

    views {
        systemContext onlineStoreSystem {
            include *
        }

        container onlineStoreSystem {
            include *
        }

        component onlineStoreSystem.database {
            include *
        }

        deployment * prodDeployment {
            include *
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
