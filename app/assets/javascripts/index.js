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

  var busString = $("#bus-template").text()
  templates.busInfo = Handlebars.compile(busString);

  var bikeString = $("#bike-template").text()
  templates.bikeInfo = Handlebars.compile(bikeString);

  var bikeDashString = $("#dash-bike-template").text();
  templates.bikeDashInfo = Handlebars.compile(bikeDashString);

};

var MetroStation = Backbone.Model.extend({

    defaults: {
    name: "",
    bikes: 0,
    empty: 0,
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
    bikes: 0,
    empty: 0,
    //id: 0
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
    //id: 0
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

var BusView = Backbone.View.extend({

  events: { "click #busFavorite": "markAsFavorite"},

  tagName: "div",

  initialize: function(model) {
  	this.model = model;
    this.render();
  },

  render: function() {
    this.$el.html(templates.busInfo(this.model.viewDetails()));
  },

  markAsFavorite: function() {
  	console.log(this.model.get('name') + " was clicked");
  	var busFavoriteID = this.model.get('name') //id
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
    this.$el.attr("value", this.model.get('name')); //id
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
        //callback(data);
      }
    })
}

var displayRailResults = function(data) {

	_.each(data, function(element){
		element = new MetroStation({
			name: element.name,
			bikes: element.bikes,
			empty: element.empty
			//id: element.id
		});
		railsViews.push(new MetroView(element));
	});

    _.each(railsViews, function(element, index){
    $("#rails").append(railsViews[index].el);
    });
}

var getBusResults = function(callback) {
    $.ajax({
      url: "/dashboard/bikes.json",
      method: "GET",
      success: function(data) {
        callback(data);
        //console.log(data);
      }
    })
}

var displayBusResults = function(data) {

	_.each(data, function(element){
		element = new BusStop({
			name: element.name,
			bikes: element.bikes,
			empty: element.empty
			//id: element.id
		});
		busViews.push(new BusView(element));
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
      	console.log(data);
        callback(data);
      }
    })
}

var displayBikeResults = function(data) {

	_.each(data, function(element){
		element = new BikeStation({
			name: element.name,
			bikes: element.bikes,
			empty: element.empty
			//id: element.id
		});
		bikeViews.push(new BikeView(element));
	});

    _.each(bikeViews, function(element, index){
    $("#bike").append(bikeViews[index].el);
    });
}

var displayBikeDashResults = function(data) {

	bikeViews = [];

	_.each(data, function(element){
		element = new BikeStation({
			name: element.name,
			bikes: element.bikes,
			empty: element.empty
			//id: element.id
		});
		bikeViews.push(new BikeDashView(element));
	});

    _.each(bikeViews, function(element, index){
    $("#bikeDash").append(bikeViews[index].el);
    });
}

/*var sendFavoriteBike = function(selectedBikeStation) {
	var urlString = "/dashboard/station/" + selectedBikeStation;

	$.ajax({
      url: urlString,
      method: "POST",
      data: selectedBikeStation,
      success: function(data) {
      	console.log(data);
      }
    })
}

var sendFavoriteRail = function(selectedRailStation) {
	$.ajax({
      url: favorite rail,
      method: "GET",
      data: selectedRailStation,
      success: function(data) {
      	console.log(data);
        callback(data);
      }
    })
}

var sendFavoriteBike = function(selectedBikeStation) {
	$.ajax({
      url: favorite bike,
      method: "GET",
      data: selectedBikeStation,
      success: function(data) {
      	console.log(data);
        callback(data);
      }
    })
}*/


$(document).ready(function(){

	getTemplates();

	$("#dash").click(function(){
		getBikeResults(displayBikeDashResults);
	});


	$("#search").click(function(){
	//$("#resultsWrap").show();
	getRailResults(displayRailResults);
	getBusResults(displayBusResults);
	getBikeResults(displayBikeResults);
	});

 	$("#bikeFavorite").click(function() {
  		var selectedBikeStation = $("#bike").val();
  		console.log(selectedBikeStation);
  		//sendFavoriteBike(selectedBikeStation);
 	});

 	$("#railsFavorite").click(function() {
  		var selectedRailStation = $("#rails").val();
  		console.log(selectedRailStation);
  		//sendFavoriteRail(selectedRailStation);
 	});

});


