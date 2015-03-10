var templates = {};
var bikeViews = [];
var busViews = [];
var railsViews = [];

/*navigator.geolocation.getCurrentPosition( function(geoposition){

   var latitude = geoposition.coords.latitude;
   var longitude = geoposition.coords.longitude;
   $("#longInput").val(longitude);
   $("#latInput").val(latitude);

});*/

var getTemplates = function(){

  var railsString = $("#rails-template").text()
  templates.railsInfo = Handlebars.compile(railsString);

  var railsDashString = $("#dash-rails-template").text();
  templates.railsDashInfo = Handlebars.compile(railsDashString);

  var busString = $("#bus-template").text()
  templates.busInfo = Handlebars.compile(busString);

  var busDashString = $("#dash-bus-template").text()
  templates.busDashInfo = Handlebars.compile(busDashString);

  var bikeString = $("#bike-template").text()
  templates.bikeInfo = Handlebars.compile(bikeString);

  var bikeDashString = $("#dash-bike-template").text();
  templates.bikeDashInfo = Handlebars.compile(bikeDashString);

};

var MetroStation = Backbone.Model.extend({

    defaults: {
    name: "",
    railArrivalArray: []
    //id: 0
  	},

  viewDetails: function() {
    var details = this.toJSON();
    return details;
  }

});

var BusStop = Backbone.Model.extend({

    defaults: {
   		name: "",
		directionText: "",
		minutes: 0,
		routeID: ""
  	},

  viewDetails: function() {
    var details = this.toJSON();
    return details;
  }

});

var BikeStation = Backbone.Model.extend({

    defaults: {
    name: "",
    bikes: 0,
    empty: 0,
    id: 0
  	},

  viewDetails: function() {
    var details = this.toJSON();
    return details;
  }

});

var MetroView = Backbone.View.extend({

  tagName: "option",

  initialize: function(model) {
  	this.model = model;
    this.render();
  },

  render: function() {
    this.$el.html(templates.bikeInfo(this.model.viewDetails()));
    this.$el.attr("value", this.model.get('name')); //id
  },

});


var MetroDashView = Backbone.View.extend({

  tagName: "div",

  initialize: function(model) {
  	this.model = model;
    this.render();
  },

  render: function() {
    this.$el.html(templates.railsDashInfo(this.model.viewDetails()));
  },

});

var BusView = Backbone.View.extend({

  tagName: "option",

  initialize: function(model) {
  	this.model = model;
    this.render();
  },

  render: function() {
    this.$el.html(templates.busInfo(this.model.viewDetails()));
    //this.$el.attr("value", this.model.get('id')); //id
  },

});

var BusDashView = Backbone.View.extend({

  tagName: "div",

  initialize: function(model) {
  	this.model = model;
    this.render();
  },

  render: function() {
    this.$el.html(templates.busDashInfo(this.model.viewDetails()));
  }

});

var BikeView = Backbone.View.extend({

  tagName: "option",

  initialize: function(model) {
  	this.model = model;
    this.render();
  },

  render: function() {
    this.$el.html(templates.bikeInfo(this.model.viewDetails()));
    this.$el.attr("value", this.model.get('id')); //id
  },

});

var BikeDashView = Backbone.View.extend({

  tagName: "div",

  initialize: function(model) {
  	this.model = model;
    this.render();
  },

  render: function() {
    this.$el.html(templates.bikeDashInfo(this.model.viewDetails()));
  },

});

var getRailResults = function(callback) {
    $.ajax({
      url: "/dashboard/rails.json",
      method: "GET",
      success: function(data) {
      	console.log(data);
        callback(data);
      }
    })
}

var displayRailDashResults = function(data) {

	railsViews = [];
	railsFavs = [];

	_.each(data.nearby_predictions, function(element){
		element = new MetroStation({
			name: element.station_name,
			railArrivalArray: element.rail_arrivals,
		});
		railsViews.push(new MetroDashView(element));
	});

    _.each(railsViews, function(element, index){
    $("#rails").append(railsViews[index].el);
    });


    /*_.each(data.nearby_predictions, function(element){
		element = new MetroStation({
			name: element.station_name,
			railArrivalArray: element.rail_arrivals,
		});
		railsFavs.push(new MetroDashView(element));
	});

    _.each(railsFavs, function(element, index){
    $("#favoriteRailsDash").append(railsFavs[index].el);
    });*/
}

var displayRailResults = function(data) {

	railsViews = [];

	_.each(data.nearby_predictions, function(element){
		element = new MetroStation({
			name: element.station_name,
			railArrivalArray: element.rail_arrivals,
		});
		railsViews.push(new MetroView(element));
		console.log(railsViews[0]);
	});

    _.each(railsViews, function(element, index){
    $("#rails").append(railsViews[index].el);
    });
}

var getBusResults = function(callback) {
    $.ajax({
      url: "/dashboard/buses.json",
      method: "GET",
      success: function(data) {
      	console.log(data);
        callback(data);
      },
    })
}

var displayBusDashResults = function(data) {

	busViews = [];
	busFavs = [];

	_.each(data.nearby_arrivals, function(element, index){

		if (element.stop_name && element.predictions.length > 0) {
		element = new BusStop({
			name: element.stop_name,
			directionText: element.predictions[0].direction_text,	
			minutes: element.predictions[0].minutes,
			routeID: element.predictions[0].route_id
		});

		busViews.push(new BusDashView(element));
		}
	});

    _.each(busViews, function(element, index){
    $("#bus").append(busViews[index].el);
    });

    /*_.each(data.nearby_arrivals, function(element, index){

		if (element.stop_name && element.predictions.length > 0) {
		element = new BusStop({
			name: element.stop_name,
			directionText: element.predictions[0].direction_text,	
			minutes: element.predictions[0].minutes,
			routeID: element.predictions[0].route_id
		});

		busFavs.push(new BusDashView(element));
		}
	});

    _.each(busFavs, function(element, index){
    $("#favoriteBus").append(busFavs[index].el);
    });*/
}

var displayBusResults = function(data) {

	_.each(data.nearby_arrivals, function(element, index){

		if (element.stop_name && element.predictions.length > 0) {
		element = new BusStop({
			name: element.stop_name,
			directionText: element.predictions[0].direction_text,	
			minutes: element.predictions[0].minutes,
			routeID: element.predictions[0].route_id
		});

		busViews.push(new BusView(element));
		}
	});

    _.each(busViews, function(element, index){
    $("#bus").append(busViews[index].el);
    });
}

var getBikeResults = function(callback) {
    $.ajax({
      url: "/dashboard/bikes/close.json",
      method: "GET",
      success: function(data) {
      	//console.log(data);
        callback(data);
      }
    })
}

var displayBikeResults = function(data) {

	_.each(data.nearby, function(element){
		element = new BikeStation({
			name: element.name,
			bikes: element.bikes,
			empty: element.empty,
			id: element.id
		});
		bikeViews.push(new BikeView(element));
	});

    _.each(bikeViews, function(element, index){
    $("#bike").append(bikeViews[index].el);
    });
}

var displayBikeDashResults = function(data) {

	bikeViews = [];
	bikeFavs = [];

	_.each(data.nearby, function(element){
		element = new BikeStation({
			name: element.name,
			bikes: element.bikes,
			empty: element.empty,
			id: element.id
		});
		bikeViews.push(new BikeDashView(element));
	});

    _.each(bikeViews, function(element, index){
    $("#bikeDash").append(bikeViews[index].el);
    });

    _.each(data.favorite, function(element){
		element = new BikeStation({
			name: element.name,
			bikes: element.bikes,
			empty: element.empty,
			id: element.id
		});
		bikeFavs.push(new BikeDashView(element));
	});

    _.each(bikeFavs, function(element, index){
    $("#favoriteBikeDash").append(bikeFavs[index].el);
    });
}

var sendFavoriteBike = function(selectedBikeStation) {

	var id = selectedBikeStation;

	$.ajax({
      url: "/dashboard/station",
      method: "POST",
      data: {id: id},
      success: function(data) {
      	alert("added bike station to favorites");
      }
    })
}

var sendFavoriteRail = function(selectedRailStation) {

	var id = selectedRailStation;

	$.ajax({
      url: "/dashboard/station",
      method: "POST",
      data: {id: id},
      success: function(data) {
      	alert("added metro station to favorites");
      }
    })
}

var sendFavoriteBus = function(selectedBusStation) {

	var id = selectedBusStation;

	$.ajax({
      url: "/dashboard/station",
      method: "POST",
      data: {id: id},
      success: function(data) {
      	alert("added bus station to favorites");
      }
    })
}


$(document).ready(function(){

	getTemplates();

	$("#refresh").click(function(){
		getBikeResults(displayBikeDashResults);
		getBusResults(displayBusDashResults);
		getRailResults(displayRailDashResults);
	});


	$("#search").click(function(){
	getRailResults(displayRailResults);
	getBusResults(displayBusResults);
	getBikeResults(displayBikeResults);
	});

 	$("#bikeFavorite").click(function() {
  		var selectedBikeStation = $("#bike").val();
  		console.log(selectedBikeStation);
  		sendFavoriteBike(selectedBikeStation);
 	});

 	$("#railsFavorite").click(function() {
  		var selectedRailStation = $("#rails").val();
  		console.log(selectedRailStation);
  		sendFavoriteRail(selectedRailStation);
 	});

 	$("#busFavorite").click(function() {
  		var selectedBusStation = $("#bus").val();
  		console.log(selectedBusStation);
  		sendFavoriteBus(selectedBusStation);
 	});

});


