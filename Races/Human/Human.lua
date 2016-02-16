local Human = {

  StartingBuilding = "Headquarters",
  Buildings = {
    Headquarters = require( "Races/Human/Buildings/Headquarters" ),
    House        = require( "Races/Human/Buildings/House" ),
    Barracks	 = require ( "Races/Human/Buildings/Barracks" )
  }
}
return Human
