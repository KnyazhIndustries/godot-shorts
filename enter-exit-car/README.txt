Enter and exit a car

Walk up to a car, press E to get in and E again to get out. When you get out it checks each door's exit spot with the player's collision shape first, so the car parked against the wall lets you out the other side.

The car can't be driven.

Open the folder in Godot 4.7 and press F5. WASD to walk, mouse to look, E to get in and out.

Where things are:
common/car is the car. All the getting in and out happens in car.gd
common/interaction has interactable.gd, which marks something as usable (the car has one with the prompt "Get in"), and interactor.gd, which goes on a RayCast3D on the player's camera, finds what you're looking at and uses it when you press E
common/player is a basic first person controller
ui/hud.tscn and hud.gd are the crosshair and the prompt
levels/main.tscn has one car in the open and one parked against a wall

The other folders are empty for now. It's the same layout I start every project with.

To use the car in your own game, copy common/car and common/interaction into the same place in your project, .uid files included, and add an interact action.

Your player needs to be its own scene, with a collision shape and a RayCast3D under its camera with interactor.gd on it. It has to be its own scene because the Interactor passes along the root of whatever scene it's saved in as the player.

The camera can be anywhere in your player. When you get out it switches back to whatever camera was active when you got in.

If your car is a different size, move Exits/DriverExit and Exits/PassengerExit to where the player should stand, clear of the car and about 10 cm off the floor.

Made in Godot 4.7. MIT.
