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
