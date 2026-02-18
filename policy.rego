package main

deny contains msg if {
	some system in input.model.softwareSystems
    some container in system.containers

	not has_owner_perspective(container)
	msg := sprintf("Container '%v' (ID: %v): 'owner' property required.", [container.name, container.id])
}

has_owner_perspective(container) if {
    some perspective in container.perspectives
    perspective.name == "owner"
}
